import 'dart:convert';

import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:bookshare/widget/essentials/button.dart';
import 'package:bookshare/widget/tag/general_tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_style.dart';
import '../../../../theme/colors.dart';
import 'book_lenders.dart';
import 'bottom-sheet.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  BookDetailsState createState() => BookDetailsState();
}

class BookDetailsState extends State<BookDetailsScreen> {
  int bookId = 0;
  String endDate = "";
  @override
  Widget build(BuildContext context) {
    dynamic book = GoRouterState.of(context).extra;
    bookId = book['id'];
    Map<String, dynamic> images = json.decode(book['images']);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: yellowPrimary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title:
            Text('Book details', style: header.copyWith(color: blackPrimary)),
      ),
      body: Stack(alignment: Alignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 30.w,
                  height: 40.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      images['smallThumbnail'].toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(book['title'],
                    style: header20, textAlign: TextAlign.center),
                Text(book['author'],
                    style: const TextStyle(
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 16.0),
                    textAlign: TextAlign.center),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: const Color(0xff4dcc21))),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text("In Stock ( ${book['available']} )",
                        style: const TextStyle(
                            color: const Color(0xff909193),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0),
                        textAlign: TextAlign.center),

                    // A haunted, surreal debut novel about an otherworldly young woman, her father, and her lover that cu
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(book['description'],
                      style: const TextStyle(
                          color: const Color(0xff9d9ea8),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Karla",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0),
                      textAlign: TextAlign.center),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          child: Container(
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Tag(text: "68"),
                    SizedBox(
                      width: 1.w,
                    ),
                    const Text("times rented",
                        style: TextStyle(
                            color: Color(0xff909193),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14.6),
                        textAlign: TextAlign.center)
                  ],
                ),
                SizedBox(
                  height: 2.w,
                ),
                Button(
                    width: 90,
                    text: "Rent",
                    backgroundColor: yellowPrimary,
                    onClick: () => {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return MyBottomSheet(
                                onUpdate: (date) {
                                  print(date);
                                  setState(() {
                                    endDate = date;
                                  });
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      useSafeArea: true,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          child: BookLenders(
                                            bookId: bookId,
                                            endDate: endDate,
                                          ),
                                        );
                                      });
                                },
                              );
                            },
                          )
                        })
                // SizedBox(
                //   width: 90.w,
                //   child: FilledButton(
                //     style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all<Color>(yellowPrimary), // Set the background color here
                //     ),
                //     onPressed: () {
                //       _openBottomSheet(context);
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
        )
      ]),
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled:
          true, // Allow the bottom sheet to be taller than the screen
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Select a return date'),
            SizedBox(
              height: 5.h,
            ),
          ],
        );
      },
    );
  }
}
