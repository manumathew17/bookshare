import 'package:flutter/material.dart';

const ColorScheme customColorScheme = ColorScheme(
  primary: Color(0xFF000000), // Primary color
  // primaryVariant: const Color(0xFF4341D1), // Deprecated, use primary or primaryContainer instead
  secondary: Color(0xffffffff), // Secondary color
  // secondaryVariant: const Color(0xFFD97F1E), // Darker shade of secondary color
  surface: Colors.white, // Surface color (e.g., card background)
  background: Colors.white, // Background color
  error: Color(0xFFD32F2F), // Error color
  onPrimary: Colors.white, // Color for text/icons on primary color
  onSecondary: Colors.black, // Color for text/icons on secondary color
  onSurface: Colors.black, // Color for text/icons on surface color
  onBackground: Colors.black, // Color for text/icons on background color
  onError: Colors.white, // Color for text/icons on error color
  brightness: Brightness.light, // Brightness (light or dark)
);