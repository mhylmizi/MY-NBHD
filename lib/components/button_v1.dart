import 'package:flutter/material.dart';

class ButtonV1 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonV1({super.key, required this.text, required this.onPressed, required int width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(text),
    );
  }
}
