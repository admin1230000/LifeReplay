// lib/data/datasources/deepseek_datasource.dart

import 'dart:convert';

import 'package:dio/dio.dart';

/// Parsed response from the DeepSeek API containing three scenarios
/// and overall risk assessment.
class DeepSeekResponse {
  final Map<String, dynamic> goodScenario;
  final Map<String, dynamic> neutralScenario;
  final Map<String, dynamic> badScenario;
  final double riskScore;
  final String riskLevel; // "Low", "Medium", "High"
  final String summary;

  const DeepSeekResponse({
    required this.goodScenario,
    required this.neutralScenario,
    required this.badScenario,
    required this.riskScore,
    required this.riskLevel,
    required this.summary,
  });

  factory DeepSeekResponse.fromJson(Map<String, dynamic> json) {
    return DeepSeekResponse(
      goodScenario: json['good_scenario'] as Map<String, dynamic>? ?? {},
      neutralScenario: json['neutral_scenario'] as Map<String, dynamic>? ?? {},
      badScenario: json['bad_scenario'] as Map<String, dynamic>? ?? {},
      riskScore: (json['risk_score'] as num?)?.toDouble() ?? 0.0,
      riskLevel: json['risk_level'] as String? ?? 'Medium',
      summary: json['summary'] as String? ?? '',
    );
  }
}

/// Datasource that communicates with the DeepSeek API (DeepSeek-V3)
/// using the OpenAI-compatible chat completions endpoint via Dio.
///
/// Includes retry logic for 5xx and 429 errors via Dio interceptors.
class DeepSeekDatasource {
  final Dio _dio;

  static const _baseUrl = 'https://api.deepseek.com/v1/chat/completions';
  static const _model = 'deepseek-chat';

  DeepSeekDatasource({
    required String apiKey,
    Dio? dio,
  }) : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'https://api.deepseek.com',
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer $apiKey',
                },
              ),
            )..interceptors.addAll([
                _RetryInterceptor(),
                _ErrorInterceptor(),
              ]);

  /// Calls the DeepSeek API and returns the parsed response.
  Future<DeepSeekResponse> fetchScenarios({
    required String decisionTitle,
    required String category,
    required List<Map<String, dynamic>> parameters,
  }) async {
    final paramsText = parameters
        .asMap()
        .entries
        .map(
          (e) =>
              '${e.value['key']}: ${e.value['value']} ${e.value['unit'] ?? ''}',
        )
        .join('\n');

    final userPrompt = '''
Decision: $decisionTitle
Category: $category
Parameters:
$paramsText

Return JSON:
{
  "good_scenario":    { "description": "", "probability": 0.0, "positive_effects": [], "negative_effects": [], "recommendation": "" },
  "neutral_scenario": { "description": "", "probability": 0.0, "positive_effects": [], "negative_effects": [], "recommendation": "" },
  "bad_scenario":     { "description": "", "probability": 0.0, "positive_effects": [], "negative_effects": [], "recommendation": "" },
  "risk_score": 0.0,
  "risk_level": "Low|Medium|High",
  "summary": ""
}
''';

    final systemPrompt = '''
You are a life decision analyst. Always respond ONLY in valid JSON. Never add explanation outside the JSON block.

ONEMLI KURAL: Tum metin alanlari (description, positive_effects, negative_effects, recommendation, summary) KESINLIKLE %100 TURKCE olmalidir.
''';

    final payload = {
      'model': _model,
      'response_format': {'type': 'json_object'},
      'temperature': 0.7,
      'messages': [
        {'role': 'system', 'content': systemPrompt},
        {'role': 'user', 'content': userPrompt},
      ],
    };

    final response = await _dio.post(
      _baseUrl,
      data: payload,
    );

    final decoded = response.data as Map<String, dynamic>;
    final content =
        decoded['choices']?[0]?['message']?['content'] as String?;

    if (content == null || content.isEmpty) {
      throw Exception('DeepSeek returned an empty response.');
    }

    try {
      final Map<String, dynamic> json = jsonDecode(content) as Map<String, dynamic>;
      return DeepSeekResponse.fromJson(json);
    } catch (e) {
      throw Exception('JSON parse error: $e');
    }
  }
}

/// Dio interceptor that retries on 5xx and 429 status codes.
class _RetryInterceptor extends Interceptor {
  final int _maxRetries = 3;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      for (var attempt = 1; attempt <= _maxRetries; attempt++) {
        await Future.delayed(Duration(seconds: attempt * 2));
        try {
          final dio = Dio();
          final response = await dio.fetch(err.requestOptions);
          if (response.statusCode != null && response.statusCode! < 500) {
            return handler.resolve(response);
          }
        } catch (_) {
          // Continue retrying
        }
      }
    }
    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    if (err.response == null) return true; // Network error
    final code = err.response!.statusCode ?? 0;
    return code == 429 || code >= 500;
  }
}

/// Dio interceptor that wraps errors with descriptive messages.
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode ?? 0;
    final body = err.response?.data.toString() ?? 'No response body';

    if (statusCode == 401 || statusCode == 403) {
      handler.next(
        DioException(
          requestOptions: err.requestOptions,
          error: 'DeepSeek API authentication failed. Check your API key.',
          response: err.response,
          type: err.type,
        ),
      );
    } else if (statusCode == 429) {
      handler.next(
        DioException(
          requestOptions: err.requestOptions,
          error: 'DeepSeek API rate limit exceeded. Please try again later.',
          response: err.response,
          type: err.type,
        ),
      );
    } else if (statusCode >= 500) {
      handler.next(
        DioException(
          requestOptions: err.requestOptions,
          error: 'DeepSeek API server error ($statusCode): $body',
          response: err.response,
          type: err.type,
        ),
      );
    } else {
      handler.next(err);
    }
  }
}
