// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DecisionsTable extends Decisions
    with TableInfo<$DecisionsTable, Decision> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DecisionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _riskScoreMeta = const VerificationMeta(
    'riskScore',
  );
  @override
  late final GeneratedColumn<double> riskScore = GeneratedColumn<double>(
    'risk_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    category,
    createdAt,
    riskScore,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'decisions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Decision> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('risk_score')) {
      context.handle(
        _riskScoreMeta,
        riskScore.isAcceptableOrUnknown(data['risk_score']!, _riskScoreMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Decision map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Decision(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      riskScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}risk_score'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $DecisionsTable createAlias(String alias) {
    return $DecisionsTable(attachedDatabase, alias);
  }
}

class Decision extends DataClass implements Insertable<Decision> {
  final String id;
  final String title;
  final String category;
  final int createdAt;
  final double riskScore;
  final String status;
  const Decision({
    required this.id,
    required this.title,
    required this.category,
    required this.createdAt,
    required this.riskScore,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['created_at'] = Variable<int>(createdAt);
    map['risk_score'] = Variable<double>(riskScore);
    map['status'] = Variable<String>(status);
    return map;
  }

  DecisionsCompanion toCompanion(bool nullToAbsent) {
    return DecisionsCompanion(
      id: Value(id),
      title: Value(title),
      category: Value(category),
      createdAt: Value(createdAt),
      riskScore: Value(riskScore),
      status: Value(status),
    );
  }

  factory Decision.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Decision(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      riskScore: serializer.fromJson<double>(json['riskScore']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'createdAt': serializer.toJson<int>(createdAt),
      'riskScore': serializer.toJson<double>(riskScore),
      'status': serializer.toJson<String>(status),
    };
  }

  Decision copyWith({
    String? id,
    String? title,
    String? category,
    int? createdAt,
    double? riskScore,
    String? status,
  }) => Decision(
    id: id ?? this.id,
    title: title ?? this.title,
    category: category ?? this.category,
    createdAt: createdAt ?? this.createdAt,
    riskScore: riskScore ?? this.riskScore,
    status: status ?? this.status,
  );
  Decision copyWithCompanion(DecisionsCompanion data) {
    return Decision(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      riskScore: data.riskScore.present ? data.riskScore.value : this.riskScore,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Decision(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt, ')
          ..write('riskScore: $riskScore, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, category, createdAt, riskScore, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Decision &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.createdAt == this.createdAt &&
          other.riskScore == this.riskScore &&
          other.status == this.status);
}

class DecisionsCompanion extends UpdateCompanion<Decision> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> category;
  final Value<int> createdAt;
  final Value<double> riskScore;
  final Value<String> status;
  final Value<int> rowid;
  const DecisionsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.riskScore = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DecisionsCompanion.insert({
    required String id,
    required String title,
    required String category,
    required int createdAt,
    this.riskScore = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       category = Value(category),
       createdAt = Value(createdAt);
  static Insertable<Decision> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? category,
    Expression<int>? createdAt,
    Expression<double>? riskScore,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (createdAt != null) 'created_at': createdAt,
      if (riskScore != null) 'risk_score': riskScore,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DecisionsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? category,
    Value<int>? createdAt,
    Value<double>? riskScore,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return DecisionsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      riskScore: riskScore ?? this.riskScore,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (riskScore.present) {
      map['risk_score'] = Variable<double>(riskScore.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DecisionsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt, ')
          ..write('riskScore: $riskScore, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ParametersTable extends Parameters
    with TableInfo<$ParametersTable, Parameter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParametersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _decisionIdMeta = const VerificationMeta(
    'decisionId',
  );
  @override
  late final GeneratedColumn<String> decisionId = GeneratedColumn<String>(
    'decision_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES decisions (id)',
    ),
  );
  static const VerificationMeta _keyNameMeta = const VerificationMeta(
    'keyName',
  );
  @override
  late final GeneratedColumn<String> keyName = GeneratedColumn<String>(
    'key_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [id, decisionId, keyName, value, unit];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parameters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Parameter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('decision_id')) {
      context.handle(
        _decisionIdMeta,
        decisionId.isAcceptableOrUnknown(data['decision_id']!, _decisionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_decisionIdMeta);
    }
    if (data.containsKey('key_name')) {
      context.handle(
        _keyNameMeta,
        keyName.isAcceptableOrUnknown(data['key_name']!, _keyNameMeta),
      );
    } else if (isInserting) {
      context.missing(_keyNameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Parameter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Parameter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      decisionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision_id'],
      )!,
      keyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key_name'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
    );
  }

  @override
  $ParametersTable createAlias(String alias) {
    return $ParametersTable(attachedDatabase, alias);
  }
}

class Parameter extends DataClass implements Insertable<Parameter> {
  final String id;
  final String decisionId;
  final String keyName;
  final String value;
  final String unit;
  const Parameter({
    required this.id,
    required this.decisionId,
    required this.keyName,
    required this.value,
    required this.unit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['decision_id'] = Variable<String>(decisionId);
    map['key_name'] = Variable<String>(keyName);
    map['value'] = Variable<String>(value);
    map['unit'] = Variable<String>(unit);
    return map;
  }

  ParametersCompanion toCompanion(bool nullToAbsent) {
    return ParametersCompanion(
      id: Value(id),
      decisionId: Value(decisionId),
      keyName: Value(keyName),
      value: Value(value),
      unit: Value(unit),
    );
  }

  factory Parameter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Parameter(
      id: serializer.fromJson<String>(json['id']),
      decisionId: serializer.fromJson<String>(json['decisionId']),
      keyName: serializer.fromJson<String>(json['keyName']),
      value: serializer.fromJson<String>(json['value']),
      unit: serializer.fromJson<String>(json['unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'decisionId': serializer.toJson<String>(decisionId),
      'keyName': serializer.toJson<String>(keyName),
      'value': serializer.toJson<String>(value),
      'unit': serializer.toJson<String>(unit),
    };
  }

  Parameter copyWith({
    String? id,
    String? decisionId,
    String? keyName,
    String? value,
    String? unit,
  }) => Parameter(
    id: id ?? this.id,
    decisionId: decisionId ?? this.decisionId,
    keyName: keyName ?? this.keyName,
    value: value ?? this.value,
    unit: unit ?? this.unit,
  );
  Parameter copyWithCompanion(ParametersCompanion data) {
    return Parameter(
      id: data.id.present ? data.id.value : this.id,
      decisionId: data.decisionId.present
          ? data.decisionId.value
          : this.decisionId,
      keyName: data.keyName.present ? data.keyName.value : this.keyName,
      value: data.value.present ? data.value.value : this.value,
      unit: data.unit.present ? data.unit.value : this.unit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Parameter(')
          ..write('id: $id, ')
          ..write('decisionId: $decisionId, ')
          ..write('keyName: $keyName, ')
          ..write('value: $value, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, decisionId, keyName, value, unit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Parameter &&
          other.id == this.id &&
          other.decisionId == this.decisionId &&
          other.keyName == this.keyName &&
          other.value == this.value &&
          other.unit == this.unit);
}

class ParametersCompanion extends UpdateCompanion<Parameter> {
  final Value<String> id;
  final Value<String> decisionId;
  final Value<String> keyName;
  final Value<String> value;
  final Value<String> unit;
  final Value<int> rowid;
  const ParametersCompanion({
    this.id = const Value.absent(),
    this.decisionId = const Value.absent(),
    this.keyName = const Value.absent(),
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ParametersCompanion.insert({
    required String id,
    required String decisionId,
    required String keyName,
    required String value,
    this.unit = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       decisionId = Value(decisionId),
       keyName = Value(keyName),
       value = Value(value);
  static Insertable<Parameter> custom({
    Expression<String>? id,
    Expression<String>? decisionId,
    Expression<String>? keyName,
    Expression<String>? value,
    Expression<String>? unit,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (decisionId != null) 'decision_id': decisionId,
      if (keyName != null) 'key_name': keyName,
      if (value != null) 'value': value,
      if (unit != null) 'unit': unit,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ParametersCompanion copyWith({
    Value<String>? id,
    Value<String>? decisionId,
    Value<String>? keyName,
    Value<String>? value,
    Value<String>? unit,
    Value<int>? rowid,
  }) {
    return ParametersCompanion(
      id: id ?? this.id,
      decisionId: decisionId ?? this.decisionId,
      keyName: keyName ?? this.keyName,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (decisionId.present) {
      map['decision_id'] = Variable<String>(decisionId.value);
    }
    if (keyName.present) {
      map['key_name'] = Variable<String>(keyName.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParametersCompanion(')
          ..write('id: $id, ')
          ..write('decisionId: $decisionId, ')
          ..write('keyName: $keyName, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScenariosTable extends Scenarios
    with TableInfo<$ScenariosTable, Scenario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScenariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _decisionIdMeta = const VerificationMeta(
    'decisionId',
  );
  @override
  late final GeneratedColumn<String> decisionId = GeneratedColumn<String>(
    'decision_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES decisions (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _probabilityMeta = const VerificationMeta(
    'probability',
  );
  @override
  late final GeneratedColumn<double> probability = GeneratedColumn<double>(
    'probability',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positiveEffectsMeta = const VerificationMeta(
    'positiveEffects',
  );
  @override
  late final GeneratedColumn<String> positiveEffects = GeneratedColumn<String>(
    'positive_effects',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _negativeEffectsMeta = const VerificationMeta(
    'negativeEffects',
  );
  @override
  late final GeneratedColumn<String> negativeEffects = GeneratedColumn<String>(
    'negative_effects',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recommendationMeta = const VerificationMeta(
    'recommendation',
  );
  @override
  late final GeneratedColumn<String> recommendation = GeneratedColumn<String>(
    'recommendation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    decisionId,
    type,
    description,
    probability,
    positiveEffects,
    negativeEffects,
    recommendation,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scenarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Scenario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('decision_id')) {
      context.handle(
        _decisionIdMeta,
        decisionId.isAcceptableOrUnknown(data['decision_id']!, _decisionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_decisionIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('probability')) {
      context.handle(
        _probabilityMeta,
        probability.isAcceptableOrUnknown(
          data['probability']!,
          _probabilityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_probabilityMeta);
    }
    if (data.containsKey('positive_effects')) {
      context.handle(
        _positiveEffectsMeta,
        positiveEffects.isAcceptableOrUnknown(
          data['positive_effects']!,
          _positiveEffectsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_positiveEffectsMeta);
    }
    if (data.containsKey('negative_effects')) {
      context.handle(
        _negativeEffectsMeta,
        negativeEffects.isAcceptableOrUnknown(
          data['negative_effects']!,
          _negativeEffectsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_negativeEffectsMeta);
    }
    if (data.containsKey('recommendation')) {
      context.handle(
        _recommendationMeta,
        recommendation.isAcceptableOrUnknown(
          data['recommendation']!,
          _recommendationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recommendationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Scenario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Scenario(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      decisionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decision_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      probability: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}probability'],
      )!,
      positiveEffects: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}positive_effects'],
      )!,
      negativeEffects: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}negative_effects'],
      )!,
      recommendation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recommendation'],
      )!,
    );
  }

  @override
  $ScenariosTable createAlias(String alias) {
    return $ScenariosTable(attachedDatabase, alias);
  }
}

class Scenario extends DataClass implements Insertable<Scenario> {
  final String id;
  final String decisionId;
  final String type;
  final String description;
  final double probability;
  final String positiveEffects;
  final String negativeEffects;
  final String recommendation;
  const Scenario({
    required this.id,
    required this.decisionId,
    required this.type,
    required this.description,
    required this.probability,
    required this.positiveEffects,
    required this.negativeEffects,
    required this.recommendation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['decision_id'] = Variable<String>(decisionId);
    map['type'] = Variable<String>(type);
    map['description'] = Variable<String>(description);
    map['probability'] = Variable<double>(probability);
    map['positive_effects'] = Variable<String>(positiveEffects);
    map['negative_effects'] = Variable<String>(negativeEffects);
    map['recommendation'] = Variable<String>(recommendation);
    return map;
  }

  ScenariosCompanion toCompanion(bool nullToAbsent) {
    return ScenariosCompanion(
      id: Value(id),
      decisionId: Value(decisionId),
      type: Value(type),
      description: Value(description),
      probability: Value(probability),
      positiveEffects: Value(positiveEffects),
      negativeEffects: Value(negativeEffects),
      recommendation: Value(recommendation),
    );
  }

  factory Scenario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Scenario(
      id: serializer.fromJson<String>(json['id']),
      decisionId: serializer.fromJson<String>(json['decisionId']),
      type: serializer.fromJson<String>(json['type']),
      description: serializer.fromJson<String>(json['description']),
      probability: serializer.fromJson<double>(json['probability']),
      positiveEffects: serializer.fromJson<String>(json['positiveEffects']),
      negativeEffects: serializer.fromJson<String>(json['negativeEffects']),
      recommendation: serializer.fromJson<String>(json['recommendation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'decisionId': serializer.toJson<String>(decisionId),
      'type': serializer.toJson<String>(type),
      'description': serializer.toJson<String>(description),
      'probability': serializer.toJson<double>(probability),
      'positiveEffects': serializer.toJson<String>(positiveEffects),
      'negativeEffects': serializer.toJson<String>(negativeEffects),
      'recommendation': serializer.toJson<String>(recommendation),
    };
  }

  Scenario copyWith({
    String? id,
    String? decisionId,
    String? type,
    String? description,
    double? probability,
    String? positiveEffects,
    String? negativeEffects,
    String? recommendation,
  }) => Scenario(
    id: id ?? this.id,
    decisionId: decisionId ?? this.decisionId,
    type: type ?? this.type,
    description: description ?? this.description,
    probability: probability ?? this.probability,
    positiveEffects: positiveEffects ?? this.positiveEffects,
    negativeEffects: negativeEffects ?? this.negativeEffects,
    recommendation: recommendation ?? this.recommendation,
  );
  Scenario copyWithCompanion(ScenariosCompanion data) {
    return Scenario(
      id: data.id.present ? data.id.value : this.id,
      decisionId: data.decisionId.present
          ? data.decisionId.value
          : this.decisionId,
      type: data.type.present ? data.type.value : this.type,
      description: data.description.present
          ? data.description.value
          : this.description,
      probability: data.probability.present
          ? data.probability.value
          : this.probability,
      positiveEffects: data.positiveEffects.present
          ? data.positiveEffects.value
          : this.positiveEffects,
      negativeEffects: data.negativeEffects.present
          ? data.negativeEffects.value
          : this.negativeEffects,
      recommendation: data.recommendation.present
          ? data.recommendation.value
          : this.recommendation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Scenario(')
          ..write('id: $id, ')
          ..write('decisionId: $decisionId, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('probability: $probability, ')
          ..write('positiveEffects: $positiveEffects, ')
          ..write('negativeEffects: $negativeEffects, ')
          ..write('recommendation: $recommendation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    decisionId,
    type,
    description,
    probability,
    positiveEffects,
    negativeEffects,
    recommendation,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Scenario &&
          other.id == this.id &&
          other.decisionId == this.decisionId &&
          other.type == this.type &&
          other.description == this.description &&
          other.probability == this.probability &&
          other.positiveEffects == this.positiveEffects &&
          other.negativeEffects == this.negativeEffects &&
          other.recommendation == this.recommendation);
}

class ScenariosCompanion extends UpdateCompanion<Scenario> {
  final Value<String> id;
  final Value<String> decisionId;
  final Value<String> type;
  final Value<String> description;
  final Value<double> probability;
  final Value<String> positiveEffects;
  final Value<String> negativeEffects;
  final Value<String> recommendation;
  final Value<int> rowid;
  const ScenariosCompanion({
    this.id = const Value.absent(),
    this.decisionId = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.probability = const Value.absent(),
    this.positiveEffects = const Value.absent(),
    this.negativeEffects = const Value.absent(),
    this.recommendation = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScenariosCompanion.insert({
    required String id,
    required String decisionId,
    required String type,
    required String description,
    required double probability,
    required String positiveEffects,
    required String negativeEffects,
    required String recommendation,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       decisionId = Value(decisionId),
       type = Value(type),
       description = Value(description),
       probability = Value(probability),
       positiveEffects = Value(positiveEffects),
       negativeEffects = Value(negativeEffects),
       recommendation = Value(recommendation);
  static Insertable<Scenario> custom({
    Expression<String>? id,
    Expression<String>? decisionId,
    Expression<String>? type,
    Expression<String>? description,
    Expression<double>? probability,
    Expression<String>? positiveEffects,
    Expression<String>? negativeEffects,
    Expression<String>? recommendation,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (decisionId != null) 'decision_id': decisionId,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
      if (probability != null) 'probability': probability,
      if (positiveEffects != null) 'positive_effects': positiveEffects,
      if (negativeEffects != null) 'negative_effects': negativeEffects,
      if (recommendation != null) 'recommendation': recommendation,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScenariosCompanion copyWith({
    Value<String>? id,
    Value<String>? decisionId,
    Value<String>? type,
    Value<String>? description,
    Value<double>? probability,
    Value<String>? positiveEffects,
    Value<String>? negativeEffects,
    Value<String>? recommendation,
    Value<int>? rowid,
  }) {
    return ScenariosCompanion(
      id: id ?? this.id,
      decisionId: decisionId ?? this.decisionId,
      type: type ?? this.type,
      description: description ?? this.description,
      probability: probability ?? this.probability,
      positiveEffects: positiveEffects ?? this.positiveEffects,
      negativeEffects: negativeEffects ?? this.negativeEffects,
      recommendation: recommendation ?? this.recommendation,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (decisionId.present) {
      map['decision_id'] = Variable<String>(decisionId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (probability.present) {
      map['probability'] = Variable<double>(probability.value);
    }
    if (positiveEffects.present) {
      map['positive_effects'] = Variable<String>(positiveEffects.value);
    }
    if (negativeEffects.present) {
      map['negative_effects'] = Variable<String>(negativeEffects.value);
    }
    if (recommendation.present) {
      map['recommendation'] = Variable<String>(recommendation.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScenariosCompanion(')
          ..write('id: $id, ')
          ..write('decisionId: $decisionId, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('probability: $probability, ')
          ..write('positiveEffects: $positiveEffects, ')
          ..write('negativeEffects: $negativeEffects, ')
          ..write('recommendation: $recommendation, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DecisionsTable decisions = $DecisionsTable(this);
  late final $ParametersTable parameters = $ParametersTable(this);
  late final $ScenariosTable scenarios = $ScenariosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    decisions,
    parameters,
    scenarios,
  ];
}

typedef $$DecisionsTableCreateCompanionBuilder =
    DecisionsCompanion Function({
      required String id,
      required String title,
      required String category,
      required int createdAt,
      Value<double> riskScore,
      Value<String> status,
      Value<int> rowid,
    });
typedef $$DecisionsTableUpdateCompanionBuilder =
    DecisionsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> category,
      Value<int> createdAt,
      Value<double> riskScore,
      Value<String> status,
      Value<int> rowid,
    });

final class $$DecisionsTableReferences
    extends BaseReferences<_$AppDatabase, $DecisionsTable, Decision> {
  $$DecisionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ParametersTable, List<Parameter>>
  _parametersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.parameters,
    aliasName: $_aliasNameGenerator(db.decisions.id, db.parameters.decisionId),
  );

  $$ParametersTableProcessedTableManager get parametersRefs {
    final manager = $$ParametersTableTableManager(
      $_db,
      $_db.parameters,
    ).filter((f) => f.decisionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_parametersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ScenariosTable, List<Scenario>>
  _scenariosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.scenarios,
    aliasName: $_aliasNameGenerator(db.decisions.id, db.scenarios.decisionId),
  );

  $$ScenariosTableProcessedTableManager get scenariosRefs {
    final manager = $$ScenariosTableTableManager(
      $_db,
      $_db.scenarios,
    ).filter((f) => f.decisionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_scenariosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DecisionsTableFilterComposer
    extends Composer<_$AppDatabase, $DecisionsTable> {
  $$DecisionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get riskScore => $composableBuilder(
    column: $table.riskScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> parametersRefs(
    Expression<bool> Function($$ParametersTableFilterComposer f) f,
  ) {
    final $$ParametersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parameters,
      getReferencedColumn: (t) => t.decisionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParametersTableFilterComposer(
            $db: $db,
            $table: $db.parameters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scenariosRefs(
    Expression<bool> Function($$ScenariosTableFilterComposer f) f,
  ) {
    final $$ScenariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scenarios,
      getReferencedColumn: (t) => t.decisionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenariosTableFilterComposer(
            $db: $db,
            $table: $db.scenarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DecisionsTableOrderingComposer
    extends Composer<_$AppDatabase, $DecisionsTable> {
  $$DecisionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get riskScore => $composableBuilder(
    column: $table.riskScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DecisionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DecisionsTable> {
  $$DecisionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get riskScore =>
      $composableBuilder(column: $table.riskScore, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  Expression<T> parametersRefs<T extends Object>(
    Expression<T> Function($$ParametersTableAnnotationComposer a) f,
  ) {
    final $$ParametersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.parameters,
      getReferencedColumn: (t) => t.decisionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ParametersTableAnnotationComposer(
            $db: $db,
            $table: $db.parameters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scenariosRefs<T extends Object>(
    Expression<T> Function($$ScenariosTableAnnotationComposer a) f,
  ) {
    final $$ScenariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scenarios,
      getReferencedColumn: (t) => t.decisionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenariosTableAnnotationComposer(
            $db: $db,
            $table: $db.scenarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DecisionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DecisionsTable,
          Decision,
          $$DecisionsTableFilterComposer,
          $$DecisionsTableOrderingComposer,
          $$DecisionsTableAnnotationComposer,
          $$DecisionsTableCreateCompanionBuilder,
          $$DecisionsTableUpdateCompanionBuilder,
          (Decision, $$DecisionsTableReferences),
          Decision,
          PrefetchHooks Function({bool parametersRefs, bool scenariosRefs})
        > {
  $$DecisionsTableTableManager(_$AppDatabase db, $DecisionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DecisionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DecisionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DecisionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<double> riskScore = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DecisionsCompanion(
                id: id,
                title: title,
                category: category,
                createdAt: createdAt,
                riskScore: riskScore,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String category,
                required int createdAt,
                Value<double> riskScore = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DecisionsCompanion.insert(
                id: id,
                title: title,
                category: category,
                createdAt: createdAt,
                riskScore: riskScore,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DecisionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({parametersRefs = false, scenariosRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (parametersRefs) db.parameters,
                    if (scenariosRefs) db.scenarios,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (parametersRefs)
                        await $_getPrefetchedData<
                          Decision,
                          $DecisionsTable,
                          Parameter
                        >(
                          currentTable: table,
                          referencedTable: $$DecisionsTableReferences
                              ._parametersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DecisionsTableReferences(
                                db,
                                table,
                                p0,
                              ).parametersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.decisionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scenariosRefs)
                        await $_getPrefetchedData<
                          Decision,
                          $DecisionsTable,
                          Scenario
                        >(
                          currentTable: table,
                          referencedTable: $$DecisionsTableReferences
                              ._scenariosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DecisionsTableReferences(
                                db,
                                table,
                                p0,
                              ).scenariosRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.decisionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DecisionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DecisionsTable,
      Decision,
      $$DecisionsTableFilterComposer,
      $$DecisionsTableOrderingComposer,
      $$DecisionsTableAnnotationComposer,
      $$DecisionsTableCreateCompanionBuilder,
      $$DecisionsTableUpdateCompanionBuilder,
      (Decision, $$DecisionsTableReferences),
      Decision,
      PrefetchHooks Function({bool parametersRefs, bool scenariosRefs})
    >;
typedef $$ParametersTableCreateCompanionBuilder =
    ParametersCompanion Function({
      required String id,
      required String decisionId,
      required String keyName,
      required String value,
      Value<String> unit,
      Value<int> rowid,
    });
typedef $$ParametersTableUpdateCompanionBuilder =
    ParametersCompanion Function({
      Value<String> id,
      Value<String> decisionId,
      Value<String> keyName,
      Value<String> value,
      Value<String> unit,
      Value<int> rowid,
    });

final class $$ParametersTableReferences
    extends BaseReferences<_$AppDatabase, $ParametersTable, Parameter> {
  $$ParametersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DecisionsTable _decisionIdTable(_$AppDatabase db) =>
      db.decisions.createAlias(
        $_aliasNameGenerator(db.parameters.decisionId, db.decisions.id),
      );

  $$DecisionsTableProcessedTableManager get decisionId {
    final $_column = $_itemColumn<String>('decision_id')!;

    final manager = $$DecisionsTableTableManager(
      $_db,
      $_db.decisions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_decisionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ParametersTableFilterComposer
    extends Composer<_$AppDatabase, $ParametersTable> {
  $$ParametersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get keyName => $composableBuilder(
    column: $table.keyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  $$DecisionsTableFilterComposer get decisionId {
    final $$DecisionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.decisionId,
      referencedTable: $db.decisions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecisionsTableFilterComposer(
            $db: $db,
            $table: $db.decisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParametersTableOrderingComposer
    extends Composer<_$AppDatabase, $ParametersTable> {
  $$ParametersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get keyName => $composableBuilder(
    column: $table.keyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  $$DecisionsTableOrderingComposer get decisionId {
    final $$DecisionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.decisionId,
      referencedTable: $db.decisions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecisionsTableOrderingComposer(
            $db: $db,
            $table: $db.decisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParametersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParametersTable> {
  $$ParametersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get keyName =>
      $composableBuilder(column: $table.keyName, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  $$DecisionsTableAnnotationComposer get decisionId {
    final $$DecisionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.decisionId,
      referencedTable: $db.decisions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecisionsTableAnnotationComposer(
            $db: $db,
            $table: $db.decisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ParametersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ParametersTable,
          Parameter,
          $$ParametersTableFilterComposer,
          $$ParametersTableOrderingComposer,
          $$ParametersTableAnnotationComposer,
          $$ParametersTableCreateCompanionBuilder,
          $$ParametersTableUpdateCompanionBuilder,
          (Parameter, $$ParametersTableReferences),
          Parameter,
          PrefetchHooks Function({bool decisionId})
        > {
  $$ParametersTableTableManager(_$AppDatabase db, $ParametersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParametersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParametersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParametersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> decisionId = const Value.absent(),
                Value<String> keyName = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParametersCompanion(
                id: id,
                decisionId: decisionId,
                keyName: keyName,
                value: value,
                unit: unit,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String decisionId,
                required String keyName,
                required String value,
                Value<String> unit = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ParametersCompanion.insert(
                id: id,
                decisionId: decisionId,
                keyName: keyName,
                value: value,
                unit: unit,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ParametersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({decisionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (decisionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.decisionId,
                                referencedTable: $$ParametersTableReferences
                                    ._decisionIdTable(db),
                                referencedColumn: $$ParametersTableReferences
                                    ._decisionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ParametersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ParametersTable,
      Parameter,
      $$ParametersTableFilterComposer,
      $$ParametersTableOrderingComposer,
      $$ParametersTableAnnotationComposer,
      $$ParametersTableCreateCompanionBuilder,
      $$ParametersTableUpdateCompanionBuilder,
      (Parameter, $$ParametersTableReferences),
      Parameter,
      PrefetchHooks Function({bool decisionId})
    >;
typedef $$ScenariosTableCreateCompanionBuilder =
    ScenariosCompanion Function({
      required String id,
      required String decisionId,
      required String type,
      required String description,
      required double probability,
      required String positiveEffects,
      required String negativeEffects,
      required String recommendation,
      Value<int> rowid,
    });
typedef $$ScenariosTableUpdateCompanionBuilder =
    ScenariosCompanion Function({
      Value<String> id,
      Value<String> decisionId,
      Value<String> type,
      Value<String> description,
      Value<double> probability,
      Value<String> positiveEffects,
      Value<String> negativeEffects,
      Value<String> recommendation,
      Value<int> rowid,
    });

final class $$ScenariosTableReferences
    extends BaseReferences<_$AppDatabase, $ScenariosTable, Scenario> {
  $$ScenariosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DecisionsTable _decisionIdTable(_$AppDatabase db) =>
      db.decisions.createAlias(
        $_aliasNameGenerator(db.scenarios.decisionId, db.decisions.id),
      );

  $$DecisionsTableProcessedTableManager get decisionId {
    final $_column = $_itemColumn<String>('decision_id')!;

    final manager = $$DecisionsTableTableManager(
      $_db,
      $_db.decisions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_decisionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScenariosTableFilterComposer
    extends Composer<_$AppDatabase, $ScenariosTable> {
  $$ScenariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get probability => $composableBuilder(
    column: $table.probability,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get positiveEffects => $composableBuilder(
    column: $table.positiveEffects,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get negativeEffects => $composableBuilder(
    column: $table.negativeEffects,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => ColumnFilters(column),
  );

  $$DecisionsTableFilterComposer get decisionId {
    final $$DecisionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.decisionId,
      referencedTable: $db.decisions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecisionsTableFilterComposer(
            $db: $db,
            $table: $db.decisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScenariosTableOrderingComposer
    extends Composer<_$AppDatabase, $ScenariosTable> {
  $$ScenariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get probability => $composableBuilder(
    column: $table.probability,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get positiveEffects => $composableBuilder(
    column: $table.positiveEffects,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get negativeEffects => $composableBuilder(
    column: $table.negativeEffects,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => ColumnOrderings(column),
  );

  $$DecisionsTableOrderingComposer get decisionId {
    final $$DecisionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.decisionId,
      referencedTable: $db.decisions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecisionsTableOrderingComposer(
            $db: $db,
            $table: $db.decisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScenariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScenariosTable> {
  $$ScenariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get probability => $composableBuilder(
    column: $table.probability,
    builder: (column) => column,
  );

  GeneratedColumn<String> get positiveEffects => $composableBuilder(
    column: $table.positiveEffects,
    builder: (column) => column,
  );

  GeneratedColumn<String> get negativeEffects => $composableBuilder(
    column: $table.negativeEffects,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recommendation => $composableBuilder(
    column: $table.recommendation,
    builder: (column) => column,
  );

  $$DecisionsTableAnnotationComposer get decisionId {
    final $$DecisionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.decisionId,
      referencedTable: $db.decisions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecisionsTableAnnotationComposer(
            $db: $db,
            $table: $db.decisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScenariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScenariosTable,
          Scenario,
          $$ScenariosTableFilterComposer,
          $$ScenariosTableOrderingComposer,
          $$ScenariosTableAnnotationComposer,
          $$ScenariosTableCreateCompanionBuilder,
          $$ScenariosTableUpdateCompanionBuilder,
          (Scenario, $$ScenariosTableReferences),
          Scenario,
          PrefetchHooks Function({bool decisionId})
        > {
  $$ScenariosTableTableManager(_$AppDatabase db, $ScenariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScenariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScenariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScenariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> decisionId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> probability = const Value.absent(),
                Value<String> positiveEffects = const Value.absent(),
                Value<String> negativeEffects = const Value.absent(),
                Value<String> recommendation = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScenariosCompanion(
                id: id,
                decisionId: decisionId,
                type: type,
                description: description,
                probability: probability,
                positiveEffects: positiveEffects,
                negativeEffects: negativeEffects,
                recommendation: recommendation,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String decisionId,
                required String type,
                required String description,
                required double probability,
                required String positiveEffects,
                required String negativeEffects,
                required String recommendation,
                Value<int> rowid = const Value.absent(),
              }) => ScenariosCompanion.insert(
                id: id,
                decisionId: decisionId,
                type: type,
                description: description,
                probability: probability,
                positiveEffects: positiveEffects,
                negativeEffects: negativeEffects,
                recommendation: recommendation,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ScenariosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({decisionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (decisionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.decisionId,
                                referencedTable: $$ScenariosTableReferences
                                    ._decisionIdTable(db),
                                referencedColumn: $$ScenariosTableReferences
                                    ._decisionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScenariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScenariosTable,
      Scenario,
      $$ScenariosTableFilterComposer,
      $$ScenariosTableOrderingComposer,
      $$ScenariosTableAnnotationComposer,
      $$ScenariosTableCreateCompanionBuilder,
      $$ScenariosTableUpdateCompanionBuilder,
      (Scenario, $$ScenariosTableReferences),
      Scenario,
      PrefetchHooks Function({bool decisionId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DecisionsTableTableManager get decisions =>
      $$DecisionsTableTableManager(_db, _db.decisions);
  $$ParametersTableTableManager get parameters =>
      $$ParametersTableTableManager(_db, _db.parameters);
  $$ScenariosTableTableManager get scenarios =>
      $$ScenariosTableTableManager(_db, _db.scenarios);
}
