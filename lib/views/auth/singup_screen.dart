import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:shop_my/router/routes.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({
    super.key,
  });

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final _firestore = FirebaseFirestore.instance;

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final userName = TextEditingController();
  final userPhone = TextEditingController();
  String? namenew;
  String? phonenew;
  late DatabaseReference dbref;

  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('name');
  }

  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
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

    return SingleChildScrollView(
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(20, 110, 20, 70),
            child: const FlutterLogo(
              size: 180,
            ),
          ),
          const Text(
            "Craete New Account",
            style: TextStyle(fontSize: 25),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    onChanged: (newValue) {
                      // ignore: avoid_print
                      print("object------------------------$newValue");
                      setState(() {
                        email = newValue;
                      });
                    },
                    validator: (value) {
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      // ignore: unnecessary_null_comparison
                      if (value == null) {
                        return "Please Enter your email";
                      } else if (!emailValid) {
                        return "Wrong email format";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Email',
                        hintText: 'Enter Your Email'),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: TextFormField(
                    onChanged: (newValue) {
                      setState(() {
                        password = newValue;
                      });
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: 'Password',
                        hintText: 'Enter Your Password'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: SizedBox(
                    width: 320,
                    child: TextField(
                      onChanged: ((value) => namenew = value),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          labelText: "Name",
                          hintText: 'Enter Your Name'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 320,
                  child: TextField(
                    onChanged: ((value) => phonenew = value),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        labelText: "Phone",
                        hintText: 'Enter Your Number'),
                  ),
                )
              ],
            ),
          ),
          Container(
              height: 80,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: (() {
                  onPressLogin();
                  _firestore.collection('users').add({
                    'name': namenew,
                    'phone': phonenew,
                  });
                }),
                child: const Text('Sing Up'),
              )),
          TextButton(
            onPressed: () {
              addUser();
              onPressNewAccount();
            },
            child: Text(
              'Login?',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      )),
    );
  }

  void onPressNewAccount() {
    Navigator.pushNamed(context, loginRoute);
  }

  void onPressLogin() async {
    if (formKey.currentState!.validate()) {
      // ignore: avoid_print
      print("email-----------------------------------------$email");
      // ignore: avoid_print
      print("password-----------------------------------------$password");
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      try {
        // ignore: unused_local_variable
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!)
            .then((value) => Navigator.pushNamed(context, appRootRoute));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('The password provided is too weak.'),
                backgroundColor: Colors.red),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('The account already exists for that email.'),
                backgroundColor: Colors.red),
          );
        }
      }
    }
  }
}
