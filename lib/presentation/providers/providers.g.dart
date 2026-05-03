// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'68c9ad772c198d1a34d2dcccc0a6a35f43092fd5';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = AutoDisposeProvider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDatabaseRef = AutoDisposeProviderRef<AppDatabase>;
String _$appDaoHash() => r'34e2a2bcb17b63b3364de9a33782deb919ebcf0a';

/// See also [appDao].
@ProviderFor(appDao)
final appDaoProvider = AutoDisposeProvider<AppDao>.internal(
  appDao,
  name: r'appDaoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appDaoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDaoRef = AutoDisposeProviderRef<AppDao>;
String _$deepSeekDatasourceHash() =>
    r'cf83750afebeeaa5e5fe32010479040afe357bea';

/// See also [deepSeekDatasource].
@ProviderFor(deepSeekDatasource)
final deepSeekDatasourceProvider =
    AutoDisposeProvider<DeepSeekDatasource>.internal(
      deepSeekDatasource,
      name: r'deepSeekDatasourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$deepSeekDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeepSeekDatasourceRef = AutoDisposeProviderRef<DeepSeekDatasource>;
String _$decisionRepositoryHash() =>
    r'a34f9c291b0c9fcfcb76401eb0c4e265998b0af7';

/// See also [decisionRepository].
@ProviderFor(decisionRepository)
final decisionRepositoryProvider =
    AutoDisposeProvider<DecisionRepository>.internal(
      decisionRepository,
      name: r'decisionRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$decisionRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DecisionRepositoryRef = AutoDisposeProviderRef<DecisionRepository>;
String _$runSimulationHash() => r'978196dd88cde20486b75525805f998ebc17234b';

/// See also [runSimulation].
@ProviderFor(runSimulation)
final runSimulationProvider = AutoDisposeProvider<RunSimulation>.internal(
  runSimulation,
  name: r'runSimulationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$runSimulationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RunSimulationRef = AutoDisposeProviderRef<RunSimulation>;
String _$getDecisionHistoryHash() =>
    r'5868d81f7513a9d57bab8752691028eb251894ae';

/// See also [getDecisionHistory].
@ProviderFor(getDecisionHistory)
final getDecisionHistoryProvider =
    AutoDisposeProvider<GetDecisionHistory>.internal(
      getDecisionHistory,
      name: r'getDecisionHistoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getDecisionHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetDecisionHistoryRef = AutoDisposeProviderRef<GetDecisionHistory>;
String _$getDecisionByIdHash() => r'3d5e380f1f372fd3c7cc072beb3536d11e843c4a';

/// See also [getDecisionById].
@ProviderFor(getDecisionById)
final getDecisionByIdProvider = AutoDisposeProvider<GetDecisionById>.internal(
  getDecisionById,
  name: r'getDecisionByIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getDecisionByIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetDecisionByIdRef = AutoDisposeProviderRef<GetDecisionById>;
String _$decisionHistoryStreamHash() =>
    r'819b5607566ccc34b7ceda3ca0e3a9146100ac44';

/// Reactive stream provider that watches the decisions table.
/// Automatically emits a new list whenever a decision is inserted/updated/deleted.
///
/// Copied from [decisionHistoryStream].
@ProviderFor(decisionHistoryStream)
final decisionHistoryStreamProvider =
    AutoDisposeStreamProvider<List<Decision>>.internal(
      decisionHistoryStream,
      name: r'decisionHistoryStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$decisionHistoryStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DecisionHistoryStreamRef = AutoDisposeStreamProviderRef<List<Decision>>;
String _$historyDetailHash() => r'257c29e87b3e320ec0c37f4e426a6d538e638184';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Fetches a single historical decision (with parameters and scenarios) by its ID.
/// Returns null if the decision is not found.
///
/// Copied from [historyDetail].
@ProviderFor(historyDetail)
const historyDetailProvider = HistoryDetailFamily();

/// Fetches a single historical decision (with parameters and scenarios) by its ID.
/// Returns null if the decision is not found.
///
/// Copied from [historyDetail].
class HistoryDetailFamily extends Family<AsyncValue<SimulationOutput?>> {
  /// Fetches a single historical decision (with parameters and scenarios) by its ID.
  /// Returns null if the decision is not found.
  ///
  /// Copied from [historyDetail].
  const HistoryDetailFamily();

  /// Fetches a single historical decision (with parameters and scenarios) by its ID.
  /// Returns null if the decision is not found.
  ///
  /// Copied from [historyDetail].
  HistoryDetailProvider call(String id) {
    return HistoryDetailProvider(id);
  }

  @override
  HistoryDetailProvider getProviderOverride(
    covariant HistoryDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'historyDetailProvider';
}

/// Fetches a single historical decision (with parameters and scenarios) by its ID.
/// Returns null if the decision is not found.
///
/// Copied from [historyDetail].
class HistoryDetailProvider
    extends AutoDisposeFutureProvider<SimulationOutput?> {
  /// Fetches a single historical decision (with parameters and scenarios) by its ID.
  /// Returns null if the decision is not found.
  ///
  /// Copied from [historyDetail].
  HistoryDetailProvider(String id)
    : this._internal(
        (ref) => historyDetail(ref as HistoryDetailRef, id),
        from: historyDetailProvider,
        name: r'historyDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$historyDetailHash,
        dependencies: HistoryDetailFamily._dependencies,
        allTransitiveDependencies:
            HistoryDetailFamily._allTransitiveDependencies,
        id: id,
      );

  HistoryDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<SimulationOutput?> Function(HistoryDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HistoryDetailProvider._internal(
        (ref) => create(ref as HistoryDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SimulationOutput?> createElement() {
    return _HistoryDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HistoryDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HistoryDetailRef on AutoDisposeFutureProviderRef<SimulationOutput?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _HistoryDetailProviderElement
    extends AutoDisposeFutureProviderElement<SimulationOutput?>
    with HistoryDetailRef {
  _HistoryDetailProviderElement(super.provider);

  @override
  String get id => (origin as HistoryDetailProvider).id;
}

String _$simulationControllerHash() =>
    r'793e5d59b9c29710ab792d426e499d122b8bdd6c';

/// Controller that holds the current simulation result.
/// Uses keepAlive so the result survives tab switches.
///
/// Copied from [SimulationController].
@ProviderFor(SimulationController)
final simulationControllerProvider =
    NotifierProvider<SimulationController, SimulationState>.internal(
      SimulationController.new,
      name: r'simulationControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$simulationControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SimulationController = Notifier<SimulationState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
