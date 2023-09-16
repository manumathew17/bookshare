import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_style.dart';
import '../../../../theme/colors.dart';
import '../../home/home_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  CategoryState createState() => CategoryState();
}

class CategoryState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
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
        title: Text('Categories', style: header.copyWith(color: blackPrimary)),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        physics: const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
        shrinkWrap: true, // You won't see infinite size error
        children: _buildGridItems(),
      ),
    );
  }

  List<Widget> _buildGridItems() {
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
    return gridItems.map((item) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24, // Adjust the width as needed
              height: 24, // Adjust the height as needed
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
