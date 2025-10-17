// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryActivityMeta = const VerificationMeta(
    'primaryActivity',
  );
  @override
  late final GeneratedColumn<String> primaryActivity = GeneratedColumn<String>(
    'primary_activity',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    email,
    password,
    primaryActivity,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('primary_activity')) {
      context.handle(
        _primaryActivityMeta,
        primaryActivity.isAcceptableOrUnknown(
          data['primary_activity']!,
          _primaryActivityMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      primaryActivity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_activity'],
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String email;
  final String password;
  final String? primaryActivity;
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.primaryActivity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    if (!nullToAbsent || primaryActivity != null) {
      map['primary_activity'] = Variable<String>(primaryActivity);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      password: Value(password),
      primaryActivity: primaryActivity == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryActivity),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      primaryActivity: serializer.fromJson<String?>(json['primaryActivity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'primaryActivity': serializer.toJson<String?>(primaryActivity),
    };
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    Value<String?> primaryActivity = const Value.absent(),
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    password: password ?? this.password,
    primaryActivity: primaryActivity.present
        ? primaryActivity.value
        : this.primaryActivity,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
      primaryActivity: data.primaryActivity.present
          ? data.primaryActivity.value
          : this.primaryActivity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('primaryActivity: $primaryActivity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, password, primaryActivity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.password == this.password &&
          other.primaryActivity == this.primaryActivity);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> password;
  final Value<String?> primaryActivity;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.primaryActivity = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    required String password,
    this.primaryActivity = const Value.absent(),
  }) : name = Value(name),
       email = Value(email),
       password = Value(password);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? password,
    Expression<String>? primaryActivity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (primaryActivity != null) 'primary_activity': primaryActivity,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? email,
    Value<String>? password,
    Value<String?>? primaryActivity,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      primaryActivity: primaryActivity ?? this.primaryActivity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (primaryActivity.present) {
      map['primary_activity'] = Variable<String>(primaryActivity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('primaryActivity: $primaryActivity')
          ..write(')'))
        .toString();
  }
}

class $FactorsTable extends Factors with TableInfo<$FactorsTable, Factor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FactorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, icon, isDefault, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'factors';
  @override
  VerificationContext validateIntegrity(
    Insertable<Factor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Factor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Factor(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      ),
    );
  }

  @override
  $FactorsTable createAlias(String alias) {
    return $FactorsTable(attachedDatabase, alias);
  }
}

class Factor extends DataClass implements Insertable<Factor> {
  final int id;
  final String name;
  final String icon;
  final bool isDefault;
  final int? userId;
  const Factor({
    required this.id,
    required this.name,
    required this.icon,
    required this.isDefault,
    this.userId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['is_default'] = Variable<bool>(isDefault);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    return map;
  }

  FactorsCompanion toCompanion(bool nullToAbsent) {
    return FactorsCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      isDefault: Value(isDefault),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
    );
  }

  factory Factor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Factor(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      userId: serializer.fromJson<int?>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'isDefault': serializer.toJson<bool>(isDefault),
      'userId': serializer.toJson<int?>(userId),
    };
  }

  Factor copyWith({
    int? id,
    String? name,
    String? icon,
    bool? isDefault,
    Value<int?> userId = const Value.absent(),
  }) => Factor(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    isDefault: isDefault ?? this.isDefault,
    userId: userId.present ? userId.value : this.userId,
  );
  Factor copyWithCompanion(FactorsCompanion data) {
    return Factor(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      userId: data.userId.present ? data.userId.value : this.userId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Factor(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('isDefault: $isDefault, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon, isDefault, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Factor &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.isDefault == this.isDefault &&
          other.userId == this.userId);
}

class FactorsCompanion extends UpdateCompanion<Factor> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<bool> isDefault;
  final Value<int?> userId;
  const FactorsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.userId = const Value.absent(),
  });
  FactorsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String icon,
    this.isDefault = const Value.absent(),
    this.userId = const Value.absent(),
  }) : name = Value(name),
       icon = Value(icon);
  static Insertable<Factor> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<bool>? isDefault,
    Expression<int>? userId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (isDefault != null) 'is_default': isDefault,
      if (userId != null) 'user_id': userId,
    });
  }

  FactorsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? icon,
    Value<bool>? isDefault,
    Value<int?>? userId,
  }) {
    return FactorsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      isDefault: isDefault ?? this.isDefault,
      userId: userId ?? this.userId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FactorsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('isDefault: $isDefault, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }
}

class $SleepSessionsTable extends SleepSessions
    with TableInfo<$SleepSessionsTable, SleepSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationInMinutesMeta = const VerificationMeta(
    'durationInMinutes',
  );
  @override
  late final GeneratedColumn<int> durationInMinutes = GeneratedColumn<int>(
    'duration_in_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qualityRatingMeta = const VerificationMeta(
    'qualityRating',
  );
  @override
  late final GeneratedColumn<int> qualityRating = GeneratedColumn<int>(
    'quality_rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    startedAt,
    endedAt,
    durationInMinutes,
    qualityRating,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('duration_in_minutes')) {
      context.handle(
        _durationInMinutesMeta,
        durationInMinutes.isAcceptableOrUnknown(
          data['duration_in_minutes']!,
          _durationInMinutesMeta,
        ),
      );
    }
    if (data.containsKey('quality_rating')) {
      context.handle(
        _qualityRatingMeta,
        qualityRating.isAcceptableOrUnknown(
          data['quality_rating']!,
          _qualityRatingMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      durationInMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_in_minutes'],
      ),
      qualityRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quality_rating'],
      ),
    );
  }

  @override
  $SleepSessionsTable createAlias(String alias) {
    return $SleepSessionsTable(attachedDatabase, alias);
  }
}

class SleepSession extends DataClass implements Insertable<SleepSession> {
  final int id;
  final int userId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int? durationInMinutes;
  final int? qualityRating;
  const SleepSession({
    required this.id,
    required this.userId,
    required this.startedAt,
    this.endedAt,
    this.durationInMinutes,
    this.qualityRating,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    if (!nullToAbsent || durationInMinutes != null) {
      map['duration_in_minutes'] = Variable<int>(durationInMinutes);
    }
    if (!nullToAbsent || qualityRating != null) {
      map['quality_rating'] = Variable<int>(qualityRating);
    }
    return map;
  }

  SleepSessionsCompanion toCompanion(bool nullToAbsent) {
    return SleepSessionsCompanion(
      id: Value(id),
      userId: Value(userId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      durationInMinutes: durationInMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationInMinutes),
      qualityRating: qualityRating == null && nullToAbsent
          ? const Value.absent()
          : Value(qualityRating),
    );
  }

  factory SleepSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepSession(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      durationInMinutes: serializer.fromJson<int?>(json['durationInMinutes']),
      qualityRating: serializer.fromJson<int?>(json['qualityRating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'durationInMinutes': serializer.toJson<int?>(durationInMinutes),
      'qualityRating': serializer.toJson<int?>(qualityRating),
    };
  }

  SleepSession copyWith({
    int? id,
    int? userId,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    Value<int?> durationInMinutes = const Value.absent(),
    Value<int?> qualityRating = const Value.absent(),
  }) => SleepSession(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    durationInMinutes: durationInMinutes.present
        ? durationInMinutes.value
        : this.durationInMinutes,
    qualityRating: qualityRating.present
        ? qualityRating.value
        : this.qualityRating,
  );
  SleepSession copyWithCompanion(SleepSessionsCompanion data) {
    return SleepSession(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      durationInMinutes: data.durationInMinutes.present
          ? data.durationInMinutes.value
          : this.durationInMinutes,
      qualityRating: data.qualityRating.present
          ? data.qualityRating.value
          : this.qualityRating,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepSession(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationInMinutes: $durationInMinutes, ')
          ..write('qualityRating: $qualityRating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    startedAt,
    endedAt,
    durationInMinutes,
    qualityRating,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepSession &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.durationInMinutes == this.durationInMinutes &&
          other.qualityRating == this.qualityRating);
}

class SleepSessionsCompanion extends UpdateCompanion<SleepSession> {
  final Value<int> id;
  final Value<int> userId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int?> durationInMinutes;
  final Value<int?> qualityRating;
  const SleepSessionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.durationInMinutes = const Value.absent(),
    this.qualityRating = const Value.absent(),
  });
  SleepSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.durationInMinutes = const Value.absent(),
    this.qualityRating = const Value.absent(),
  }) : userId = Value(userId),
       startedAt = Value(startedAt);
  static Insertable<SleepSession> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? durationInMinutes,
    Expression<int>? qualityRating,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (durationInMinutes != null) 'duration_in_minutes': durationInMinutes,
      if (qualityRating != null) 'quality_rating': qualityRating,
    });
  }

  SleepSessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int?>? durationInMinutes,
    Value<int?>? qualityRating,
  }) {
    return SleepSessionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      durationInMinutes: durationInMinutes ?? this.durationInMinutes,
      qualityRating: qualityRating ?? this.qualityRating,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (durationInMinutes.present) {
      map['duration_in_minutes'] = Variable<int>(durationInMinutes.value);
    }
    if (qualityRating.present) {
      map['quality_rating'] = Variable<int>(qualityRating.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepSessionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationInMinutes: $durationInMinutes, ')
          ..write('qualityRating: $qualityRating')
          ..write(')'))
        .toString();
  }
}

class $SleepSessionFactorsTable extends SleepSessionFactors
    with TableInfo<$SleepSessionFactorsTable, SleepSessionFactor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepSessionFactorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sleepSessionIdMeta = const VerificationMeta(
    'sleepSessionId',
  );
  @override
  late final GeneratedColumn<int> sleepSessionId = GeneratedColumn<int>(
    'sleep_session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sleep_sessions (id)',
    ),
  );
  static const VerificationMeta _factorIdMeta = const VerificationMeta(
    'factorId',
  );
  @override
  late final GeneratedColumn<int> factorId = GeneratedColumn<int>(
    'factor_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES factors (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [sleepSessionId, factorId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_session_factors';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepSessionFactor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sleep_session_id')) {
      context.handle(
        _sleepSessionIdMeta,
        sleepSessionId.isAcceptableOrUnknown(
          data['sleep_session_id']!,
          _sleepSessionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sleepSessionIdMeta);
    }
    if (data.containsKey('factor_id')) {
      context.handle(
        _factorIdMeta,
        factorId.isAcceptableOrUnknown(data['factor_id']!, _factorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_factorIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sleepSessionId, factorId};
  @override
  SleepSessionFactor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepSessionFactor(
      sleepSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_session_id'],
      )!,
      factorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}factor_id'],
      )!,
    );
  }

  @override
  $SleepSessionFactorsTable createAlias(String alias) {
    return $SleepSessionFactorsTable(attachedDatabase, alias);
  }
}

class SleepSessionFactor extends DataClass
    implements Insertable<SleepSessionFactor> {
  final int sleepSessionId;
  final int factorId;
  const SleepSessionFactor({
    required this.sleepSessionId,
    required this.factorId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sleep_session_id'] = Variable<int>(sleepSessionId);
    map['factor_id'] = Variable<int>(factorId);
    return map;
  }

  SleepSessionFactorsCompanion toCompanion(bool nullToAbsent) {
    return SleepSessionFactorsCompanion(
      sleepSessionId: Value(sleepSessionId),
      factorId: Value(factorId),
    );
  }

  factory SleepSessionFactor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepSessionFactor(
      sleepSessionId: serializer.fromJson<int>(json['sleepSessionId']),
      factorId: serializer.fromJson<int>(json['factorId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sleepSessionId': serializer.toJson<int>(sleepSessionId),
      'factorId': serializer.toJson<int>(factorId),
    };
  }

  SleepSessionFactor copyWith({int? sleepSessionId, int? factorId}) =>
      SleepSessionFactor(
        sleepSessionId: sleepSessionId ?? this.sleepSessionId,
        factorId: factorId ?? this.factorId,
      );
  SleepSessionFactor copyWithCompanion(SleepSessionFactorsCompanion data) {
    return SleepSessionFactor(
      sleepSessionId: data.sleepSessionId.present
          ? data.sleepSessionId.value
          : this.sleepSessionId,
      factorId: data.factorId.present ? data.factorId.value : this.factorId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepSessionFactor(')
          ..write('sleepSessionId: $sleepSessionId, ')
          ..write('factorId: $factorId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sleepSessionId, factorId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepSessionFactor &&
          other.sleepSessionId == this.sleepSessionId &&
          other.factorId == this.factorId);
}

class SleepSessionFactorsCompanion extends UpdateCompanion<SleepSessionFactor> {
  final Value<int> sleepSessionId;
  final Value<int> factorId;
  final Value<int> rowid;
  const SleepSessionFactorsCompanion({
    this.sleepSessionId = const Value.absent(),
    this.factorId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepSessionFactorsCompanion.insert({
    required int sleepSessionId,
    required int factorId,
    this.rowid = const Value.absent(),
  }) : sleepSessionId = Value(sleepSessionId),
       factorId = Value(factorId);
  static Insertable<SleepSessionFactor> custom({
    Expression<int>? sleepSessionId,
    Expression<int>? factorId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sleepSessionId != null) 'sleep_session_id': sleepSessionId,
      if (factorId != null) 'factor_id': factorId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepSessionFactorsCompanion copyWith({
    Value<int>? sleepSessionId,
    Value<int>? factorId,
    Value<int>? rowid,
  }) {
    return SleepSessionFactorsCompanion(
      sleepSessionId: sleepSessionId ?? this.sleepSessionId,
      factorId: factorId ?? this.factorId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sleepSessionId.present) {
      map['sleep_session_id'] = Variable<int>(sleepSessionId.value);
    }
    if (factorId.present) {
      map['factor_id'] = Variable<int>(factorId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepSessionFactorsCompanion(')
          ..write('sleepSessionId: $sleepSessionId, ')
          ..write('factorId: $factorId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $FactorsTable factors = $FactorsTable(this);
  late final $SleepSessionsTable sleepSessions = $SleepSessionsTable(this);
  late final $SleepSessionFactorsTable sleepSessionFactors =
      $SleepSessionFactorsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    factors,
    sleepSessions,
    sleepSessionFactors,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String name,
      required String email,
      required String password,
      Value<String?> primaryActivity,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> email,
      Value<String> password,
      Value<String?> primaryActivity,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FactorsTable, List<Factor>> _factorsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.factors,
    aliasName: $_aliasNameGenerator(db.users.id, db.factors.userId),
  );

  $$FactorsTableProcessedTableManager get factorsRefs {
    final manager = $$FactorsTableTableManager(
      $_db,
      $_db.factors,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_factorsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SleepSessionsTable, List<SleepSession>>
  _sleepSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sleepSessions,
    aliasName: $_aliasNameGenerator(db.users.id, db.sleepSessions.userId),
  );

  $$SleepSessionsTableProcessedTableManager get sleepSessionsRefs {
    final manager = $$SleepSessionsTableTableManager(
      $_db,
      $_db.sleepSessions,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sleepSessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryActivity => $composableBuilder(
    column: $table.primaryActivity,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> factorsRefs(
    Expression<bool> Function($$FactorsTableFilterComposer f) f,
  ) {
    final $$FactorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.factors,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FactorsTableFilterComposer(
            $db: $db,
            $table: $db.factors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sleepSessionsRefs(
    Expression<bool> Function($$SleepSessionsTableFilterComposer f) f,
  ) {
    final $$SleepSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sleepSessions,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepSessionsTableFilterComposer(
            $db: $db,
            $table: $db.sleepSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryActivity => $composableBuilder(
    column: $table.primaryActivity,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get primaryActivity => $composableBuilder(
    column: $table.primaryActivity,
    builder: (column) => column,
  );

  Expression<T> factorsRefs<T extends Object>(
    Expression<T> Function($$FactorsTableAnnotationComposer a) f,
  ) {
    final $$FactorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.factors,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FactorsTableAnnotationComposer(
            $db: $db,
            $table: $db.factors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sleepSessionsRefs<T extends Object>(
    Expression<T> Function($$SleepSessionsTableAnnotationComposer a) f,
  ) {
    final $$SleepSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sleepSessions,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sleepSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool factorsRefs, bool sleepSessionsRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String?> primaryActivity = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                email: email,
                password: password,
                primaryActivity: primaryActivity,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String email,
                required String password,
                Value<String?> primaryActivity = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                email: email,
                password: password,
                primaryActivity: primaryActivity,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({factorsRefs = false, sleepSessionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (factorsRefs) db.factors,
                    if (sleepSessionsRefs) db.sleepSessions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (factorsRefs)
                        await $_getPrefetchedData<User, $UsersTable, Factor>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._factorsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(db, table, p0).factorsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sleepSessionsRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          SleepSession
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._sleepSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).sleepSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
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

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool factorsRefs, bool sleepSessionsRefs})
    >;
typedef $$FactorsTableCreateCompanionBuilder =
    FactorsCompanion Function({
      Value<int> id,
      required String name,
      required String icon,
      Value<bool> isDefault,
      Value<int?> userId,
    });
typedef $$FactorsTableUpdateCompanionBuilder =
    FactorsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> icon,
      Value<bool> isDefault,
      Value<int?> userId,
    });

final class $$FactorsTableReferences
    extends BaseReferences<_$AppDatabase, $FactorsTable, Factor> {
  $$FactorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.factors.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<int>('user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $SleepSessionFactorsTable,
    List<SleepSessionFactor>
  >
  _sleepSessionFactorsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sleepSessionFactors,
        aliasName: $_aliasNameGenerator(
          db.factors.id,
          db.sleepSessionFactors.factorId,
        ),
      );

  $$SleepSessionFactorsTableProcessedTableManager get sleepSessionFactorsRefs {
    final manager = $$SleepSessionFactorsTableTableManager(
      $_db,
      $_db.sleepSessionFactors,
    ).filter((f) => f.factorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sleepSessionFactorsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FactorsTableFilterComposer
    extends Composer<_$AppDatabase, $FactorsTable> {
  $$FactorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sleepSessionFactorsRefs(
    Expression<bool> Function($$SleepSessionFactorsTableFilterComposer f) f,
  ) {
    final $$SleepSessionFactorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sleepSessionFactors,
      getReferencedColumn: (t) => t.factorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepSessionFactorsTableFilterComposer(
            $db: $db,
            $table: $db.sleepSessionFactors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FactorsTableOrderingComposer
    extends Composer<_$AppDatabase, $FactorsTable> {
  $$FactorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FactorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FactorsTable> {
  $$FactorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> sleepSessionFactorsRefs<T extends Object>(
    Expression<T> Function($$SleepSessionFactorsTableAnnotationComposer a) f,
  ) {
    final $$SleepSessionFactorsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sleepSessionFactors,
          getReferencedColumn: (t) => t.factorId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SleepSessionFactorsTableAnnotationComposer(
                $db: $db,
                $table: $db.sleepSessionFactors,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FactorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FactorsTable,
          Factor,
          $$FactorsTableFilterComposer,
          $$FactorsTableOrderingComposer,
          $$FactorsTableAnnotationComposer,
          $$FactorsTableCreateCompanionBuilder,
          $$FactorsTableUpdateCompanionBuilder,
          (Factor, $$FactorsTableReferences),
          Factor,
          PrefetchHooks Function({bool userId, bool sleepSessionFactorsRefs})
        > {
  $$FactorsTableTableManager(_$AppDatabase db, $FactorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FactorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FactorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FactorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<int?> userId = const Value.absent(),
              }) => FactorsCompanion(
                id: id,
                name: name,
                icon: icon,
                isDefault: isDefault,
                userId: userId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String icon,
                Value<bool> isDefault = const Value.absent(),
                Value<int?> userId = const Value.absent(),
              }) => FactorsCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                isDefault: isDefault,
                userId: userId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FactorsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({userId = false, sleepSessionFactorsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sleepSessionFactorsRefs) db.sleepSessionFactors,
                  ],
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
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable: $$FactorsTableReferences
                                        ._userIdTable(db),
                                    referencedColumn: $$FactorsTableReferences
                                        ._userIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sleepSessionFactorsRefs)
                        await $_getPrefetchedData<
                          Factor,
                          $FactorsTable,
                          SleepSessionFactor
                        >(
                          currentTable: table,
                          referencedTable: $$FactorsTableReferences
                              ._sleepSessionFactorsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FactorsTableReferences(
                                db,
                                table,
                                p0,
                              ).sleepSessionFactorsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.factorId == item.id,
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

typedef $$FactorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FactorsTable,
      Factor,
      $$FactorsTableFilterComposer,
      $$FactorsTableOrderingComposer,
      $$FactorsTableAnnotationComposer,
      $$FactorsTableCreateCompanionBuilder,
      $$FactorsTableUpdateCompanionBuilder,
      (Factor, $$FactorsTableReferences),
      Factor,
      PrefetchHooks Function({bool userId, bool sleepSessionFactorsRefs})
    >;
typedef $$SleepSessionsTableCreateCompanionBuilder =
    SleepSessionsCompanion Function({
      Value<int> id,
      required int userId,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<int?> durationInMinutes,
      Value<int?> qualityRating,
    });
typedef $$SleepSessionsTableUpdateCompanionBuilder =
    SleepSessionsCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<int?> durationInMinutes,
      Value<int?> qualityRating,
    });

final class $$SleepSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SleepSessionsTable, SleepSession> {
  $$SleepSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.sleepSessions.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $SleepSessionFactorsTable,
    List<SleepSessionFactor>
  >
  _sleepSessionFactorsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sleepSessionFactors,
        aliasName: $_aliasNameGenerator(
          db.sleepSessions.id,
          db.sleepSessionFactors.sleepSessionId,
        ),
      );

  $$SleepSessionFactorsTableProcessedTableManager get sleepSessionFactorsRefs {
    final manager = $$SleepSessionFactorsTableTableManager(
      $_db,
      $_db.sleepSessionFactors,
    ).filter((f) => f.sleepSessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sleepSessionFactorsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SleepSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SleepSessionsTable> {
  $$SleepSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationInMinutes => $composableBuilder(
    column: $table.durationInMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get qualityRating => $composableBuilder(
    column: $table.qualityRating,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sleepSessionFactorsRefs(
    Expression<bool> Function($$SleepSessionFactorsTableFilterComposer f) f,
  ) {
    final $$SleepSessionFactorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sleepSessionFactors,
      getReferencedColumn: (t) => t.sleepSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepSessionFactorsTableFilterComposer(
            $db: $db,
            $table: $db.sleepSessionFactors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SleepSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepSessionsTable> {
  $$SleepSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationInMinutes => $composableBuilder(
    column: $table.durationInMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get qualityRating => $composableBuilder(
    column: $table.qualityRating,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SleepSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepSessionsTable> {
  $$SleepSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get durationInMinutes => $composableBuilder(
    column: $table.durationInMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get qualityRating => $composableBuilder(
    column: $table.qualityRating,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> sleepSessionFactorsRefs<T extends Object>(
    Expression<T> Function($$SleepSessionFactorsTableAnnotationComposer a) f,
  ) {
    final $$SleepSessionFactorsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sleepSessionFactors,
          getReferencedColumn: (t) => t.sleepSessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SleepSessionFactorsTableAnnotationComposer(
                $db: $db,
                $table: $db.sleepSessionFactors,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SleepSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SleepSessionsTable,
          SleepSession,
          $$SleepSessionsTableFilterComposer,
          $$SleepSessionsTableOrderingComposer,
          $$SleepSessionsTableAnnotationComposer,
          $$SleepSessionsTableCreateCompanionBuilder,
          $$SleepSessionsTableUpdateCompanionBuilder,
          (SleepSession, $$SleepSessionsTableReferences),
          SleepSession,
          PrefetchHooks Function({bool userId, bool sleepSessionFactorsRefs})
        > {
  $$SleepSessionsTableTableManager(_$AppDatabase db, $SleepSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int?> durationInMinutes = const Value.absent(),
                Value<int?> qualityRating = const Value.absent(),
              }) => SleepSessionsCompanion(
                id: id,
                userId: userId,
                startedAt: startedAt,
                endedAt: endedAt,
                durationInMinutes: durationInMinutes,
                qualityRating: qualityRating,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int?> durationInMinutes = const Value.absent(),
                Value<int?> qualityRating = const Value.absent(),
              }) => SleepSessionsCompanion.insert(
                id: id,
                userId: userId,
                startedAt: startedAt,
                endedAt: endedAt,
                durationInMinutes: durationInMinutes,
                qualityRating: qualityRating,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SleepSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({userId = false, sleepSessionFactorsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sleepSessionFactorsRefs) db.sleepSessionFactors,
                  ],
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
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable:
                                        $$SleepSessionsTableReferences
                                            ._userIdTable(db),
                                    referencedColumn:
                                        $$SleepSessionsTableReferences
                                            ._userIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sleepSessionFactorsRefs)
                        await $_getPrefetchedData<
                          SleepSession,
                          $SleepSessionsTable,
                          SleepSessionFactor
                        >(
                          currentTable: table,
                          referencedTable: $$SleepSessionsTableReferences
                              ._sleepSessionFactorsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SleepSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).sleepSessionFactorsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sleepSessionId == item.id,
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

typedef $$SleepSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SleepSessionsTable,
      SleepSession,
      $$SleepSessionsTableFilterComposer,
      $$SleepSessionsTableOrderingComposer,
      $$SleepSessionsTableAnnotationComposer,
      $$SleepSessionsTableCreateCompanionBuilder,
      $$SleepSessionsTableUpdateCompanionBuilder,
      (SleepSession, $$SleepSessionsTableReferences),
      SleepSession,
      PrefetchHooks Function({bool userId, bool sleepSessionFactorsRefs})
    >;
typedef $$SleepSessionFactorsTableCreateCompanionBuilder =
    SleepSessionFactorsCompanion Function({
      required int sleepSessionId,
      required int factorId,
      Value<int> rowid,
    });
typedef $$SleepSessionFactorsTableUpdateCompanionBuilder =
    SleepSessionFactorsCompanion Function({
      Value<int> sleepSessionId,
      Value<int> factorId,
      Value<int> rowid,
    });

final class $$SleepSessionFactorsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SleepSessionFactorsTable,
          SleepSessionFactor
        > {
  $$SleepSessionFactorsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SleepSessionsTable _sleepSessionIdTable(_$AppDatabase db) =>
      db.sleepSessions.createAlias(
        $_aliasNameGenerator(
          db.sleepSessionFactors.sleepSessionId,
          db.sleepSessions.id,
        ),
      );

  $$SleepSessionsTableProcessedTableManager get sleepSessionId {
    final $_column = $_itemColumn<int>('sleep_session_id')!;

    final manager = $$SleepSessionsTableTableManager(
      $_db,
      $_db.sleepSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sleepSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FactorsTable _factorIdTable(_$AppDatabase db) =>
      db.factors.createAlias(
        $_aliasNameGenerator(db.sleepSessionFactors.factorId, db.factors.id),
      );

  $$FactorsTableProcessedTableManager get factorId {
    final $_column = $_itemColumn<int>('factor_id')!;

    final manager = $$FactorsTableTableManager(
      $_db,
      $_db.factors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_factorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SleepSessionFactorsTableFilterComposer
    extends Composer<_$AppDatabase, $SleepSessionFactorsTable> {
  $$SleepSessionFactorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SleepSessionsTableFilterComposer get sleepSessionId {
    final $$SleepSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sleepSessionId,
      referencedTable: $db.sleepSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepSessionsTableFilterComposer(
            $db: $db,
            $table: $db.sleepSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FactorsTableFilterComposer get factorId {
    final $$FactorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.factorId,
      referencedTable: $db.factors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FactorsTableFilterComposer(
            $db: $db,
            $table: $db.factors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SleepSessionFactorsTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepSessionFactorsTable> {
  $$SleepSessionFactorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SleepSessionsTableOrderingComposer get sleepSessionId {
    final $$SleepSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sleepSessionId,
      referencedTable: $db.sleepSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sleepSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FactorsTableOrderingComposer get factorId {
    final $$FactorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.factorId,
      referencedTable: $db.factors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FactorsTableOrderingComposer(
            $db: $db,
            $table: $db.factors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SleepSessionFactorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepSessionFactorsTable> {
  $$SleepSessionFactorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SleepSessionsTableAnnotationComposer get sleepSessionId {
    final $$SleepSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sleepSessionId,
      referencedTable: $db.sleepSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sleepSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FactorsTableAnnotationComposer get factorId {
    final $$FactorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.factorId,
      referencedTable: $db.factors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FactorsTableAnnotationComposer(
            $db: $db,
            $table: $db.factors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SleepSessionFactorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SleepSessionFactorsTable,
          SleepSessionFactor,
          $$SleepSessionFactorsTableFilterComposer,
          $$SleepSessionFactorsTableOrderingComposer,
          $$SleepSessionFactorsTableAnnotationComposer,
          $$SleepSessionFactorsTableCreateCompanionBuilder,
          $$SleepSessionFactorsTableUpdateCompanionBuilder,
          (SleepSessionFactor, $$SleepSessionFactorsTableReferences),
          SleepSessionFactor,
          PrefetchHooks Function({bool sleepSessionId, bool factorId})
        > {
  $$SleepSessionFactorsTableTableManager(
    _$AppDatabase db,
    $SleepSessionFactorsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepSessionFactorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepSessionFactorsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SleepSessionFactorsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> sleepSessionId = const Value.absent(),
                Value<int> factorId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepSessionFactorsCompanion(
                sleepSessionId: sleepSessionId,
                factorId: factorId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int sleepSessionId,
                required int factorId,
                Value<int> rowid = const Value.absent(),
              }) => SleepSessionFactorsCompanion.insert(
                sleepSessionId: sleepSessionId,
                factorId: factorId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SleepSessionFactorsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sleepSessionId = false, factorId = false}) {
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
                    if (sleepSessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sleepSessionId,
                                referencedTable:
                                    $$SleepSessionFactorsTableReferences
                                        ._sleepSessionIdTable(db),
                                referencedColumn:
                                    $$SleepSessionFactorsTableReferences
                                        ._sleepSessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (factorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.factorId,
                                referencedTable:
                                    $$SleepSessionFactorsTableReferences
                                        ._factorIdTable(db),
                                referencedColumn:
                                    $$SleepSessionFactorsTableReferences
                                        ._factorIdTable(db)
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

typedef $$SleepSessionFactorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SleepSessionFactorsTable,
      SleepSessionFactor,
      $$SleepSessionFactorsTableFilterComposer,
      $$SleepSessionFactorsTableOrderingComposer,
      $$SleepSessionFactorsTableAnnotationComposer,
      $$SleepSessionFactorsTableCreateCompanionBuilder,
      $$SleepSessionFactorsTableUpdateCompanionBuilder,
      (SleepSessionFactor, $$SleepSessionFactorsTableReferences),
      SleepSessionFactor,
      PrefetchHooks Function({bool sleepSessionId, bool factorId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$FactorsTableTableManager get factors =>
      $$FactorsTableTableManager(_db, _db.factors);
  $$SleepSessionsTableTableManager get sleepSessions =>
      $$SleepSessionsTableTableManager(_db, _db.sleepSessions);
  $$SleepSessionFactorsTableTableManager get sleepSessionFactors =>
      $$SleepSessionFactorsTableTableManager(_db, _db.sleepSessionFactors);
}
