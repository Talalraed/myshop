import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../router/routes.dart';

class UpdateRecord extends StatefulWidget {
  const UpdateRecord({Key? key, required this.userkey}) : super(key: key);
  final String userkey;

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  final userName = TextEditingController();
  final userPhone = TextEditingController();
  late DatabaseReference dbref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('user');
    getuserdata();
  }

  void getuserdata() async {
    DataSnapshot snapshot = (await dbref.child(widget.userkey).get());
    Map user = snapshot.value as Map;
    userName.text = user['name'];
    userPhone.text = user['phone'];
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Upadte')),
        body: Center(
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
                  "edit your Data",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 40,
                ),
                // TextField(
                //   controller: userName,
                //   keyboardType: TextInputType.text,
                //   decoration: const InputDecoration(
                //       labelText: "edit", hintText: 'Enter Your Email'),
                // ),
                TextField(
                  controller: userName,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: "Name", hintText: 'Enter Your Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: userPhone,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Phone", hintText: 'Enter Your Number'),
                ),

                const SizedBox(
                  height: 10,
                ),
                // TextField(
                //   controller: userPhone,
                //   keyboardType: TextInputType.number,
                //   decoration: const InputDecoration(
                //       labelText: "Password", hintText: 'Enter Your Password'),
                // ),

                MaterialButton(
                  onPressed: () {
                    Map<String, dynamic>? user = {
                      'name': userName.text,
                      'phone': userPhone.text,
                    };
                    dbref.child(widget.userkey).update(user).then((value) => {
                          Navigator.pop(context),
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
        ));
  }
}
