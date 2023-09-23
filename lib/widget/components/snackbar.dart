import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import 'custom_snackbar.dart';

class GeneralSnackBar {
  final BuildContext _context;
  GeneralSnackBar(this._context);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void showErrorSnackBar(String message) {
    final snackBar = CustomSnackBar(
        message: message, iconData: Icons.error, color: errorPrimary);
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  void showWarningSnackBar(String message) {
    final snackBar = CustomSnackBar(
        message: message, iconData: Icons.warning_amber_rounded, color: warningPrimary);
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  void showSuccessSnackBar(String message) {
    final snackBar = CustomSnackBar(
        message: message, iconData: Icons.check_circle, color: darkGreen);
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  void hideSnackBar() {
    ScaffoldMessenger.of(_context).hideCurrentSnackBar();
  }
}
