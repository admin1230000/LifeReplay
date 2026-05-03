// lib/data/repositories_impl/decision_repository_impl.dart

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/decision.dart';
import '../../domain/entities/parameter.dart';
import '../../domain/entities/scenario.dart';
import '../../domain/failures/failures.dart';
import '../../domain/repositories/decision_repository.dart';
import '../datasources/deepseek_datasource.dart';
import '../local/dao.dart';

/// Concrete implementation of [DecisionRepository].
///
/// Connects the Drift DAO and the DeepSeek datasource to provide
/// the full simulation workflow.
class DecisionRepositoryImpl implements DecisionRepository {
  final AppDao _dao;
  final DeepSeekDatasource _deepSeek;
  final Uuid _uuid;

  DecisionRepositoryImpl({
    required AppDao dao,
    required DeepSeekDatasource deepSeek,
    Uuid? uuid,
  })  : _dao = dao,
        _deepSeek = deepSeek,
        _uuid = uuid ?? const Uuid();

  @override
  Future<Either<Failure, SimulationResult>> runSimulation(
    SimulationInput input,
  ) async {
    // ── 1. Validate input ──────────────────────────────────────────
    if (input.title.trim().isEmpty) {
      return Left(
        ValidationFailure(message: 'Karar basligi bos olamaz.'),
      );
    }
    if (input.category.trim().isEmpty) {
      return Left(
        ValidationFailure(message: 'Kategori bos olamaz.'),
      );
    }
    if (input.parameters.isEmpty) {
      return Left(
        ValidationFailure(message: 'En az bir parametre girilmelidir.'),
      );
    }
    for (final p in input.parameters) {
      if (p.key.trim().isEmpty) {
        return Left(
          ValidationFailure(message: 'Parametre anahtari bos olamaz.'),
        );
      }
    }

    // ── 2. Call DeepSeek API ───────────────────────────────────────
    final DeepSeekResponse deepSeekResponse;
    try {
      deepSeekResponse = await _deepSeek.fetchScenarios(
        decisionTitle: input.title,
        category: input.category,
        parameters: input.parameters
            .map(
              (p) => {
                'key': p.key,
                'value': p.value,
                'unit': p.unit,
              },
            )
            .toList(),
      );
    } catch (e, stack) {
      return Left(
        ApiFailure(
          message: 'DeepSeek API cagrisi basarisiz: $e',
          originalError: e,
          stackTrace: stack,
        ),
      );
    }

    // ── 3. Persist to database ─────────────────────────────────────
    try {
      final now = DateTime.now();
      final decisionId = _uuid.v4();

      // 3a. Insert the decision
      await _dao.insertDecision(
        id: decisionId,
        title: input.title,
        category: input.category,
        createdAt: now,
        riskScore: deepSeekResponse.riskScore,
        status: SimulationStatus.completed.value,
      );

      final decision = Decision(
        id: decisionId,
        title: input.title,
        category: input.category,
        createdAt: now,
        riskScore: deepSeekResponse.riskScore,
        status: SimulationStatus.completed,
      );

      // 3b. Insert parameters
      final savedParameters = <Parameter>[];
      for (final p in input.parameters) {
        final paramId = _uuid.v4();
        await _dao.insertParameter(
          id: paramId,
          decisionId: decisionId,
          keyName: p.key,
          value: p.value,
          unit: p.unit,
        );
        savedParameters.add(
          Parameter(
            id: paramId,
            decisionId: decisionId,
            key: p.key,
            value: p.value,
            unit: p.unit,
          ),
        );
      }

      // 3c. Build scenarios from DeepSeek response
      final scenarioTypes = [
        {'type': ScenarioType.good, 'data': deepSeekResponse.goodScenario},
        {
          'type': ScenarioType.neutral,
          'data': deepSeekResponse.neutralScenario,
        },
        {'type': ScenarioType.bad, 'data': deepSeekResponse.badScenario},
      ];

      final savedScenarios = <Scenario>[];
      for (final entry in scenarioTypes) {
        final type = entry['type'] as ScenarioType;
        final data = entry['data'] as Map<String, dynamic>;

        if (data.isEmpty) continue;

        final scenarioId = _uuid.v4();
        final description = data['description'] as String? ?? '';
        final probability = (data['probability'] as num?)?.toDouble() ?? 0.0;
        final positiveEffects = (data['positive_effects'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [];
        final negativeEffects = (data['negative_effects'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            [];
        final recommendation = data['recommendation'] as String? ?? '';

        await _dao.insertScenario(
          id: scenarioId,
          decisionId: decisionId,
          type: type.value,
          description: description,
          probability: probability,
          positiveEffects: positiveEffects,
          negativeEffects: negativeEffects,
          recommendation: recommendation,
        );

        savedScenarios.add(
          Scenario(
            id: scenarioId,
            decisionId: decisionId,
            type: type,
            description: description,
            probability: probability,
            positiveEffects: positiveEffects,
            negativeEffects: negativeEffects,
            recommendation: recommendation,
          ),
        );
      }

      return Right(
        SimulationResult(
          decision: decision,
          parameters: savedParameters,
          scenarios: savedScenarios,
        ),
      );
    } catch (e, stack) {
      return Left(
        DatabaseFailure(
          message: 'Veritabani kaydi basarisiz: $e',
          originalError: e,
          stackTrace: stack,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Decision>>> getDecisionHistory() async {
    try {
      final decisions = await _dao.getAllDecisions();
      return Right(decisions);
    } catch (e, stack) {
      return Left(
        DatabaseFailure(
          message: 'Karar gecmisi alinamadi: $e',
          originalError: e,
          stackTrace: stack,
        ),
      );
    }
  }

  @override
  Stream<List<Decision>> watchAllDecisions() {
    return _dao.watchAllDecisions();
  }

  @override
  Future<Either<Failure, SimulationResult>> getDecisionById(String id) async {
    try {
      final decision = await _dao.getDecisionById(id);
      if (decision == null) {
        return Left(
          DatabaseFailure(message: 'Karar bulunamadi (id: $id).'),
        );
      }

      final parameters = await _dao.getParametersByDecisionId(id);
      final scenarios = await _dao.getScenariosByDecisionId(id);

      return Right(
        SimulationResult(
          decision: decision,
          parameters: parameters,
          scenarios: scenarios,
        ),
      );
    } catch (e, stack) {
      return Left(
        DatabaseFailure(
          message: 'Karar detayi alinamadi: $e',
          originalError: e,
          stackTrace: stack,
        ),
      );
    }
  }
}
