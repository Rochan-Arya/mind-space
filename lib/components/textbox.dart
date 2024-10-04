import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final controller;
  final hintText;
  final bool obscureText;
  const MyTextBox(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.grey.shade900,
                width: 3,
              )),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: const Color.fromARGB(255, 255, 169, 169)),
              borderRadius: BorderRadius.circular(15)),
          fillColor: Colors.grey.shade400,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
