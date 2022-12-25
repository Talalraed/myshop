import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// ignore: implementation_imports
import 'package:shop_my/router/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            padding: const EdgeInsets.fromLTRB(20, 110, 20, 70),
            child: const FlutterLogo(
              size: 180,
            ),
          ),
          const Text(
            "Login to your Account",
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
                    obscureText: true,
                    onChanged: (newValue) {
                      setState(() {
                        password = newValue;
                      });
                    },
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
                onPressed: onPressLogin,
                child: const Text('Log In'),
              )),
          TextButton(
            onPressed: onPressNewAccount,
            child: Text(
              'New account?',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      )),
    );
  }

  void onPressNewAccount() {
    Navigator.pushNamed(context, singupRoute);
  }

  void onPressLogin() async {
    if (formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      try {
        // ignore: unused_local_variable
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!)
            .then((value) => Navigator.pushNamed(context, appRootRoute));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('No user found for that email.'),
                backgroundColor: Colors.red),
          );
          // ignore: avoid_print
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Wrong password provided for that user'),
                backgroundColor: Colors.red),
          );
          // ignore: avoid_print
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
