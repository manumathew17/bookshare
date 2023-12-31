import 'dart:convert';

import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:bookshare/provider/auth/auth_provider.dart';
import 'package:bookshare/ui/screen/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_style.dart';
import '../../../../theme/colors.dart';
import '../../../../widget/components/home_addBook.dart';
import '../../../../widget/components/shimmer_container.dart';
import 'package:bookshare/helpers/helper.dart';

class LendBookHomeScreen extends StatefulWidget {
  const LendBookHomeScreen({super.key});

  @override
  LendBookHomeScreenState createState() => LendBookHomeScreenState();
}

class LendBookHomeScreenState extends State<LendBookHomeScreen> {
  List newArrBook = [];
  List booksOnRent = [];
  RequestRouter requestRouter = RequestRouter();
  late AuthProvider authProvider;
  List<GridItem> gridItems = [];
  dynamic dash = {
    "total_count": '0',
    "total_incone": '0',
    "book_overdue": '0',
    "total_overdue_collect": '0'
  };
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    loadNewArrivals();
    loadBookOnRent();
    loadDash();
  }

  void loadDash() {
    requestRouter.get(
        'renter-dash',
        {'page': '1'},
        RequestCallbacks(
            onSuccess: (response) {
              Map<String, dynamic> jsonMap = json.decode(response);
              setState(() {
                dash = jsonMap;
              });
            },
            onError: (error) {}));
  }

  void loadNewArrivals() {
    requestRouter.get(
        'books-for-rent',
        {"per_page": '6', 'mybook': 'true'},
        RequestCallbacks(
            onSuccess: (response) {
              Map<String, dynamic> jsonMap = json.decode(response);
              setState(() {
                newArrBook = jsonMap['books']['data'];
              });
            },
            onError: (error) {}));
  }

  void loadBookOnRent() {
    requestRouter.get(
        'books-on-rent',
        {"renter": 'true'},
        RequestCallbacks(
            onSuccess: (response) {
              Map<dynamic, dynamic> jsonMap = json.decode(response);
              List booksOnRentTemp = [];
              jsonMap['books'].forEach((item) {
                item['images'] =
                    json.decode(item['images'] ?? '{"smallThumbnail": ""}');
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
      appBar: AppBar(
        backgroundColor: white,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: lentThemePrimary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Lend Book', style: header.copyWith(color: blackPrimary)),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Books lent till date',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "${dash['total_count']}",
                            style: const TextStyle(
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 23.5,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lifetime Earnings',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "${dash['total_incone']}",
                            style: const TextStyle(
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 23.5,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Books Overdue',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "${dash['book_overdue']}",
                            style: const TextStyle(
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 23.5,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Overdue fees to collect',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "${dash['total_overdue_collect']}",
                            style: const TextStyle(
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              fontSize: 23.5,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("My Books",
                      style:
                          const TextStyle(color: const Color(0xff000000), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 16.0),
                      textAlign: TextAlign.center),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push("/lend-book").then((value) => loadData());
                    },
                    child: Text("View More >",
                        style: const TextStyle(color: lentThemePrimary, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 10.0),
                        textAlign: TextAlign.center),
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              newArrBook.length == 0
                  ? Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(9)), color: const Color(0xffe7e9f1)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: AddBookHome(
                          onClick: () => {GoRouter.of(context).push("/lend-book").then((value) => loadData())},
                        ),
                      ),
                    )
                  : Container(
                      height: 40.w, // Adjust the height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: newArrBook.length, // Number of items in the list
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> images = json.decode(newArrBook[index]['images'] ?? '{}');
                          return Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Container(
                              width: 30.w,
                              height: 35.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  images['smallThumbnail'].toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    // Return a default image widget when the network image fails to load
                                    return Image.asset('assets/icons/book-stack.png', // Replace with the path to your default image asset
                                        fit: BoxFit.contain);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      )),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("On rent",
                      style: TextStyle(
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0),
                      textAlign: TextAlign.center),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push("/rent").then((value) => loadData());
                    },
                    child: const Text("View More >",
                        style: TextStyle(
                            color: lentThemePrimary,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 10.0),
                        textAlign: TextAlign.center),
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                  height: 40.w, // Adjust the height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        booksOnRent.length, // Number of items in the list
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> images =
                          json.decode(newArrBook[index]['images']);
                      return InkWell(
                          onTap: () {
                            GoRouter.of(context).push("/rent");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Container(
                              width: 30.w,
                              height: 35.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  booksOnRent[0]['images']['smallThumbnail'].toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ));
                    },
                  )),
            ],
          ),
        ),
        booksOnRent.isNotEmpty
            ? Positioned(
                bottom: 0,
                left: 0,
                child: InkWell(
                  onTap: () {
                    GoRouter.of(context).push("/rent");
                  },
                  child: Container(
                    width: 100.w,
                    height: 23.w,
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 16.w,
                              decoration: BoxDecoration(
                                color: lentThemePrimary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(
                                        0, -2), // Adjust the offset as needed
                                  ),
                                ],
                              ),
                            )),
                        Positioned(
                            bottom: 2,
                            left: 5.w,
                            child: Row(children: [
                              Container(
                                width: 15.w,
                                height: 20.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    booksOnRent[0]['images']['smallThumbnail']
                                        .toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                        "Rented from Mr. ${booksOnRent[0]['name']}",
                                        style: const TextStyle(
                                            color: Color(0xffffffff),
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 10.0),
                                        textAlign: TextAlign.center),
                                    Text(
                                        "Return by  ${Helper.getReturnDate(booksOnRent[0])}",
                                        style: const TextStyle(
                                            color: Color(0xffffffff),
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12.0),
                                        textAlign: TextAlign.start),
                                    SizedBox(
                                      width: 50.w,
                                      child: LinearProgressIndicator(
                                        value: Helper.getRemaningValue(
                                            booksOnRent[0]),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ]))
                      ],
                    ),
                  ),
                ))
            : SizedBox(
                height: 0,
              ),
      ]),
    );
  }
}
