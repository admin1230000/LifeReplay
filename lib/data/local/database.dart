// lib/data/local/database.dart

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

// ──────────────────────────────────────────────
// Table definitions
// ──────────────────────────────────────────────

class Decisions extends Table {
  TextColumn get id => text()(); // UUID v4
  TextColumn get title => text()();
  TextColumn get category => text()();
  IntColumn get createdAt => integer()(); // Milliseconds since epoch
  RealColumn get riskScore => real().withDefault(const Constant(0.0))();
  TextColumn get status =>
      text().withDefault(const Constant('pending'))(); // pending | completed | failed

  @override
  Set<Column> get primaryKey => {id};
}

class Parameters extends Table {
  TextColumn get id => text()(); // UUID v4
  TextColumn get decisionId => text().references(Decisions, #id)();
  TextColumn get keyName => text()();
  TextColumn get value => text()(); // Stored as string
  TextColumn get unit => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

class Scenarios extends Table {
  TextColumn get id => text()(); // UUID v4
  TextColumn get decisionId => text().references(Decisions, #id)();
  TextColumn get type => text()(); // good | neutral | bad
  TextColumn get description => text()();
  RealColumn get probability => real()();
  TextColumn get positiveEffects =>
      text()(); // JSON string: ["effect1", "effect2"]
  TextColumn get negativeEffects =>
      text()(); // JSON string: ["effect1", "effect2"]
  TextColumn get recommendation => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// ──────────────────────────────────────────────
// Database class
// ──────────────────────────────────────────────

@DriftDatabase(tables: [Decisions, Parameters, Scenarios])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from == 1) {
          // Drop old tables and recreate with new schema
          await m.deleteTable('scenarios');
          await m.deleteTable('parameters');
          await m.deleteTable('decisions');
          await m.createAll();
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'life_replay.db'));
    return NativeDatabase(file);
  });
}
