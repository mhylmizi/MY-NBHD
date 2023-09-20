import 'package:flutter/material.dart';

class TextfieldV1 extends StatelessWidget {
  final controller;
  final String hintText;
  final obscureText;

  const TextfieldV1({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.black),
          ),
          // fillColor: Colors.grey.shade100,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
