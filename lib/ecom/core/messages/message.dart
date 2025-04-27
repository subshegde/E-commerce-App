import 'package:flutter/material.dart';

class CustomSnackBar {
  static SnackBar get({
    required String message,
    Color iconColor = Colors.white,
    Color backgroundColor = Colors.black,
  }) {
    return SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: iconColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }
}
