import 'package:flutter/material.dart';

class CardListMenus extends StatelessWidget {
  final String name;
  final int index;

  const CardListMenus({super.key, required this.name, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(name),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          leading: Text("${index + 1}"),
        ));
  }
}
