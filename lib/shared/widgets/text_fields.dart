import 'package:flutter/material.dart';

// form
Widget buildFormTextField(
    TextEditingController controller, String label, IconData icon) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.grey))),
    validator: (value) {
      if (value == "" || value == null) {
        return "$label wajib diisi";
      }
      return null;
    },
  );
}
