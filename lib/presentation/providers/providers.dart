// lib/presentation/providers/providers.dart

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/deepseek_datasource.dart';
import '../../data/local/dao.dart';
import '../../data/local/database.dart' hide Decision, Parameter, Scenario;
import '../../data/repositories_impl/decision_repository_impl.dart';
import '../../domain/entities/decision.dart';
import '../../domain/entities/parameter.dart';
import '../../domain/entities/scenario.dart';
import '../../domain/repositories/decision_repository.dart';
import '../../domain/usecases/run_simulation.dart';

part 'providers.g.dart';

@riverpod
AppDatabase appDatabase(AppDatabaseRef ref) {
  return AppDatabase();
}

@riverpod
AppDao appDao(AppDaoRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return AppDao(db);
}

@riverpod
DeepSeekDatasource deepSeekDatasource(DeepSeekDatasourceRef ref) {
  final apiKey = dotenv.env['DEEPSEEK_API_KEY'] ?? '';
  return DeepSeekDatasource(apiKey: apiKey);
}

@riverpod
DecisionRepository decisionRepository(DecisionRepositoryRef ref) {
  final dao = ref.watch(appDaoProvider);
  final deepSeek = ref.watch(deepSeekDatasourceProvider);
  return DecisionRepositoryImpl(dao: dao, deepSeek: deepSeek);
}

@riverpod
RunSimulation runSimulation(RunSimulationRef ref) {
  final repo = ref.watch(decisionRepositoryProvider);
  return RunSimulation(repo);
}

@riverpod
GetDecisionHistory getDecisionHistory(GetDecisionHistoryRef ref) {
  final repo = ref.watch(decisionRepositoryProvider);
  return GetDecisionHistory(repo);
}

@riverpod
GetDecisionById getDecisionById(GetDecisionByIdRef ref) {
  final repo = ref.watch(decisionRepositoryProvider);
  return GetDecisionById(repo);
}

// ──────────────────────────────────────────────
// Simulation state
// ──────────────────────────────────────────────

sealed class SimulationState {
  const SimulationState();
}

class SimulationInitial extends SimulationState {
  const SimulationInitial();
}

class SimulationLoading extends SimulationState {
  const SimulationLoading();
}

class SimulationSuccess extends SimulationState {
  final Decision decision;
  final List<Parameter> parameters;
  final List<Scenario> scenarios;

  const SimulationSuccess({
    required this.decision,
    required this.parameters,
    required this.scenarios,
  });
}

class SimulationError extends SimulationState {
  final String message;
  const SimulationError(this.message);
}

/// Controller that holds the current simulation result.
/// Uses keepAlive so the result survives tab switches.
@Riverpod(keepAlive: true)
class SimulationController extends _$SimulationController {
  @override
  SimulationState build() => const SimulationInitial();

  Future<void> run({
    required String title,
    required String category,
    required List<ParameterInput> parameters,
  }) async {
    state = const SimulationLoading();

    final useCase = ref.read(runSimulationProvider);
    final result = await useCase(
      title: title,
      category: category,
      parameters: parameters,
    );

    result.fold(
      (failure) {
        state = SimulationError(failure.message);
      },
      (output) {
        state = SimulationSuccess(
          decision: output.decision,
          parameters: output.parameters,
          scenarios: output.scenarios,
        );
      },
    );
  }

  void reset() {
    state = const SimulationInitial();
  }
}

// ──────────────────────────────────────────────
// History (reactive stream)
// ──────────────────────────────────────────────

/// Reactive stream provider that watches the decisions table.
/// Automatically emits a new list whenever a decision is inserted/updated/deleted.
@riverpod
Stream<List<Decision>> decisionHistoryStream(DecisionHistoryStreamRef ref) {
  final repo = ref.watch(decisionRepositoryProvider);
  return repo.watchAllDecisions();
}

/// Fetches a single historical decision (with parameters and scenarios) by its ID.
/// Returns null if the decision is not found.
@riverpod
Future<SimulationOutput?> historyDetail(HistoryDetailRef ref, String id) async {
  final useCase = ref.watch(getDecisionByIdProvider);
  final result = await useCase(id);
  return result.fold(
    (failure) => null,
    (output) => output,
  );
}
