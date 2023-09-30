import 'dart:convert';

import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/app_style.dart';



class ReadingScreen extends StatefulWidget{
  const ReadingScreen({super.key});

  @override
  ReadingScreenState  createState() => ReadingScreenState();

}

class ReadingScreenState extends State<ReadingScreen> {
   List booksOnRent = [];
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
    requestRouter.get(
        'books-on-rent',
        {"renter": ''},
        RequestCallbacks(
            onSuccess: (response) {
              print(response);
              Map<dynamic, dynamic> jsonMap = json.decode(response);
              List booksOnRentTemp = [];
              jsonMap['books'].forEach((item) {
                item['images'] = json.decode(item['images']);
                booksOnRentTemp.add(item);
              });
              setState(() {
                booksOnRent = booksOnRentTemp;
              });
            },
            onError: (error) {}));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
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
            }));
  }
}