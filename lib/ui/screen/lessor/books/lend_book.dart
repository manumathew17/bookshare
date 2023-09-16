
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_style.dart';
import '../../../../theme/colors.dart';
import 'lend_add_book.dart';
import 'lend_my_book_screen.dart';


class LendMyBooks extends StatefulWidget {
  const LendMyBooks({super.key});

  @override
  LendMyBooksState createState() => LendMyBooksState();
}

class LendMyBooksState extends State<LendMyBooks> with TickerProviderStateMixin {
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
            color: lentThemePrimary,
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
              text: "My Books",
            ),
            Tab(
              text: "Add books",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          LendMyBookScreen(),
          LendAddBookScreen()

        ],
      ),
    );
  }
}
