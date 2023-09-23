import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_style.dart';
import '../../../../theme/colors.dart';
import '../../../../widget/components/home_addBook.dart';
import '../../../../widget/components/shimmer_container.dart';

class LendBookHomeScreen extends StatefulWidget {
  const LendBookHomeScreen({super.key});

  @override
  LendBookHomeScreenState createState() => LendBookHomeScreenState();
}

class LendBookHomeScreenState extends State<LendBookHomeScreen> {
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
                            "0",
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
                            "0",
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
                            "0",
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
                            "0",
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
                      GoRouter.of(context).push("/lend-book");
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
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(9)), color: const Color(0xffe7e9f1)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: AddBookHome(
                    onClick: () => {GoRouter.of(context).push("/lend-book")},
                  ),
                ),
              ),

              // Container(
              //   height: 40.w, // Adjust the height as needed
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     shrinkWrap: true,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(right: 15.0),
              //         child: Container(
              //           width: 30.w,
              //           height: 35.w,
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(20),
              //             child: Image.network(
              //               'http://books.google.com/books/content?id=bGZF0ev3DZoC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_ap',
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //       ),
              //
              //       Padding(
              //         padding: const EdgeInsets.only(right: 15.0),
              //         child: Container(
              //           width: 30.w,
              //           height: 35.w,
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(20.0),
              //             child: Image.network(
              //               'http://books.google.com/books/content?id=bGZF0ev3DZoC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_ap',
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //       ),
              //
              //       Padding(
              //         padding: const EdgeInsets.only(right: 15.0),
              //         child: Container(
              //           width: 30.w,
              //           height: 35.w,
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(20.0),
              //             child: Image.network(
              //               'http://books.google.com/books/content?id=lVXnmsCCd3wC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_ap',
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //       ),
              //
              //       Padding(
              //         padding: const EdgeInsets.only(right: 15.0),
              //         child: Container(
              //           width: 30.w,
              //           height: 35.w,
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(20.0),
              //             child: Image.network(
              //               'http://books.google.com/books/content?id=bGZF0ev3DZoC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_ap',
              //               fit: BoxFit.cover,
              //               loadingBuilder: (BuildContext context, Widget child,
              //                   ImageChunkEvent? loadingProgress) {
              //                 if (loadingProgress == null) {
              //                   return child;
              //                 } else {
              //                   return const Center(
              //                     child: ShimmerContainer(width: 30, height: 35,),
              //                   );
              //                 }
              //               },
              //             ),
              //           ),
              //         ),
              //       ),
              //       // ... Add more items as needed
              //     ],
              //   ),
              // ),

              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("On rent",
                      style:
                          const TextStyle(color: const Color(0xff000000), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 16.0),
                      textAlign: TextAlign.center),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push("/rent");
                    },
                    child: Text("View More >",
                        style: const TextStyle(color: lentThemePrimary, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 10.0),
                        textAlign: TextAlign.center),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
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
                            offset: Offset(0, -2), // Adjust the offset as needed
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
                            'https://images1.penguinrandomhouse.com/cover/9780593500507',
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
                            Text("Rented from Mr. Ramakrishna Ramanujam",
                                style: TextStyle(
                                    color: const Color(0xffffffff), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 10.0),
                                textAlign: TextAlign.center),
                            Text("Return by 25th July 2023",
                                style: TextStyle(
                                    color: const Color(0xffffffff), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 12.0),
                                textAlign: TextAlign.start),
                            SizedBox(
                              width: 50.w,
                              child: LinearProgressIndicator(
                                value: 0.5,
                              ),
                            )
                          ],
                        ),
                      ),
                    ]))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
