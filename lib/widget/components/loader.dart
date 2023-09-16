import 'package:flutter/material.dart';

class Loader {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void show(BuildContext context) {
    if (_isVisible) return;

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Stack(
        children: [
          GestureDetector(
            onTap: () {}, // To prevent dismissing on tap
            child: Container(
              color: Colors.transparent,
            ),
          ),
          const Center(
            child: CircularProgressIndicator(), // Loader widget
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;
  }

  static void hide() {
    if (!_isVisible) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
    _isVisible = false;
  }
}
