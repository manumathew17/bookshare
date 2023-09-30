import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../../theme/app_style.dart';
import '../../../../../theme/colors.dart';
import '../../../../../widget/essentials/button.dart';

class AcceptReturn extends StatefulWidget {
  const AcceptReturn({super.key});

  @override
  _AcceptReturnState createState() => _AcceptReturnState();
}

class _AcceptReturnState extends State<AcceptReturn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  late DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Ink(
                decoration: const ShapeDecoration(
                  color: Colors.grey,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.cancel),
                  color: textGrey,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          const Text("Are you sure you want to accept the return of this book ?", style: header12, textAlign: TextAlign.center),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 70,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          "https://images1.penguinrandomhouse.com/cover/9780593500507",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Follow me to ground",
                          style: heading1Bold,
                        ),
                        Text(
                          "By Sure Rainford",
                          style: heading1Bold,
                        ),

                        SizedBox(
                          height: 1.h,
                        ),

                        Text(
                          "Rented to Mr. Akshay",
                          style: heading1Bold,
                        ),

                        // SizedBox(
                        //   width: 100.w,
                        //
                        //   child: FilledButton(
                        //     style: ButtonStyle(
                        //       backgroundColor: MaterialStateProperty.all<Color>(yellowPrimary), // Set the background color here
                        //     ),
                        //     onPressed: () {
                        //       GoRouter.of(context).push("/book-details");
                        //     },
                        //     child: const Text(
                        //       "Rent",
                        //       style: buttonText,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.w,
                ),
                Button(
                    width: 100,
                    text: "Accept Return",
                    backgroundColor: lentThemePrimary,
                    onClick: () {
                      // on success routing to home
                      context.go("/home");
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
