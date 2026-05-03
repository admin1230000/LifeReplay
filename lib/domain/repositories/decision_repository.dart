// lib/domain/repositories/decision_repository.dart

import 'package:fpdart/fpdart.dart';

import '../entities/decision.dart';
import '../entities/parameter.dart';
import '../entities/scenario.dart';
import '../failures/failures.dart';

/// Input model for a single parameter in a simulation.
class ParameterInput {
  final String key;
  final String value;
  final String unit;

  const ParameterInput({
    required this.key,
    this.value = '',
    this.unit = '',
  });
}

/// Input model for running a simulation.
class SimulationInput {
  final String title;
  final String category;
  final List<ParameterInput> parameters;

  const SimulationInput({
    required this.title,
    required this.category,
    required this.parameters,
  });
}

/// Result of a successful simulation.
class SimulationResult {
  final Decision decision;
  final List<Parameter> parameters;
  final List<Scenario> scenarios;

  const SimulationResult({
    required this.decision,
    required this.parameters,
    required this.scenarios,
  });
}

/// Abstract repository for decision-related operations.
abstract class DecisionRepository {
  /// Runs a full simulation:
  /// 1. Validates input
  /// 2. Calls DeepSeek API to generate scenarios
  /// 3. Persists the decision, parameters, and scenarios to the database
  /// 4. Returns the complete [SimulationResult]
  Future<Either<Failure, SimulationResult>> runSimulation(
    SimulationInput input,
  );

  /// Retrieves all past decisions from the database.
  Future<Either<Failure, List<Decision>>> getDecisionHistory();

  /// Returns a reactive stream of all decisions from the database.
  /// Emits a new list whenever the decisions table changes.
  Stream<List<Decision>> watchAllDecisions();

  /// Retrieves a single decision by its [id], including its parameters and scenarios.
  Future<Either<Failure, SimulationResult>> getDecisionById(String id);
}
