import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_style.dart';
import '../../../../theme/colors.dart';
import '../../../../widget/essentials/button.dart';
import '../../../../widget/tag/general_tag.dart';
import '../../success/success-screen.dart';

class BookLenders extends StatefulWidget {
  const BookLenders({super.key});

  @override
  BookLendersState createState() => BookLendersState();
}

class BookLendersState extends State<BookLenders> {
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
          const Text("Available Lessors of this book", style: header12, textAlign: TextAlign.center),
          const SizedBox(height: 20.0),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 25.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Mr. Ramakrishna Ramanujan",
                              style: heading1Bold,
                            ),
                            Text(
                              " 9 / day",
                              style: heading1Bold,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text("4.98 (121 rental on this book", style: infoText, textAlign: TextAlign.center),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),

                            Button(
                                width: 100,
                                text: "Pay 45 to Rent",
                                backgroundColor: yellowPrimary,
                                onClick: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const SuccessScreen()),
                                      )
                                    })
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
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
