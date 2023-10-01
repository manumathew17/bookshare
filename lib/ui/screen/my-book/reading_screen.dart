import 'dart:convert';

import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/app_style.dart';
import '../../../widget/components/not_found.dart';
import '../../../widget/components/shimmer_general.dart';


class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  ReadingScreenState createState() => ReadingScreenState();

}

class ReadingScreenState extends State<ReadingScreen> {
  List booksOnRent = [];
  bool _notFound = false;
  bool _loading = false;
  RequestRouter requestRouter = RequestRouter();

  @override
  void initState() {
    super.initState();
    loadBookOnRent();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadBookOnRent() {
    setState(() {
      _loading = true;
    });
    requestRouter.get(
        'returned-books',
        {"renter": "true"},
        RequestCallbacks(
            onSuccess: (response) {
              Map<dynamic, dynamic> jsonMap = json.decode(response);
              List booksOnRentTemp = [];
              jsonMap['books'].forEach((item) {
                item['images'] = json.decode(item['images']?? '{"smallThumbnail": ""}');
                booksOnRentTemp.add(item);
              });
              setState(() {
                _loading = false;
                booksOnRent = booksOnRentTemp;
                _notFound = booksOnRent.isEmpty;
              });
            },
            onError: (error) {
              setState(() {
                _loading = false;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if (_loading)
        const Expanded(child: GeneralShimmer())
    else
    _notFound
    ? Center(child: SizedBox(height: 30.h, child: const NotFound(text: "No data found")))
        : Expanded(
      child:        ListView.builder(
          shrinkWrap: true,
          itemCount: booksOnRent.length,
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
                            booksOnRent[index]['images']['smallThumbnail'].toString(),
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
                              booksOnRent[index]['title'].toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: heading1Bold,
                            ),
                            Text(
                              "by ${booksOnRent[index]['author']}",
                              style: heading1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 1,
                                  width: 100.w,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffdadada),
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  )),
                            ),
                            Text("Rented from Mr. ${booksOnRent[index]['name']}",
                                style: const TextStyle(
                                    color: const Color(0xff000000), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 10.0),
                                textAlign: TextAlign.left),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text("Returned on 25Th sep",
                                style: TextStyle(
                                    color: Color(0xff5f5f5f), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 10.0),
                                textAlign: TextAlign.center),
                            SizedBox(
                              height: 1.h,
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
            );
          })
    )
          ],
        )


 );
  }
}