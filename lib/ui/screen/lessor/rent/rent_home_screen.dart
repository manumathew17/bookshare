import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../theme/app_style.dart';
import '../../../../theme/colors.dart';
import 'on_rent_screen.dart';

class RentHomeScreen extends StatefulWidget {
  const RentHomeScreen({super.key});

  @override
  RentHomeScreenState createState() => RentHomeScreenState();
}

class RentHomeScreenState extends State<RentHomeScreen> with TickerProviderStateMixin {
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
        title: Text('Lent Books', style: header.copyWith(color: blackPrimary)),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "On Rent",
            ),
            Tab(
              text: "Returned",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          OnRentScreen(),
          Text("TO DO")
        ],
      ),
    );
  }
}