import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Tag extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const Tag({
    super.key,
    required this.text,
    this.bgColor = const Color(0xff4dcc21),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: bgColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 8.0,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
