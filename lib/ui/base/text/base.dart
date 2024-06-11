import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final TextDecoration? decoration;

  const BaseText(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
        this.decoration
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        decoration: decoration
      ),
    );
  }
}
