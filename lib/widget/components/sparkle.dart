import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Sparkle {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void show(BuildContext context) {
    if (_isVisible) return;

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Stack(
        children: [
          Container(
            color: Colors.transparent,
          ),
           Center(
            child: SizedBox(height: double.infinity, width: double.infinity,
            child: Lottie.asset('assets/lottie/sparkle.json', repeat: false))
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;

    Future.delayed(const Duration(seconds: 3), () {
      hide();
    });
  }

  static void hide() {
    if (!_isVisible) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
    _isVisible = false;
  }
}