
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../ui/screen/auth/create_account_screen.dart';
import '../ui/screen/auth/login_screen.dart';
import '../ui/screen/renter/category/category_screen.dart';
import '../ui/screen/home/home_screen.dart';
import '../ui/screen/lessor/books/lend_book.dart';
import '../ui/screen/lessor/home/home_screen.dart';
import '../ui/screen/lessor/rent/rent_home_screen.dart';
import '../ui/screen/my-book/my_book.dart';
import '../ui/screen/renter/arrival/new_arrival_screen.dart';
import '../ui/screen/profile/profile_screen.dart';
import '../ui/screen/renter/book-details/book_details.dart';
import '../ui/screen/splash_screen.dart';



final navigatorKey = GlobalKey<NavigatorState>();

final route = GoRouter(navigatorKey: navigatorKey, routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/create-account',
    builder: (context, state) => const CreateAccountScreen(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/new-arrival',
    builder: (context, state) => const NewArrivalScreen(),
  ),
  GoRoute(
    path: '/category',
    builder: (context, state) => const CategoryScreen(),
  ),
  GoRoute(
    path: '/book-details',
    builder: (context, state) => const BookDetailsScreen(),
  ),
  GoRoute(
    path: '/my-read',
    builder: (context, state) => const MyReadingScreen(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
  GoRoute(path: '/lend-home', builder: (context, state) => const LendBookHomeScreen()),
  GoRoute(path: '/lend-book', builder: (context, state) => const LendMyBooks()),
  GoRoute(path: '/rent', builder: (context, state) => const RentHomeScreen())
]);
