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

class _HomeScreenState extends State<HomeScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('itmes').snapshots();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          leading: IconButton(
            onPressed: (() {
              Navigator.pushNamed(context, detailsRoute);
            }),
            icon: const Icon(Icons.arrow_back),
          ),
          // ignore: prefer_const_literals_to_create_immutables
          actions: <Widget>[
            // ignore: prefer_const_constructors
            IconButton(
              icon: const Icon(
                Icons.shopping_bag_outlined,
                color: Color.fromARGB(255, 220, 13, 13),
              ),
              onPressed: () {
                Navigator.pushNamed(context, detailsRoute);
              },
            ),
          ],
          title: const Text("ordar"),
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
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return SizedBox(
                      height: 300,
                      child: buildCard(
                          data['title'],
                          data['img'],
                          data['price'],
                          data['Discount'],
                          data['Tax'],
                          data['hot_offer'],
                          data['afterdiscount'],
                          data['after'],
                          data['total'],
                          data['count']));
                }).toList(),
              );
            },
          ),
        ));
  }

  Card buildCard(title, img, price, Discount, Tax, hotOffer, afterdiscount,
      after, total, count) {
    int heading = price;
    // ignore: unused_local_variable
    bool subheading = hotOffer;
    // ignore: unused_local_variable
    var tax = Tax;
    var image = Image.network(img);
    // ignore: unused_local_variable
    var discount = Discount;
    var offer = title;
    // ignore: unused_local_variable
    var Afterdiscount = afterdiscount;
    // ignore: unused_local_variable
    var After = after;
    // ignore: unused_local_variable
    var Total = total;
    // ignore: unused_local_variable
    var Count = count;
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(
                offer,
                style: const TextStyle(fontSize: 25),
              ),
              subtitle: Text(
                '\$$heading',
                style: const TextStyle(fontSize: 20),
              ),
              trailing: const Icon(Icons.shopping_cart, color: Colors.amber),
            ),
            SizedBox(
              height: 120.0,
              width: 250.0,
              child: image,
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              alignment: Alignment.bottomLeft,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Discount :$Discount',
                      style: const TextStyle(fontSize: 15, color: Colors.red),
                    ),
                    subtitle: Text(
                      ' Tax :$after',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            )
            // ButtonBar(
            //   buttonPadding: EdgeInsets.all(10),

            //   children: [
            //     TextButton(
            //       child: Text(
            //         '$price',
            //         style: TextStyle(
            //             color: Colors.white, backgroundColor: Colors.red),
            //       ),
            //       onPressed: () {/* ... */},
            //     ),
            //   ],
            // )
          ],
        ));
  }

  void onPressNewAccount() {
    Navigator.pushNamed(context, singupRoute);
  }

  void onPressLogOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, appRootRoute);
      // ignore: empty_catches
    } catch (e) {}
  }
}
