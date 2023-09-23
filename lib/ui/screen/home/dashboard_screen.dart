import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';
import '../../../widget/components/shimmer_container.dart';
import 'home_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  DateTime now = DateTime.now();


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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
                  Text(DateFormat('dd').format(now),
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
                      Text( DateFormat('EEEE').format(now),
                          style: const TextStyle(
                              color: const Color(0xff909193), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 14.0),
                          textAlign: TextAlign.center),
                      Text("${DateFormat('MMM').format(now)} ${DateFormat('y').format(now)}",
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
                            'https://images1..com/cover/9780593500507',
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                  child: ShimmerContainer(width: 30, height: 35,),
                                );
                              }
                            },
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
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
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
              width: 100.w,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Rented from Mr. Ramakrishna Ramanujam",
                        style: TextStyle(color: const Color(0xffffffff), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 10.0),
                        textAlign: TextAlign.center),
                    Text("Return by 25th July 2023",
                        style: TextStyle(color: const Color(0xffffffff), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 12.0),
                        textAlign: TextAlign.center),
                    LinearProgressIndicator(
                      value: 0.5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 2.h,
          left: 5.w,
          child: Container(
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
        )
      ]),
    );
  }

  List<Widget> _buildGridItems() {
    return gridItems.map((item) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24, // Adjust the width as needed
              height: 24, // Adjust the height as needed
              child: Image.asset('assets/icons/${item.icon}.png'), // Replace with the actual asset path
            ),
            SizedBox(height: 2.h), // Add spacing between icon and text
            Text(item.text,
                style: const TextStyle(color: const Color(0xff131313), fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: 12.0),
                textAlign: TextAlign.center)
          ],
        ),
      );
    }).toList();
  }
}
