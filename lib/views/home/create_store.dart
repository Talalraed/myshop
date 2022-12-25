import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop_my/router/routes.dart';

class CreateStore extends StatefulWidget {
  const CreateStore({super.key});

  @override
  State<CreateStore> createState() => _CreateStoreState();
}

class _CreateStoreState extends State<CreateStore> {
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  String? id;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update"),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
          ),
          elevation: 5.00,
          backgroundColor: const Color.fromARGB(255, 19, 204, 255),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                final name = namecontroller.text;
                final phone = phonecontroller.text;
                // createUser(name: name, phone: phone);
              },
            ),
          ],
        ),
        body: ListView(padding: const EdgeInsets.all(50), children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
            margin: EdgeInsets.all(15),
            child: const FlutterLogo(
              size: 100,
            ),
          ),
          const Text(
            "Update Your Data",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          TextField(
            textAlign: TextAlign.center,
            style: TextStyle(),
            controller: namecontroller,
          ),
          TextField(
            textAlign: TextAlign.center,
            controller: phonecontroller,
          ),
          ElevatedButton(
              child: const Text('Update'),
              onPressed: () {
                editUserData;
                Navigator.pushNamed(context, homeRoute);
              }),
        ]));
  }

  void getUserId() async {
    QuerySnapshot<Map<String, dynamic>> qData = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: "5")
        .get();

    var userData = qData.docs[0];
    var userName = userData.data()["name"];
    var userPhone = userData.data()["phone"];
    setState(() {
      namecontroller.text = userName;
      phonecontroller.text = userPhone;
      id = userData.id;
    });
  }

  void editUserData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users
        .doc(id)
        .update({'name': namecontroller.text, "phone": phonecontroller.text})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}

class User {
  String id;
  final String name;
  final int phone;
  User({this.id = '', required this.name, required this.phone});
  Map<String, dynamic> tojson() => {'id': id, 'name': name, 'phone': phone};
  static User fromJson(Map<String, dynamic> josn) =>
      User(name: josn['name'], id: josn['id'], phone: josn['phone']);
}

Future createUser(User user) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc();
  user.id = docUser.id;
  final json = user.tojson();
  await docUser.set(json);
}
  // await docUser.get(User);

