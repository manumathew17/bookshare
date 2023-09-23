import 'package:bookshare/config/account.dart';
import 'package:bookshare/provider/auth/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _checkIsLoggedInOrNot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Set the background color of the screen
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 60.w,
                  child: Image.asset('assets/logo/lively-logo.png'), // Replace with your image asset path
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'version 123',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkIsLoggedInOrNot() async {
    await Future.delayed(const Duration(seconds: 1));
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isLogged = await authProvider.isLoggedIn();
    if (isLogged) {
      if (AccountConfig.userDetail.user.address == "") {
        context.go('/add-address');
      } else {
        context.go('/home');
      }
    } else {
      context.go('/login');
    }
  }
}
