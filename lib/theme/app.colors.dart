import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xffE906E0);
  static const Color blueColor = Color(0xff0077FF);
  static const Color orangeColor = Color(0xffFCAC12);
  static const Color greenColor = Color(0xff00A86B);
  static const Color redColor = Color(0xffFD3C4A);
  static const Color primaryDark = Color(0xff5233FF);
  static const Color textGray = Color(0xff5D6065);
  static Color outlineColor = Colors.grey.shade800;
  static const Color inputFillColor = Color(0xffF2F2F2);
  static Color bodyBackgroundColor = Color(0xffE5E5E5);

  static Color primaryFromOpacity({double opacity = 1}) {
    return Color.fromRGBO(255, 255, 255, opacity);
  }
}
