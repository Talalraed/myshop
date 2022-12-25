import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shop_my/router/routes.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _firestore = FirebaseFirestore.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  String? namenew;
  String? phonenew;
  final userName = TextEditingController();
  final userPhone = TextEditingController();
  late DatabaseReference dbref;
  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('user');
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference collectionref =
        FirebaseFirestore.instance.collection('users');
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return collectionref
          .add({
            'name': namenew, // John Doe
            'phone': phonenew, // Stokes and Sons
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: const Text("Profile"),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 5.00,
          backgroundColor: const Color.fromARGB(255, 19, 204, 255),
        ), //A
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
                        child: const FlutterLogo(
                          size: 100,
                        ),
                      ),
                      const Text(
                        "Enter your Data",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      TextField(
                        onChanged: ((value) => namenew = value),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: "Name", hintText: 'Enter Your Name'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      TextField(
                        onChanged: ((value) => phonenew = value),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Phone", hintText: 'Enter Your Number'),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      MaterialButton(
                        onPressed: () {
                          _firestore.collection('users').add({
                            'name': namenew,
                            'phone': phonenew,
                          });
                          Navigator.pushNamed(context, homeRoute);
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        minWidth: 300,
                        height: 40,
                        child: const Text('Submit'),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       var currentState;
                      //       if (_formKey.currentState!.validate()) {
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           const SnackBar(
                      //               content: Text('Processing Data')),
                      //         );
                      //       }
                      //     },
                      //     child: const Text('Submit'),
                      //   ),
                      // ),
                    ]),
              )),
        ));
  }
}
