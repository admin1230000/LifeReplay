// lib/domain/usecases/run_simulation.dart

import 'package:fpdart/fpdart.dart';

import '../entities/decision.dart';
import '../entities/parameter.dart';
import '../entities/scenario.dart';
import '../failures/failures.dart';
import '../repositories/decision_repository.dart';

/// Result emitted by [RunSimulation].
class SimulationOutput {
  final Decision decision;
  final List<Parameter> parameters;
  final List<Scenario> scenarios;

  const SimulationOutput({
    required this.decision,
    required this.parameters,
    required this.scenarios,
  });
}

/// Use case that orchestrates the full simulation workflow:
///
/// 1. Validates the input parameters.
/// 2. Calls the DeepSeek API via the repository to generate scenarios.
/// 3. Persists the decision, parameters, and scenarios to the database.
/// 4. Returns the complete result or a [Failure].
class RunSimulation {
  final DecisionRepository _repository;

  RunSimulation(this._repository);

  /// Executes the simulation.
  ///
  /// [title] – the decision title.
  /// [category] – the decision category (e.g. Financial, Career, Health).
  /// [parameters] – list of parameter inputs (key, value, unit).
  Future<Either<Failure, SimulationOutput>> call({
    required String title,
    required String category,
    required List<ParameterInput> parameters,
  }) async {
    final input = SimulationInput(
      title: title,
      category: category,
      parameters: parameters,
    );

    final result = await _repository.runSimulation(input);

    return result.fold(
      (failure) => Left(failure),
      (success) => Right(
        SimulationOutput(
          decision: success.decision,
          parameters: success.parameters,
          scenarios: success.scenarios,
        ),
      ),
    );
  }
}

/// Use case that retrieves the decision history.
class GetDecisionHistory {
  final DecisionRepository _repository;

  GetDecisionHistory(this._repository);

  Future<Either<Failure, List<Decision>>> call() {
    return _repository.getDecisionHistory();
  }
}

/// Use case that retrieves a single decision with its parameters and scenarios.
class GetDecisionById {
  final DecisionRepository _repository;

  GetDecisionById(this._repository);

  Future<Either<Failure, SimulationOutput>> call(String id) async {
    final result = await _repository.getDecisionById(id);
    return result.fold(
      (failure) => Left(failure),
      (success) => Right(
        SimulationOutput(
          decision: success.decision,
          parameters: success.parameters,
          scenarios: success.scenarios,
        ),
      ),
    );
  }
}
