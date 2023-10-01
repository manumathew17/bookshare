import 'package:bookshare/theme/colors.dart';
import 'package:bookshare/widget/essentials/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/app_style.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  SuccessScreenState createState() => SuccessScreenState();
}

class SuccessScreenState extends State<SuccessScreen> {
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
              "Payment successful",
              style: header20.copyWith(color: Colors.green, fontWeight: FontWeight.w900),
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      style: const TextStyle(color: const Color(0xff000000), fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: 14),
                      text: "We have received your payment of "),
                  TextSpan(
                      style: const TextStyle(color: const Color(0xff000000), fontWeight: FontWeight.w800, fontStyle: FontStyle.normal, fontSize: 14),
                      text: "₹ 45. \n"),
                  TextSpan(
                      style: const TextStyle(color: const Color(0xff000000), fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: 14),
                      text: "Please visit \nFlat 303, Tower B, Diamond District, Domlur, Bangalore, Karnataka")
                ])),
            SizedBox(
              height: 10.h,
            ),
            Button(
              width: 70,
              text: "Continue",
              onClick: () => {context.go("/home")},
              backgroundColor: yellowPrimary,
            )
          ],
        ),
      ),
    );
  }
}
