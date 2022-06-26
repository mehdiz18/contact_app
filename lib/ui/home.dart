// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:contacts_app/data/moor_database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<ContactDao>(context).db.contactDao;
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts")),
      body: _buildContactList(context, dao),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addContact(context, dao),
      ),
    );
  }

  Widget _buildContactList(BuildContext context, ContactDao dao) {
    return StreamBuilder(
      stream: dao.watchContacts(),
      builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text("Y'a rien a voir ici"),
          );
        }
        if (snapshot.data!.isEmpty) {
          return Center(
            child: Text("Ajoutez un contact"),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return _buildContactTile(context, snapshot.data![index]);
            });
      },
    );
  }

  Widget _buildContactTile(BuildContext context, Contact contact) {
    return Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => _modifyContact(
                  context,
                  contact,
                  Provider.of<ContactDao>(context, listen: false)
                      .db
                      .contactDao),
              backgroundColor: Colors.blue.shade200,
              foregroundColor: Colors.white,
              label: "Modifier",
              icon: Icons.delete,
            ),
            SlidableAction(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              onPressed: (context) {
                _deleteContact(
                    contact,
                    Provider.of<ContactDao>(context, listen: false)
                        .db
                        .contactDao);
              },
              label: "Supprimer",
              icon: Icons.delete,
            )
          ],
        ),
        child: ListTile(
          onTap: () => Navigator.push(context, _aboutPerson(context, contact)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.phone, color: Colors.green),
              SizedBox(width: 30),
              Icon(Icons.message, color: Colors.blue),
            ],
          ),
          leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: contact.picture == null
                  ? Icon(
                      Icons.person,
                      size: 43,
                    )
                  : Image.file(File(contact.picture!))),
          title: Text("${contact.firstName} ${contact.lastName}"),
          subtitle: Text(contact.phoneNumber),
        ));
  }

  MaterialPageRoute<void> _aboutPerson(BuildContext context, Contact contact) {
    return MaterialPageRoute(builder: ((context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("${contact.firstName} ${contact.lastName}"),
        ),
        body: Column(
          children: [
            SizedBox(height: 80),
            Container(
              alignment: Alignment.center,
              child: CircularProfileAvatar(
                '',
                elevation: 30,
                child: contact.picture == null
                    ? Icon(Icons.person, size: 43)
                    : Image.file(
                        File(contact.picture!),
                      ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: contact.firstName),
                    decoration: InputDecoration(
                        icon: Icon(Icons.person_pin_rounded),
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(text: contact.lastName),
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    readOnly: true,
                    controller:
                        TextEditingController(text: contact.phoneNumber),
                    decoration: InputDecoration(
                        icon: Icon(Icons.phone),
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                  ),
                ],
              ),
            ),
          ],
        ),
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {},
                child: Column(
                  children: [
                    Icon(Icons.mode),
                    Text("Modifier"),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteContact(
                      contact,
                      Provider.of<ContactDao>(context, listen: false)
                          .db
                          .contactDao);
                },
                child: Column(
                  children: [
                    Icon(Icons.delete),
                    Text("Supprimer"),
                  ],
                ),
              )
            ],
          )
        ],
      );
    }));
  }

  void _modifyContact(BuildContext context, Contact contact, ContactDao dao) {
    TextEditingController firstNameController =
        TextEditingController(text: contact.firstName);
    TextEditingController lastNameController =
        TextEditingController(text: contact.lastName);
    TextEditingController phoneNumberController =
        TextEditingController(text: contact.phoneNumber);
    String path = "";
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Modifier un contact", textAlign: TextAlign.center),
          contentPadding: EdgeInsets.all(20),
          children: [
            TextField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(hintText: "Prenom"),
              controller: firstNameController,
            ),
            SizedBox(height: 20),
            TextField(
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(hintText: "Nom"),
              controller: lastNameController,
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Numéro de téléphone"),
              controller: phoneNumberController,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                    onPressed: () async {
                      path = await _pickAnImage();
                    },
                    child: Text('Séléctionner une image')),
                SizedBox(width: 100),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  dao.updateContact(contact.copyWith(
                      firstName: firstNameController.value.text,
                      lastName: lastNameController.value.text,
                      phoneNumber: phoneNumberController.value.text,
                      picture: path == "" ? null : path));
                  Navigator.of(context).pop();
                },
                child: Text("Modifier le contact"))
          ],
        );
      },
    );
  }

  void _addContact(BuildContext context, ContactDao dao) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    String path = "";
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Ajouter un contact", textAlign: TextAlign.center),
          contentPadding: EdgeInsets.all(20),
          children: [
            TextField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(hintText: "Prenom"),
              controller: firstNameController,
            ),
            SizedBox(height: 20),
            TextField(
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(hintText: "Nom"),
              controller: lastNameController,
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Numéro de téléphone"),
              controller: phoneNumberController,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                    onPressed: () async {
                      path = await _pickAnImage();
                    },
                    child: Text('Séléctionner une image')),
                SizedBox(width: 100),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  dao.insertContact(ContactsCompanion(
                      firstName: drift.Value(firstNameController.value.text),
                      lastName: drift.Value(lastNameController.value.text),
                      phoneNumber:
                          drift.Value(phoneNumberController.value.text),
                      picture: path == ""
                          ? drift.Value.absent()
                          : drift.Value(path)));
                  Navigator.of(context).pop();
                },
                child: Text("Ajouter le contact"))
          ],
        );
      },
    );
  }

  void _deleteContact(Contact contact, ContactDao dao) {
    dao.deleteContact(contact);
  }

  Future<String> _pickAnImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    final documentsPath = await getApplicationDocumentsDirectory();
    if (image == null) {
      return "";
    }

    final path = join(documentsPath.path, image.name);
    image.saveTo(path);
    return path;
  }
}
