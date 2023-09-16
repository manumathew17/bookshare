
import 'package:bookshare/ui/screen/my-book/read_screen.dart';
import 'package:bookshare/ui/screen/my-book/reading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_style.dart';
import '../../../theme/colors.dart';



class MyReadingScreen extends StatefulWidget {
  const MyReadingScreen({super.key});

  @override
  MyReadingScreenState createState() => MyReadingScreenState();
}

class MyReadingScreenState extends State<MyReadingScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: yellowPrimary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('My books', style: header.copyWith(color: blackPrimary)),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "Reading",
            ),
            Tab(
              text: "Read",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          ReadScreen(),
          ReadingScreen(),
        ],
      ),
    );
  }
}
