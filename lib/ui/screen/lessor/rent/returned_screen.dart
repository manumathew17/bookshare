import 'dart:convert';

import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:bookshare/ui/screen/lessor/rent/bottom-sheet/book_rent_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_style.dart';
import '../../../../widget/components/not_found.dart';
import '../../../../widget/components/shimmer_general.dart';
import 'bottom-sheet/waive_off_bottom_sheet.dart';

class ReturnedScreen extends StatefulWidget {
  const ReturnedScreen({super.key});

  @override
  ReturnedScreenState createState() => ReturnedScreenState();
}

class ReturnedScreenState extends State<ReturnedScreen> {
  List returnedBooks = [];
  bool _notFound = false;
  bool _loading = false;

  RequestRouter requestRouter = RequestRouter();

  @override
  void initState() {
    super.initState();
    loadReturnBooks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadReturnBooks() {
    setState(() {
      _loading = true;
    });
    requestRouter.get(
        'returned-books',
        {"renter": "true"},
        RequestCallbacks(onSuccess: (response) {
          Map<dynamic, dynamic> jsonMap = json.decode(response);
          List returnedBooksTemp = [];
          jsonMap['books'].forEach((item) {
            item['images'] = json.decode(item['images'] ?? '{"smallThumbnail": ""}');
            returnedBooksTemp.add(item);
          });
          setState(() {
            returnedBooks = returnedBooksTemp;
            _notFound = returnedBooks.isEmpty;
            _loading = false;
          });
        }, onError: (error) {
          setState(() {
            _loading = false;
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _loading
            ? const Expanded(child: GeneralShimmer())
            : _notFound
                ? Center(child: SizedBox(height: 30.h, child: const NotFound(text: "No Data found")))
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: returnedBooks.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 20, left: 15, right: 15),
                            child: GestureDetector(
                              onTap: () => {
                                // showModalBottomSheet(
                                //   context: context,
                                //   isScrollControlled: true,
                                //   useSafeArea: true,
                                //   builder: (BuildContext context) {
                                //     return Padding(
                                //       padding: MediaQuery.of(context).viewInsets,
                                //       child:
                                //           const BookHistory(), //for entering amount and wave off    //  return AcceptReturn(); // fo no penalty and accept return
                                //     );
                                //   },
                                // )
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
                                            returnedBooks[index]['images']['smallThumbnail'].toString(),
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
                                              returnedBooks[index]['title'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: heading1Bold,
                                            ),
                                            Text(
                                              returnedBooks[index]['author'],
                                              style: heading1,
                                            ),
                                            Text("Rented from Mr. ${returnedBooks[index]['name']}",
                                                style: const TextStyle(
                                                    color: const Color(0xff000000),
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 10.0),
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
                        }))
      ],
    ));
  }
}
