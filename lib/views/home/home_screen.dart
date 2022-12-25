// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:shop_my/router/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// ignore: duplicate_ignore
class _HomeScreenState extends State<HomeScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('itmes').snapshots();

  dynamic HistoryItems = [];
  dynamic cartItems = [];
  final formKey = GlobalKey<FormState>(); //;onPressLogOut

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          // ignore: prefer_const_literals_to_create_immutables
          actions: <Widget>[
            // ignore: prefer_const_constructors
            IconButton(
              icon: const Icon(
                Icons.shopping_bag_outlined,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () {
                Navigator.pushNamed(context, detailsRoute,
                    arguments: cartItems);
              },
            ),
          ],
          title: const Text("Items"),
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
        ), //AppBar
        drawer: Drawer(
          backgroundColor: Colors.blue[50],
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: const EdgeInsets.only(left: 20, top: 50),
            children: [
              // ignore: prefer_const_constructors
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text(
                  'Update',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushNamed(context, CreatetoreRoute);
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text(
                  'App Item',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushNamed(context, AddItemRoute);
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text(
                  'History',
                  style: TextStyle(fontSize: 17),
                ),
                onTap: () {
                  Navigator.pushNamed(context, historyRoute);
                },
              ),
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 15),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pushNamed(context, loginRoute);
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              return ListView(
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return SizedBox(
                      height: 350,
                      child: buildCard(
                        data['title'],
                        data['img'],
                        data['price'],
                        data['Discount'],
                        data['Tax'],
                        data['hot_offer'],
                        document.id,
                        data['afterdiscount'],
                        data['after'],
                        data['total'],
                        data['phone'],
                        data['name'],
                        data['count'],
                      ));
                }).toList(),
              );
            },
          ),
        ));
  }

  Card buildCard(title, img, price, discount, tax, hotOffer, id, afterdiscount,
      name, phone, after, total, count) {
    var item = {
      "id": id,
      "img": img,
      "tax": tax,
      "title": title,
      "total": total,
      "price": price,
      "discount": discount,
      "afterdiscount": afterdiscount,
      "count": count,
    };

    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(
                "$title ",
                style: const TextStyle(fontSize: 25),
              ),
              subtitle: Text(
                '\$$price',
                style: const TextStyle(fontSize: 20),
              ),
              // ignore: prefer_const_constructors
              // trailing: Icon(
              //   Icons.add,
              //   color: Colors.amber,
              //   size: 28,
              // ),
              // onTap: () {
              //   // Navigator.pushNamed(context, detailsRoute);
              // },
            ),
            SizedBox(
              height: 120.0,
              width: 250.0,
              child: Image.network(img),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              alignment: Alignment.bottomLeft,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Discount :$discount%',
                      style: const TextStyle(fontSize: 15, color: Colors.red),
                    ),
                    subtitle: Text(
                      ' Tax :$tax%', //afterdiscount
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              iconSize: 35,
              color: Colors.green,
              onPressed: () => onPressAddToNewCart(item),
            )
          ],
        ));
  }

  void onPressAddtoOrderHistory(Item) {
    HistoryItems.add(Item);
    // ignore: avoid_print
    print(HistoryItems);
  }

  void onPressAddToNewCart(item) {
    cartItems.add(item);
    // ignore: avoid_print
    print(cartItems);
  }

  void onPressNewAccount() {
    Navigator.pushNamed(context, singupRoute);
  }

  void onPressLogOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, appRootRoute);
    } catch (e) {
      // ignore: avoid_print
      print('T');
    }
  }
}
