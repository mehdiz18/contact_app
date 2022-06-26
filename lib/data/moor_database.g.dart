// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Contact extends DataClass implements Insertable<Contact> {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? picture;
  Contact(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      this.picture});
  factory Contact.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Contact(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      firstName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name'])!,
      lastName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name'])!,
      phoneNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone_number'])!,
      picture: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}picture']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || picture != null) {
      map['picture'] = Variable<String?>(picture);
    }
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      phoneNumber: Value(phoneNumber),
      picture: picture == null && nullToAbsent
          ? const Value.absent()
          : Value(picture),
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      picture: serializer.fromJson<String?>(json['picture']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'picture': serializer.toJson<String?>(picture),
    };
  }

  Contact copyWith(
          {int? id,
          String? firstName,
          String? lastName,
          String? phoneNumber,
          String? picture}) =>
      Contact(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        picture: picture ?? this.picture,
      );
  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('picture: $picture')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, firstName, lastName, phoneNumber, picture);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.phoneNumber == this.phoneNumber &&
          other.picture == this.picture);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> phoneNumber;
  final Value<String?> picture;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.picture = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required String phoneNumber,
    this.picture = const Value.absent(),
  })  : firstName = Value(firstName),
        lastName = Value(lastName),
        phoneNumber = Value(phoneNumber);
  static Insertable<Contact> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? phoneNumber,
    Expression<String?>? picture,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (picture != null) 'picture': picture,
    });
  }

  ContactsCompanion copyWith(
      {Value<int>? id,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String>? phoneNumber,
      Value<String?>? picture}) {
    return ContactsCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      picture: picture ?? this.picture,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (picture.present) {
      map['picture'] = Variable<String?>(picture.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('picture: $picture')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String?> firstName = GeneratedColumn<String?>(
      'first_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String?> lastName = GeneratedColumn<String?>(
      'last_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String?> phoneNumber = GeneratedColumn<String?>(
      'phone_number', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _pictureMeta = const VerificationMeta('picture');
  @override
  late final GeneratedColumn<String?> picture = GeneratedColumn<String?>(
      'picture', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, firstName, lastName, phoneNumber, picture];
  @override
  String get aliasedName => _alias ?? 'contacts';
  @override
  String get actualTableName => 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<Contact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('picture')) {
      context.handle(_pictureMeta,
          picture.isAcceptableOrUnknown(data['picture']!, _pictureMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Contact.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final ContactDao contactDao = ContactDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [contacts];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$ContactDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContactsTable get contacts => attachedDatabase.contacts;
}
