import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/app_style.dart';
import '../../../theme/colors.dart';
import '../../../widget/essentials/button.dart';

class ReturnSuccessScreen extends StatefulWidget {
  final String text;

  const ReturnSuccessScreen({super.key, required this.text});

  @override
  ReturnSuccessScreenState createState() => ReturnSuccessScreenState();
}

class ReturnSuccessScreenState extends State<ReturnSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100.w,
              child: Lottie.asset('assets/lottie/success.json', repeat: false),
            ),
            Text(
              "Success",
              style: header20.copyWith(color: Colors.green, fontWeight: FontWeight.w900),
            ),
            Text(
              widget.text,
              style: const TextStyle(color: const Color(0xff000000), fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: 14),
            ),
            SizedBox(
              height: 10.h,
            ),
            Button(
              width: 70,
              text: "Done",
              onClick: () => {context.go('/home')},
              backgroundColor: lentThemePrimary,
            )
          ],
        ),
      ),
    );
  }
}
