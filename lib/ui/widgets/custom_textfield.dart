import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hinText;
  final IconData icon;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final String? label;
  final TextInputAction inputAction;

  const CustomTextField(
      {super.key,
      required this.controller,
      this.hinText,
      required this.icon,
      this.onFieldSubmitted,
      this.label,
      this.validator,
      required this.inputAction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textInputAction: inputAction,
        controller: controller,
        decoration: InputDecoration(
          label: Text(label ?? ""),
          hintText: hinText,
          hintStyle: const TextStyle(fontWeight: FontWeight.normal),
          border: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          prefixIcon: Icon(icon),
        ),
        validator: validator,
        onFieldSubmitted: onFieldSubmitted);
  }
}
