import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'moor_database.g.dart';

class Contacts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get picture => text().nullable()();
}

@DriftDatabase(tables: [Contacts], daos: [ContactDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

@DriftAccessor(tables: [Contacts])
class ContactDao extends DatabaseAccessor<AppDatabase> with _$ContactDaoMixin {
  final AppDatabase db;
  ContactDao(this.db) : super(db);

  Stream<List<Contact>> watchContacts() => select(contacts).watch();
  Future insertContact(Insertable<Contact> contact) =>
      into(contacts).insert(contact);
  Future deleteContact(Insertable<Contact> contact) =>
      delete(contacts).delete(contact);
  Future updateContact(Insertable<Contact> contact) =>
      update(contacts).replace(contact);
}

LazyDatabase _openConnection() {
  return LazyDatabase((() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(join(dbFolder.path, "contacts.sqlite"));
    return NativeDatabase(dbFile);
  }));
}
