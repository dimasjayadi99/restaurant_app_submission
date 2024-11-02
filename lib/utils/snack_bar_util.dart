import 'package:flutter/material.dart';

class SnackBarUtil {
  showSnackBar(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message),
          backgroundColor: isSuccess ? Colors.green : Colors.red),
    );
  }
}
