import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../theme/app_style.dart';
import '../../../../../theme/colors.dart';

class BookHistory extends StatefulWidget {
  const BookHistory({super.key});

  @override
  BookHistoryState createState() => BookHistoryState();
}

class BookHistoryState extends State<BookHistory> {
  @override
  void initState() {
    super.initState();
  }

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
          const Text("History", style: header12, textAlign: TextAlign.center),
          const SizedBox(height: 20.0),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Mr. RamanujaCharya",
                        style: heading1Bold,
                      ),
                      Text(
                        "10 / day | 5 days",
                        style: heading1Bold,
                      ),

                      SizedBox(
                        height: 1.h,
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
                );
              }),
        ],
      ),
    );
  }
}
