import 'dart:convert';

import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:bookshare/ui/screen/renter/arrival/new_arrival_screen.dart';
import 'package:bookshare/utils/Logger.dart';
import 'package:bookshare/widget/components/shimmer_general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
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
  RequestRouter requestRouter = RequestRouter();
  bool _isLoading = false;
  List<GridItem> gridItems = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() {
    setState(() {
      _isLoading = true;
    });
    requestRouter.get(
        'categories',
        {"per_page": '100'},
        RequestCallbacks(
            onSuccess: (response) {
              setState(() {
                _isLoading = false;
              });
              Map<String, dynamic> jsonMap = json.decode(response);
              jsonMap['categories'].forEach((item) {
                gridItems.add(GridItem(item['name'], item['icon'] ?? ""));
              });
              setState(() {
                gridItems = gridItems;
              });
            },
            onError: (error) {
              setState(() {
                _isLoading = false;
              });
            }));
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
            color: yellowPrimary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Categories', style: header.copyWith(color: blackPrimary)),
      ),
      body:
      _isLoading ? const GeneralShimmer() :
      GridView.count(
        crossAxisCount: 4, // to disable GridView's scrolling
        shrinkWrap: true, // You won't see infinite size error
        children: _buildGridItems(),
      ),
    );
  }

  List<Widget> _buildGridItems() {
    return gridItems.map((item) {
      return InkWell(
          onTap: () =>
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewArrivalScreen(category:  item.text,)),
                ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 34, // Adjust the width as needed
                  height: 34, // Adjust the height as needed
                  child: Image.network(
                    requestRouter.url(item.icon),
                    fit: BoxFit.cover,
                  ), // Replace with the actual asset path
                ),
                SizedBox(height: 2.h), // Add spacing between icon and text
                Text(item.text,
                    style: const TextStyle(
                        color: const Color(0xff909193),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 10.0),
                    textAlign: TextAlign.center)
              ],
            ),
          ));
    }).toList();
  }
}
