
import 'package:bookshare/theme/colors.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import 'dashboard_screen.dart';
import '../my-book/my_book.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<GridItem> gridItems = [
    GridItem("Horror", "horror"),
    GridItem("Romance", "romance"),
    GridItem("Sci fi", "sci-fi"),
    GridItem("Mystery", "mystery"),
    GridItem("Children", "children"),
    GridItem("Non fiction", "non-fiction"),
    GridItem("Poetry", "poetry"),
    GridItem("Self - help", "self-help"),
  ];
  static const List<Widget> _homeScreensWidgets = [DashBoardScreen(), MyReadingScreen(), HomeScreen(), HomeScreen(), HomeScreen(), HomeScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("BookShare",
            style: TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 24.0),
            textAlign: TextAlign.center),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => {GoRouter.of(context).push("/profile")},
              child: SizedBox(
                width: 7.w,
                height: 7.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.w / 2),
                  child: Image.network(
                    "https://imgv3.fotor.com/images/gallery/Realistic-Female-Profile-Picture.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: Stack(fit: StackFit.expand, clipBehavior: Clip.antiAliasWithSaveLayer, children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ListView(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("25",
                      style:
                          const TextStyle(color: const Color(0xff000000), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 36.0),
                      textAlign: TextAlign.center),
                  SizedBox(
                    width: 2.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Tuesday",
                          style: const TextStyle(
                              color: const Color(0xff909193), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14.0),
                          textAlign: TextAlign.center),
                      Text("July 2023",
                          style: const TextStyle(
                              color: const Color(0xff909193), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14.0),
                          textAlign: TextAlign.center)
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("New Arrivals",
                      style:
                          const TextStyle(color: const Color(0xff000000), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 16.0),
                      textAlign: TextAlign.center),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push("/new-arrival");
                    },
                    child: Text("View More >",
                        style:
                            const TextStyle(color: const Color(0xfff5c02d), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 10.0),
                        textAlign: TextAlign.center),
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 40.w, // Adjust the height as needed
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        width: 30.w,
                        height: 35.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://images1.penguinrandomhouse.com/cover/9780593500507',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        width: 30.w,
                        height: 35.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            'https://images1.penguinrandomhouse.com/cover/9780593500507',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        width: 30.w,
                        height: 35.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            'https://images1.penguinrandomhouse.com/cover/9780593500507',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        width: 30.w,
                        height: 35.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            'https://images1.penguinrandomhouse.com/cover/9780593500507',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // ... Add more items as needed
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Categories",
                      style:
                          const TextStyle(color: const Color(0xff000000), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 16.0),
                      textAlign: TextAlign.center),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push("/category");
                    },
                    child: Text("View More >",
                        style:
                            const TextStyle(color: const Color(0xfff5c02d), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 10.0),
                        textAlign: TextAlign.center),
                  )
                ],
              ),
              GridView.count(
                crossAxisCount: 4,
                physics: const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                shrinkWrap: true, // You won't see infinite size error
                children: _buildGridItems(),
              )
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
                        color: yellowPrimary,
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

        // Positioned(
        //   bottom: 0,
        //   left: 0,
        //   right: 0,
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: yellowPrimary,
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(20.0),
        //           topRight: Radius.circular(20.0),
        //         ),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.grey.withOpacity(0.3),
        //             spreadRadius: 2,
        //             blurRadius: 4,
        //             offset: Offset(0, -2), // Adjust the offset as needed
        //           ),
        //         ],
        //       ),
        //       width: 100.w,
        //       child: Padding(
        //         padding: const EdgeInsets.all(20),
        //         child: Positioned(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text("Rented from Mr. Ramakrishna Ramanujam",
        //                   style: TextStyle(color: const Color(0xffffffff), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 10.0),
        //                   textAlign: TextAlign.center),
        //               Text("Return by 25th July 2023",
        //                   style: TextStyle(color: const Color(0xffffffff), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 12.0),
        //                   textAlign: TextAlign.center),
        //               LinearProgressIndicator(
        //                 value: 0.5,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // Positioned(
        //   bottom: 2.h,
        //   left: 5.w,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Container(
        //         width: 15.w,
        //         height: 20.w,
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.circular(8.0),
        //           child: Image.network(
        //             'https://images1.penguinrandomhouse.com/cover/9780593500507',
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //       ),
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text("Rented from Mr. Ramakrishna Ramanujam",
        //               style: TextStyle(color: const Color(0xffffffff), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 10.0),
        //               textAlign: TextAlign.center),
        //           Text("Return by 25th July 2023",
        //               style: TextStyle(color: const Color(0xffffffff), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 12.0),
        //               textAlign: TextAlign.center),
        //           LinearProgressIndicator(
        //             value: 0.5,
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // )
      ]),
      bottomNavigationBar: FlashyTabBar(
        animationCurve: Curves.bounceIn,
        selectedIndex: _selectedIndex,
        iconSize: 30,
        showElevation: false,
        // use this to remove appBar's elevation

        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home_filled),
            title: const Text(
              'Home',
              style: TextStyle(color: primary),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.search),
            title: const Text(
              'Search',
              style: TextStyle(color: primary),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.add_shopping_cart_outlined),
            title: const Text(
              'Reading',
              style: TextStyle(color: primary),
            ),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.people),
            title: const Text(
              'Catalog',
              style: TextStyle(color: primary),
            ),
          ),
          // FlashyTabBarItem(
          //   icon: Icon(Icons.chat_rounded),
          //   title: Text('Chat'),
          // ),
          FlashyTabBarItem(
            icon: const Icon(
              Icons.monetization_on,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(color: primaryDark),
            ),
          ),
        ],
        onItemSelected: (index) {
          switch (index) {
            case 2:
              GoRouter.of(context).push("/my-read");
              break;
            case 3:
              GoRouter.of(context).push("/lend-home");
              break;
          }
        },
      ),
    );
  }

  List<Widget> _buildGridItems() {
    return gridItems.map((item) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34, // Adjust the width as needed
              height: 34, // Adjust the height as needed
              child: Image.asset('assets/icons/${item.icon}.png'), // Replace with the actual asset path
            ),
            SizedBox(height: 2.h), // Add spacing between icon and text
            Text(item.text,
                style: const TextStyle(color: const Color(0xff909193), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 10.0),
                textAlign: TextAlign.center)
          ],
        ),
      );
    }).toList();
  }
}

class GridItem {
  final String text;
  final String icon;

  GridItem(this.text, this.icon);
}
