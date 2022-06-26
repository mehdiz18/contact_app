import 'package:contacts_app/data/moor_database.dart';
import 'package:contacts_app/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final AppDatabase _db = AppDatabase();
  @override
  Widget build(BuildContext context) {
    return Provider<ContactDao>(
      create: (context) {
        return ContactDao(_db);
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contacts',
        home: Home(),
      ),
    );
  }
}
