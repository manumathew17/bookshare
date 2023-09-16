import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar(
      {Key? key,
      required String message,
      required IconData iconData,
      required Color color})
      : super(
          key: key,
          content: CustomSnackBarContent(
              message: message, icon: iconData, color: color),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          margin: const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
          elevation: 8.0,
          duration: const Duration(seconds: 3),
        );
}

class CustomSnackBarContent extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color color;

  const CustomSnackBarContent({
    super.key,
    required this.message,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            message,
            style: TextStyle(
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
