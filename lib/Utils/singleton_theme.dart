import 'package:flutter/material.dart';

final themeMine = ThemeData.from(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.brown[400],
    secondary: Colors.brown[700], // or Color(0xFF343A40),
  ),
);

/*
  brightness: Brightness.dark,
  primaryColor: Colors.lightBlue[800],

  // Define the default font family.
  fontFamily: 'Georgia',

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: const TextTheme(
  headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
  bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  )
  // Examples /////////////////////////////////////////////////////
  static const Color textColor = Color(0xFFccc7c5);

  // static final Color mainColor = const Color(0xFFfa7552);
  static const Color iconColor1 = Color(0xFFffd28d);
  static const Color iconColor2 = Color(0xFFfcab88);
  static const Color paraColor = Color(0xFF8f837f);
  static const Color buttonBackgroundColor = Color(0xFFf7f6f4);
  static const Color signColor = Color(0xFFa9a29f);
  static const Color titleColor = Color(0xFF5c52f4);
  static const Color mainBlackColor = Color(0xFF332d2b);

  // static final Color yellowColor = const Color(0xFFfa7552);
  static const Color yellowColor = Color(0xFFffd379);



}*/
