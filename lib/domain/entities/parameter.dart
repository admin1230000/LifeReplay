// lib/domain/entities/parameter.dart

/// Immutable domain entity representing a single parameter
/// associated with a decision.
class Parameter {
  final String id; // UUID v4
  final String decisionId; // FK -> Decision.id
  final String key;
  final dynamic value;
  final String unit; // e.g. "TL", "months", "%"

  const Parameter({
    required this.id,
    required this.decisionId,
    required this.key,
    this.value,
    this.unit = '',
  });

  Parameter copyWith({
    String? id,
    String? decisionId,
    String? key,
    dynamic value,
    String? unit,
  }) {
    return Parameter(
      id: id ?? this.id,
      decisionId: decisionId ?? this.decisionId,
      key: key ?? this.key,
      value: value ?? this.value,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'decision_id': decisionId,
      'key_name': key,
      'value': value?.toString() ?? '',
      'unit': unit,
    };
  }

  factory Parameter.fromMap(Map<String, dynamic> map) {
    return Parameter(
      id: map['id'] as String,
      decisionId: map['decision_id'] as String,
      key: map['key_name'] as String,
      value: map['value'],
      unit: map['unit'] as String? ?? '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Parameter &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          decisionId == other.decisionId &&
          key == other.key &&
          value == other.value &&
          unit == other.unit;

  @override
  int get hashCode => Object.hash(id, decisionId, key, value, unit);

  @override
  String toString() {
    return 'Parameter(id: $id, key: $key, value: $value, unit: $unit)';
  }
}
