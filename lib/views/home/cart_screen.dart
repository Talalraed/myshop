// ignore: unused_import
// ignoreserfor_file: non_constant_identifier_names

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shop_my/router/routes.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_my/views/auth/item.dart';

import '../auth/update_record.dart';
import 'historyscreen.dart';
// ignore: implementation_imports

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.cartItems});
  final List<dynamic>? cartItems;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // ignore: non_constant_identifier_names
  dynamic HistoryItems = [];
  List<dynamic>? cartItemsWithCount = [];
  double? total = 0;
  // ignore: non_constant_identifier_names
  double? total_discount = 0;
  double quantity = 1;
  // ignore: non_constant_identifier_names
  double? total_tax = 0;

  // ignore: non_constant_identifier_names
  double? total_net = 0;
  String? messagename;
  String? messagephone;
  final formKey = GlobalKey<FormState>();
  TextEditingController dateInput = TextEditingController();
  var dbref = FirebaseDatabase.instance.ref().child('user');
  // ignore: non_constant_identifier_names
  Widget ListItem({required Map user}) {
    CollectionReference collectionref =
        FirebaseFirestore.instance.collection('history');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return collectionref
          .add({
            // 'name': messagename,
            // 'phone': messagephone,
            'total': total, // John Doe
            'total_net': total_net, // Stokes and Sons
            'total_discount': total_discount,
            "cartitem": widget.cartItems, // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // TextButton(
        //   onPressed: () {},
        //   child: Text(
        //     "Add User",
        //   ),
        // ),
        Container(
          padding: const EdgeInsets.all(015),
          margin: const EdgeInsets.all(0),
          alignment: Alignment.topLeft,
          // ignore: sort_child_properties_last
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              Center(
                  child: TextField(
                controller: dateInput,
                //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                    ),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      dateInput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {} //
                },
              )),
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('users').snapshots(),
                  builder: ((context, snapshot) {
                    const EdgeInsets.only(top: 15, bottom: 10, left: 3);
                    const EdgeInsets.only(left: 0);

                    List<Text> messageswidggets = [];
                    if (snapshot.hasData && snapshot.data != null) {
                      final messges = snapshot.data!.docs;
                      for (var message in messges) {
                        final messagename = message.get('name');
                        final messagephone = message.get('phone');
                        final messageswidgget = Text('Name: $messagename ',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ));

                        final messageswidggete = Text('Phone : $messagephone ',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ));
                        messageswidggets.add(messageswidgget);
                        messageswidggets.add(messageswidggete);
                      }
                    }
                    return Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: messageswidggets,
                    );
                  })),

              if (widget.cartItems != null && widget.cartItems!.isNotEmpty)
                Column(children: Test()),
              const Text(""),
              Container(
                alignment: Alignment.bottomLeft,
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Column(children: [
                        // ignore: prefer_const_constructors
                        Text(
                          'Total:$total ',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ]),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Column(children: [
                        Text(
                          "Total Discount:$total_discount",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ]),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Column(children: [
                        Text(
                          "Total Tax:$total_tax",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ]),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Column(children: [
                        Text(
                          "Total Net:$total_net",
                          style: TextStyle(fontSize: 15),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, historyRoute, arguments: {
                    "cartItems": widget.cartItems,
                    "total_discount": "$total_discount",
                    "total_tax": "$total_tax",
                    "total_net": "$total_net",
                  });
                  addUser();
                  // onPressAddToNewCart;
                  onPressAddToHistory;
                  // Navigator.pushNamed(context, historyRoute);
                },
                icon: const Icon(
                  // <-- Icon
                  Icons.shopping_basket_rounded,
                  size: 24.0,
                ),
                label: const Text('Submit'), // <-- Text
              ),
            ],
          ),
        ),
      ]),
    );
  }

  @override
  final _firestore = FirebaseFirestore.instance;

  // void getMessages() async {
  //   final messages = await _firestore.collection('users').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }
  void messagesStreams() async {
    await for (var snapshot in _firestore.collection('users').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("Cart"),
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
      body: SizedBox(
          height: double.infinity,
          child: FirebaseAnimatedList(
              query: dbref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map<dynamic, dynamic>? user = snapshot.value as Map;
                user['key'] = snapshot.key;
                return ListItem(user: user);
              })),
    ));
  }

  // ignore: non_constant_identifier_names
  List<Widget> Test() {
    List<Widget> list = [const SizedBox()];
    for (var data in widget.cartItems!) {
      list.add(SizedBox(height: 350, child: buildCard(data)));
    }
    return list;
  }

  Widget buildCard(data) {
    // ignore: unused_local_variable
    var count = 1;
    var afterQuantity = data.price * count;
    print("data------------------$data");
    return Text("fd");
    // var afterDiscount =
    //     afterQuantity - ((data.discount * 0.01) * afterQuantity);
    // var afterTax = afterDiscount + (afterDiscount * (data.tax * 0.01));
    // // ignore: unused_local_variable
    // var saveDiscount = (data.discount * 0.01) * data.total;
    // return Card(
    //   elevation: 3.0,
    //   child: Column(children: [
    //     ListTile(
    //       title: Text(
    //         "${data.title} ",
    //         style: const TextStyle(fontSize: 25),
    //       ),
    //       subtitle: Text(
    //         "${afterQuantity}",
    //         style: const TextStyle(fontSize: 20),
    //       ),
    //     ),
    //     SingleChildScrollView(
    //       child: Container(
    //         alignment: Alignment.center,
    //         child: SizedBox(
    //           height: 130.0,
    //           width: 250.0,
    //           child: Image.network(data.img),
    //         ),
    //       ),
    //     ),
    //     SingleChildScrollView(
    //       child: Container(
    //         margin: const EdgeInsets.all(5.0),
    //         alignment: Alignment.topRight,
    //         child: Column(
    //           children: <Widget>[
    //             ListTile(
    //               title: Text(
    //                 textAlign: TextAlign.start,
    //                 ' After Discount :$afterDiscount',
    //                 style: const TextStyle(
    //                   fontSize: 15,
    //                   color: Colors.red,
    //                 ),
    //               ),
    //               subtitle: Text(
    //                 ' After Tax :$afterTax',
    //                 style: const TextStyle(fontSize: 13),
    //               ),
    //               //trailing: Row(children: <Widget>[Text('$save_discount')]),
    //             ),
    //             Row(
    //               // ignore: prefer_const_literals_to_create_immutables
    //               children: <Widget>[
    //                 IconButton(
    //                   icon: const Icon(Icons.add),
    //                   color: Colors.green,
    //                   iconSize: 30,
    //                   onPressed: () {
    //                     {
    //                       setState(
    //                         () {
    //                           count++;
    //                         },
    //                       );
    //                     }
    //                   },
    //                 ),
    //                 Text('$count'),
    //                 IconButton(
    //                     icon: const Icon(Icons.remove),
    //                     color: Colors.red,
    //                     iconSize: 30,
    //                     onPressed: () {
    //                       {
    //                         {
    //                           setState(
    //                             () {
    //                               count--;
    //                             },
    //                           );
    //                         }
    //                       }
    //                     }),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ]),
    // );
  }

  void initState() {
    // ignore: avoid_print
    for (var item in widget.cartItems!) {
      setState(() {
        // var afterDiscount = afterQuantity - ((discount * 0.01) * afterQuantity);
        // var afterTax = afterDiscount + (afterDiscount * (tax * 0.01));
        total = total! + double.parse("${item['price']}");
        total_discount = total_discount! +
            (double.parse("${item['discount']}") * 0.01) *
                double.parse("${item['price']}");
        total_tax = (total! - total_discount!) *
            (double.parse("${item['tax']}") * 0.01);
        total_net = total! - total_discount! + total_tax!;
      });
      cartItemsWithCount?.add({item});
    }
    super.initState();
  }

// ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  void onPressAddtoOrderHistory(Item) {
    HistoryItems.add(Item);
  }

  void onPressNewAccount() {
    Navigator.pushNamed(context, singupRoute);
  }
}

void onPressAddToHistory(item) {
  cartItems.add(item);
  // ignore: avoid_print
  print(cartItems);
}


// Stream<QuerySnapshot<Map<String, dynamic>>> readUsers() =>
//     FirebaseFirestore.instance.collection('users').snapshots();
//     // ignore: use_function_type_syntax_for_parameters
//     map((e) => snapshot.docs.map((doc) => User.fromJosn(doc.data())).toList())
