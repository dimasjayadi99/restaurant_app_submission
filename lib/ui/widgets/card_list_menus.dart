import 'package:flutter/material.dart';

class CardListMenus extends StatelessWidget {
  final String name;
  final ValueChanged<bool?> onChanged;
  final bool value;

  const CardListMenus(
      {super.key,
      required this.name,
      required this.onChanged,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: CheckboxListTile(
            value: value, onChanged: onChanged, title: Text(name)));
  }
}
