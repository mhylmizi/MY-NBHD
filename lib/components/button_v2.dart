import 'package:flutter/material.dart';

class ButtonV2 extends StatelessWidget {
  final String buttonText;
  final Function()? onTap;
  final TextStyle? textStyle;

  const ButtonV2(
      {super.key,
      required this.onTap,
      required this.buttonText,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: textStyle ?? const TextStyle(),
          ),
        ),
      ),
    );
  }
}
