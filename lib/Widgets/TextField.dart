import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  @override
  CustomTextField({required this.hintText, required this.controller});
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 16,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide())),
      ),
    );
  }
}
