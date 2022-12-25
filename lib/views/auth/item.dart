import 'package:flutter/material.dart';

class Iteme extends StatefulWidget {
  const Iteme({super.key});

  @override
  State<Iteme> createState() => _ItemeState();
}

class Item {
  String title;
  double price;
  Item(this.price, this.title);
}

class _ItemeState extends State<Iteme> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
