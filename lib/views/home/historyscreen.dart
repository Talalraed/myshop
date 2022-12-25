import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_my/router/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Historyscreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  const Historyscreen({
    super.key,
    this.cartItems,
    this.total,
    // ignore: non_constant_identifier_names
    this.total_discount,
    // ignore: non_constant_identifier_names
    this.total_net,
    // ignore: non_constant_identifier_names
    this.total_tax,
  });
  final List<dynamic>? cartItems;
  final String? total;
  // ignore: non_constant_identifier_names
  final String? total_discount;
  // ignore: non_constant_identifier_names
  final String? total_tax;
  // ignore: non_constant_identifier_names
  final String? total_net;

  // ignore: non_constant_identifier_names
  @override
  State<Historyscreen> createState() => _HistoryscreenState();
}

final moonLanding = DateTime.parse('1969-07-20 20:18:04Z'); // 8:18pm
dynamic cartItems = [];

final now = DateTime.now();
final _firstore = FirebaseFirestore.instance;

class _HistoryscreenState extends State<Historyscreen> {
  String? gets;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text("History Ordar"),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                        stream: _firstore.collection("history").snapshots(),
                        builder: (context, snapshot) {
                          List<Text> cartItem = [];
                          if (snapshot.data != null) {
                            return Container(
                              color: Colors.white,
                              child: SizedBox(
                                height: 250,
                                child: Column(
                                    children: snapshot.data!.docs
                                        .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data() as Map<String, dynamic>;
                                  List<dynamic> cartApiItme =
                                      data["cartitem"] as List<dynamic>;
                                  print(
                                      "object------------------------${data}");
                                  if (cartApiItme != null)
                                    print(
                                        "cartApiItme------------------------${cartApiItme[0]}");
                                  return SizedBox(
                                    height: 500,
                                    child: Column(
                                      children: [
                                        Text("total: ${data['total']}"),
                                        Text(
                                            "total_discount: ${data['total_discount']}"),
                                        Text("total_net:${data['total_net']}"),
                                        if (cartApiItme != null)
                                          Column(
                                            children: [
                                              for (var data in cartApiItme)
                                                buildCard(
                                                  data["title"],
                                                  data["img"],
                                                  data["price"],
                                                  data["discount"],
                                                  data["tax"],
                                                  data["id"],
                                                ),
                                            ],
                                          )
                                      ],
                                    ),
                                  );
                                }).toList()),
                              ),
                            );
                          }
                          return Text("No data");
                          // return Column(children: cartItem);
                        }),
                  ],
                ),
              ),
            ),
            // Text(
            //   "Total : ${widget.total}",
            //   textAlign: TextAlign.start,
            //   // ignore: avoid_print
            // ),
            // Text("Total Discount : ${widget.total_discount}"),
            // Text("Total Tax : ${widget.total_tax}"),
            // Text("Total Net : ${widget.total_net}"),
            Container(
                alignment: Alignment.center,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, homeRoute);
                          getdataStreem();
                          // Navigator.pushNamed(context, historyRoute);
                        },
                        icon: const Icon(
                          // <-- Icon
                          Icons.done,
                          size: 24.0,
                        ),
                        label: const Text('Finish'), // <-- Text
                      ),
                    ])),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  List<Widget> Test(data) {
    List<Widget> list = [const SizedBox()];
    var cartItems = widget.cartItems;
    for (var data in cartItems!) {
      list.add(SizedBox(
          height: 196,
          child: buildCard(
            data['title'],
            data['img'],
            data['price'],
            data['tax'],
            data['discount'],
            data['id'],
          )));
    }
    return list;
  }

  Widget buildCard(
    title,
    img,
    price,
    discount,
    tax,
    id,
  ) {
    // ignore: unused_local_variable
    var item = {
      "title": title,
      "img": img,
      "price": price,
      "discount": discount,
      "tax": tax,
      "id": id,
    };

    return Card(
      elevation: 1.0,
      child: Column(children: [
        ListTile(
            title: Text(
              "$title ",
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              '\$$price',
              style: const TextStyle(fontSize: 15),
            ),
            trailing: const Text(
              '1',
              textAlign: TextAlign.center,
              // ignore: unnecessary_const
              style: const TextStyle(fontSize: 15, color: Colors.redAccent),
            )),
        if (img != null)
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 50.0,
                width: 110.0,
                child: Image.network(img),
              ),
            ),
          ),
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(5.0),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    textAlign: TextAlign.start,
                    'Discount :$discount%',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

// Future<void> getdata() async {
//   final databacks = await _firstore.collection('history').get();
//   for (var databack in databacks.docs) {
//     print(databack.data());
//   }
// }
void getdataStreem() async {
  await for (var snapshot in _firstore.collection('history').snapshots()) {
    // ignore: unused_local_variable
    print('..........................................................');
    for (var back in snapshot.docs) {}
  }
}

// void onPressAddToNewCart(item) {
//   cartItems.add(item);
//   // ignore: avoid_print
//   print(cartItems);
// }
