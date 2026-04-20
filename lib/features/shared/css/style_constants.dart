import 'package:flutter/material.dart';

// General Color collection for the app. It includes background colors, font colors, and other accent colors that are used throughout the app to maintain a consistent design language.
class MainColors {
  
  /// Main Themes
  // Deen
  static const Color emerald = Color(0xFF0F6E56);
  // Dates
  static const Color purple = Color(0xFF534AB7);
  // Finances
  static const Color gold = Color(0xFFBA7517);

  /// SubColors
  // Gradient
  static const Gradient gradientGreen = LinearGradient(
    begin: Alignment(0.0, -1.0),
    end: Alignment(0.0, 1.0),
    colors: [
      Color(0xff085041),
      Color.fromARGB(255, 16, 138, 107),
    ]);

  static const Gradient gradientYellow = LinearGradient(
  begin: Alignment(-0.6, -0.8), 
  end: Alignment(0.6, 0.8),
  colors: [
    Color(0xFF633806), 
    Color(0xFFBA7517), 
  ]);
  static const Gradient gradientPurple = LinearGradient(
  begin: Alignment(-0.7, -0.8),
  end: Alignment(0.7, 0.8),
  colors: [
    Color(0xFF3C3489),
    Color(0xFF534AB7),
  ]);

  //light sub Colors
  static const Color lightGreen = Color(0xFFE1F5EE);
  static const Color lightYellow = Color (0xFFFAEEDA);
  static const Color lightPurple = Color.fromARGB(255, 209, 206, 255);
  static const Color lightGrey = Color(0xFFF1EFE8);

  /// Fontcolors
  // Mainfont
  static const Color ink = Color(0xFF2C2C2A);
  // Subfont
  static const Color lightInk = Color.fromARGB(241, 103, 101, 100);

  /// App background
  static const Color daymode = Color(0xFFF5F5F3);
  static const Color nightmode = Color.fromARGB(255, 0, 0, 0);
}
