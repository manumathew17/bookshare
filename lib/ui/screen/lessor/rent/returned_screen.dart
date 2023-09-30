import 'package:bookshare/ui/screen/lessor/rent/bottom-sheet/book_rent_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_style.dart';
import 'bottom-sheet/waive_off_bottom_sheet.dart';

class ReturnedScreen extends StatefulWidget {
  const ReturnedScreen({super.key});

  @override
  ReturnedScreenState createState() => ReturnedScreenState();
}

class ReturnedScreenState extends State<ReturnedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 20, left: 15, right: 15),
                child: GestureDetector(
                  onTap: () => {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child:
                              const BookHistory(), //for entering amount and wave off    //  return AcceptReturn(); // fo no penalty and accept return
                        );
                      },
                    )
                  },
                  child: Container(
                    decoration: generalBoxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14.0),
                              child: Image.network(
                                'https://images1.penguinrandomhouse.com/cover/9780593500507',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
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
                                Text("Rented to Mr. Ramakrishna Ramanujam",
                                    style: const TextStyle(
                                        color: const Color(0xff000000), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 10.0),
                                    textAlign: TextAlign.left),
                                SizedBox(
                                  height: 10,
                                ),
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
                ),
              );
            }));
  }
}
