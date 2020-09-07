import 'package:flutter/material.dart';

class Colors {
  const Colors();

  static const Color appBarTitle = const Color(0xFFFFFFFF);
  static const Color appBarIconColor = const Color(0xFFFFFFFF);
  static const Color appBarDetailBackground = const Color(0xFFFFFFFF);
  static const Color appBarGradientStart = const Color(0xFF3383FC);
  static const Color appBarGradientEnd = const Color(0xFF00C6FF);

  static const Color blogCard = const Color(0xFF1E88E5);
  static const Color blogPageBackground = const Color(0xFFFFFFFF);
  static const Color blogTitle = const Color(0xFFFFFFFF);
}

class Dimens {
  const Dimens();

  static const blogWidth = 50.0;
  static const blogHeight = 50.0;
}

class TextStyles {
  const TextStyles();

  static const TextStyle appBarTitle = const TextStyle(
    color: Colors.appBarTitle,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 36.0
  );

  static const TextStyle blogTitle = const TextStyle(
    color: Colors.blogTitle,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 16.0
  );
}
