// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import './item.dart';

// ignore: camel_case_types
class card {
  final List<Item> _items = [];
  double _total = 0.0;

  card(child);

  void add(Item item) {
    _items.add(item);
    _total += item.price;
  }

  void remove(Item item) {
    _total -= item.price;
    _items.remove(item);
  }

  int get count {
    return _items.length;
  }

  double get total {
    return _total;
  }

  List<Item> get bascktesItems {
    return _items;
  }
}

class Card extends StatelessWidget {
  const Card({super.key});

  get customText => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: ((context, index) {
        return Container();
      })),
    );
  }
}
