import 'package:bookshare/provider/auth/auth_provider.dart';
import 'package:bookshare/provider/book/book_provider.dart';
import 'package:bookshare/provider/book/my_book_provider.dart';
import 'package:bookshare/theme/app-theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import 'navigation/app_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => BookProvider()),
            ChangeNotifierProvider(create: (_) => MyBookProvider())
          ],
          child: MaterialApp.router(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: customColorScheme,
                fontFamily: GoogleFonts.karla().fontFamily,
                useMaterial3: true,
              ),
              themeMode: ThemeMode.light,
              routerConfig: route));
    });
  }
}
