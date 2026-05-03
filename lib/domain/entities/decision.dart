// lib/domain/entities/decision.dart

import 'parameter.dart';
import 'scenario.dart';

/// Represents the current status of a simulation.
enum SimulationStatus {
  pending,
  completed,
  failed;

  String get value => name;

  static SimulationStatus fromValue(String value) {
    return SimulationStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => SimulationStatus.pending,
    );
  }
}

/// Immutable domain entity representing a life decision to be simulated.
class Decision {
  final String id; // UUID v4
  final String title;
  final String category; // e.g. Financial, Career, Health
  final DateTime createdAt;
  final List<Parameter> parameters;
  final List<Scenario> scenarios;
  final double riskScore; // 0.0 to 1.0
  final SimulationStatus status;

  const Decision({
    required this.id,
    required this.title,
    required this.category,
    required this.createdAt,
    this.parameters = const [],
    this.scenarios = const [],
    this.riskScore = 0.0,
    this.status = SimulationStatus.pending,
  });

  Decision copyWith({
    String? id,
    String? title,
    String? category,
    DateTime? createdAt,
    List<Parameter>? parameters,
    List<Scenario>? scenarios,
    double? riskScore,
    SimulationStatus? status,
  }) {
    return Decision(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      parameters: parameters ?? this.parameters,
      scenarios: scenarios ?? this.scenarios,
      riskScore: riskScore ?? this.riskScore,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'created_at': createdAt.toIso8601String(),
      'risk_score': riskScore,
      'status': status.value,
    };
  }

  factory Decision.fromMap(Map<String, dynamic> map) {
    return Decision(
      id: map['id'] as String,
      title: map['title'] as String,
      category: map['category'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      riskScore: (map['risk_score'] as num?)?.toDouble() ?? 0.0,
      status: SimulationStatus.fromValue(map['status'] as String? ?? 'pending'),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Decision &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          category == other.category &&
          createdAt == other.createdAt &&
          riskScore == other.riskScore &&
          status == other.status;

  @override
  int get hashCode =>
      Object.hash(id, title, category, createdAt, riskScore, status);

  @override
  String toString() {
    return 'Decision(id: $id, title: $title, category: $category, '
        'riskScore: $riskScore, status: $status)';
  }
}
