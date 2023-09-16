import 'package:bookshare/theme/colors.dart';
import 'package:bookshare/widget/essentials/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_style.dart';



class LendAddBookScreen extends StatefulWidget {
  const LendAddBookScreen({super.key});

  @override
  LendAddBookScreenState createState() => LendAddBookScreenState();
}

class LendAddBookScreenState extends State<LendAddBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 20, left: 15, right: 15),
                child: Container(
                  decoration: generalBoxDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 25.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.0),
                            child: Image.network(
                              'https://images1.penguinrandomhouse.com/cover/9780593500507',
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
                                "Follow me to ground",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: heading1Bold,
                              ),
                              Text(
                                "by sure Rainford",
                                style: heading1,
                              ),

                              SizedBox(
                                height: 3.h,
                              ),

                              Button(width: 100, text: "Add Book", backgroundColor: lentThemePrimary, onClick: ()=>{

                              })
                              // SizedBox(
                              //   width: 100.w,
                              //   child: FilledButton(
                              //     style: ButtonStyle(
                              //       backgroundColor: MaterialStateProperty.all<Color>(yellowPrimary), // Set the background color here
                              //     ),
                              //     onPressed: () {
                              //       GoRouter.of(context).push("/book-details");
                              //     },
                              //     child: const Text(
                              //       "Return with 200 penalty",
                              //       style: buttonText,
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
