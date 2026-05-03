// lib/data/local/dao.dart

import 'dart:convert';

import 'package:drift/drift.dart' as drift;

import '../../domain/entities/decision.dart' as domain;
import '../../domain/entities/parameter.dart' as domain;
import '../../domain/entities/scenario.dart' as domain;
import 'database.dart' as db;

/// Data Access Object that wraps all insert / fetch operations
/// for the Decisions, Parameters, and Scenarios tables.
/// Converts between Drift row types and domain entities.
class AppDao {
  final db.AppDatabase _database;

  AppDao(this._database);

  // ──────────────────────────────────────────────
  // Decisions
  // ──────────────────────────────────────────────

  Future<void> insertDecision({
    required String id,
    required String title,
    required String category,
    required DateTime createdAt,
    double riskScore = 0.0,
    String status = 'pending',
  }) {
    return _database.into(_database.decisions).insert(
      db.DecisionsCompanion(
        id: drift.Value(id),
        title: drift.Value(title),
        category: drift.Value(category),
        createdAt: drift.Value(createdAt.millisecondsSinceEpoch),
        riskScore: drift.Value(riskScore),
        status: drift.Value(status),
      ),
    );
  }

  Future<domain.Decision?> getDecisionById(String id) async {
    final row =
        await (_database.select(_database.decisions)
              ..where((t) => t.id.equals(id)))
            .getSingleOrNull();
    if (row == null) return null;
    return _toDomainDecision(row);
  }

  Future<List<domain.Decision>> getAllDecisions() async {
    final rows = await _database.select(_database.decisions).get();
    return rows.map(_toDomainDecision).toList();
  }

  /// Returns a reactive stream that emits the full list of decisions
  /// whenever any change occurs in the decisions table.
  Stream<List<domain.Decision>> watchAllDecisions() {
    return _database.select(_database.decisions).watch().map(
          (rows) => rows.map(_toDomainDecision).toList(),
        );
  }

  Future<int> updateDecision(domain.Decision decision) {
    return (_database.update(_database.decisions)
          ..where((t) => t.id.equals(decision.id)))
        .write(_toCompanionDecision(decision));
  }

  Future<int> deleteDecision(String id) {
    return (_database.delete(_database.decisions)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  // ──────────────────────────────────────────────
  // Parameters
  // ──────────────────────────────────────────────

  Future<void> insertParameter({
    required String id,
    required String decisionId,
    required String keyName,
    String? value,
    String unit = '',
  }) {
    return _database.into(_database.parameters).insert(
      db.ParametersCompanion(
        id: drift.Value(id),
        decisionId: drift.Value(decisionId),
        keyName: drift.Value(keyName),
        value: drift.Value(value ?? ''),
        unit: drift.Value(unit),
      ),
    );
  }

  Future<domain.Parameter?> getParameterById(String id) async {
    final row =
        await (_database.select(_database.parameters)
              ..where((t) => t.id.equals(id)))
            .getSingleOrNull();
    if (row == null) return null;
    return _toDomainParameter(row);
  }

  Future<List<domain.Parameter>> getParametersByDecisionId(
      String decisionId) async {
    final rows = await (_database.select(_database.parameters)
          ..where((t) => t.decisionId.equals(decisionId)))
        .get();
    return rows.map(_toDomainParameter).toList();
  }

  Future<int> updateParameter(domain.Parameter parameter) {
    return (_database.update(_database.parameters)
          ..where((t) => t.id.equals(parameter.id)))
        .write(_toCompanionParameter(parameter));
  }

  Future<int> deleteParameter(String id) {
    return (_database.delete(_database.parameters)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  // ──────────────────────────────────────────────
  // Scenarios
  // ──────────────────────────────────────────────

  Future<void> insertScenario({
    required String id,
    required String decisionId,
    required String type,
    required String description,
    required double probability,
    List<String> positiveEffects = const [],
    List<String> negativeEffects = const [],
    String recommendation = '',
  }) {
    return _database.into(_database.scenarios).insert(
      db.ScenariosCompanion(
        id: drift.Value(id),
        decisionId: drift.Value(decisionId),
        type: drift.Value(type),
        description: drift.Value(description),
        probability: drift.Value(probability),
        positiveEffects: drift.Value(jsonEncode(positiveEffects)),
        negativeEffects: drift.Value(jsonEncode(negativeEffects)),
        recommendation: drift.Value(recommendation),
      ),
    );
  }

  Future<domain.Scenario?> getScenarioById(String id) async {
    final row =
        await (_database.select(_database.scenarios)
              ..where((t) => t.id.equals(id)))
            .getSingleOrNull();
    if (row == null) return null;
    return _toDomainScenario(row);
  }

  Future<List<domain.Scenario>> getScenariosByDecisionId(
      String decisionId) async {
    final rows = await (_database.select(_database.scenarios)
          ..where((t) => t.decisionId.equals(decisionId)))
        .get();
    return rows.map(_toDomainScenario).toList();
  }

  Future<int> updateScenario(domain.Scenario scenario) {
    return (_database.update(_database.scenarios)
          ..where((t) => t.id.equals(scenario.id)))
        .write(_toCompanionScenario(scenario));
  }

  Future<int> deleteScenario(String id) {
    return (_database.delete(_database.scenarios)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  // ──────────────────────────────────────────────
  // Conversion helpers
  // ──────────────────────────────────────────────

  domain.Decision _toDomainDecision(db.Decision row) {
    return domain.Decision(
      id: row.id,
      title: row.title,
      category: row.category,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
      riskScore: row.riskScore,
      status: domain.SimulationStatus.fromValue(row.status),
    );
  }

  db.DecisionsCompanion _toCompanionDecision(domain.Decision decision) {
    return db.DecisionsCompanion(
      id: drift.Value(decision.id),
      title: drift.Value(decision.title),
      category: drift.Value(decision.category),
      createdAt: drift.Value(decision.createdAt.millisecondsSinceEpoch),
      riskScore: drift.Value(decision.riskScore),
      status: drift.Value(decision.status.value),
    );
  }

  domain.Parameter _toDomainParameter(db.Parameter row) {
    return domain.Parameter(
      id: row.id,
      decisionId: row.decisionId,
      key: row.keyName,
      value: row.value,
      unit: row.unit,
    );
  }

  db.ParametersCompanion _toCompanionParameter(domain.Parameter parameter) {
    return db.ParametersCompanion(
      id: drift.Value(parameter.id),
      decisionId: drift.Value(parameter.decisionId),
      keyName: drift.Value(parameter.key),
      value: drift.Value(parameter.value?.toString() ?? ''),
      unit: drift.Value(parameter.unit),
    );
  }

  domain.Scenario _toDomainScenario(db.Scenario row) {
    return domain.Scenario(
      id: row.id,
      decisionId: row.decisionId,
      type: domain.ScenarioType.fromValue(row.type),
      description: row.description,
      probability: row.probability,
      positiveEffects: _decodeStringList(row.positiveEffects),
      negativeEffects: _decodeStringList(row.negativeEffects),
      recommendation: row.recommendation,
    );
  }

  db.ScenariosCompanion _toCompanionScenario(domain.Scenario scenario) {
    return db.ScenariosCompanion(
      id: drift.Value(scenario.id),
      decisionId: drift.Value(scenario.decisionId),
      type: drift.Value(scenario.type.value),
      description: drift.Value(scenario.description),
      probability: drift.Value(scenario.probability),
      positiveEffects: drift.Value(jsonEncode(scenario.positiveEffects)),
      negativeEffects: drift.Value(jsonEncode(scenario.negativeEffects)),
      recommendation: drift.Value(scenario.recommendation),
    );
  }

  List<String> _decodeStringList(String json) {
    if (json.isEmpty) return [];
    try {
      final list = jsonDecode(json) as List<dynamic>;
      return list.map((e) => e as String).toList();
    } catch (_) {
      return [];
    }
  }
}
