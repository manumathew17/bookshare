import 'package:bookshare/widget/essentials/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';

class AddBookHome extends StatefulWidget {
  const AddBookHome({super.key, required this.onClick});

  final VoidCallback onClick;

  @override
  AddBookHomeState createState() => AddBookHomeState();
}

class AddBookHomeState extends State<AddBookHome> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 30.w, child: Lottie.asset('assets/lottie/addbook.json', repeat: true)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // No books have been added by you
              const Text("No books have been added by you",
                  style: TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 12.0),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 1.h,
              ),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(lentThemePrimary), // Set the button background color to blue
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Change the border radius here
                    ),
                  ),
                ),
                onPressed: () {
                  widget.onClick();
                },
                child: Text('Add books to collection'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
