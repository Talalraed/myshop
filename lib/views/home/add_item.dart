import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:shop_my/router/routes.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final userName = TextEditingController();
  final userPhone = TextEditingController();
  String? titlenew;
  double? pricenew;
  String? idnew;
  double? discountnew;
  double? taxnew;
  String? imgnew;
  late DatabaseReference dbref;
  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child('itmes');
  }

  Widget build(BuildContext context) {
    CollectionReference collectionref =
        FirebaseFirestore.instance.collection('itmes');
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return collectionref
          .add({
            'title': titlenew, // John Doe
            'price': pricenew,
            'id': idnew,
            'Discount': discountnew,
            'Tax': taxnew,
            'img': imgnew,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        // ignore: prefer_const_literals_to_create_immutables
        actions: <Widget>[
          // ignore: prefer_const_constructors
          // IconButton(
          //   icon: const Icon(
          //     Icons.shopping_bag_outlined,
          //     color: Color.fromARGB(255, 255, 255, 255),
          //   ),
          //   // onPressed: () {
          //   //   Navigator.pushNamed(context, detailsRoute, arguments: cartItems);
          //   // },
          // ),
        ],
        title: const Text("Add Items"),
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
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Enter Your Information For Items',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 20, backgroundColor: Colors.black12),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  child: SizedBox(
                    width: 320,
                    child: TextField(
                      onChanged: ((value) => titlenew = value),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          labelText: "Title",
                          hintText: 'Enter Your Title'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: Container(
                    child: SizedBox(
                      width: 320,
                      child: TextField(
                        onChanged: ((value) => pricenew = value as double?),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            labelText: "Price",
                            hintText: 'Enter Your Price'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: SizedBox(
                    width: 320,
                    child: TextField(
                      onChanged: ((value) => idnew = value),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          labelText: "Id",
                          hintText: 'Enter Your Id'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: SizedBox(
                    width: 320,
                    child: TextField(
                      onChanged: ((value) => discountnew = value as double?),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          labelText: "Discount",
                          hintText: 'Enter Your Discount'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: SizedBox(
                    width: 320,
                    child: TextField(
                      onChanged: ((value) => taxnew = value as double?),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          labelText: "Tax",
                          hintText: 'Enter Your Tax'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: SizedBox(
                    width: 320,
                    child: TextField(
                      onChanged: ((value) => imgnew = value),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          labelText: "Img",
                          hintText: 'Enter Your Img'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    alignment: Alignment.center,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Navigator.pushNamed(context, homeRoute);
                              // addUser();
                              // Navigator.pushNamed(context, historyRoute);
                            },
                            icon: const Icon(
                              // <-- Icon
                              Icons.done,
                              size: 24.0,
                            ),
                            label: const Text('Add Item'), // <-- Text
                          ),
                        ])),
                // TextButton(
                //   onPressed: () {
                //     addUser();
                //   },
                //   child: Text(
                //     'Login?',
                //     style: TextStyle(color: Colors.grey[600]),
                //   ),
                // ),
              ]),
        ),
      ),
    );
  }
}
