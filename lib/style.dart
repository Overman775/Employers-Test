import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Style {
  static const Color primaryColor = Color(0xffea4c89);
  static const MaterialColor primaryColorMaterial = MaterialColor(
    0xffea4c89,
    <int, Color>{
      50: Color(0xffea4c89),
      100: Color(0xffea4c89),
      200: Color(0xffea4c89),
      300: Color(0xffea4c89),
      400: Color(0xffea4c89),
      500: Color(0xffea4c89),
      600: Color(0xffea4c89),
      700: Color(0xffea4c89),
      800: Color(0xffea4c89),
      900: Color(0xffea4c89),
    },
  );

  static const Color secondColor = Color(0xffcd3b73);
  static const Color textColor = Color(0xff444444);
  static const Color subTextColor = Color(0xff9e9e9e);
  static const Color bgColor = Color(0xffe7e7e7);
  static const Color editColor = Color(0xff4ceaad);
  static const Color deleteColor = Color(0xffea4c54);

  static const LinearGradient addButtonGradient = LinearGradient(
      colors: <Color>[Style.primaryColor, Style.secondColor],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight);

  static const double mainPadding = 16.00;
  static const double doublePadding = 32.00;
  static const double halfPadding = 8.00;
  static double mainBorderRadiusValue = 16.0;
  static BorderRadius mainBorderRadius =
      BorderRadius.circular(mainBorderRadiusValue);

  static const TextStyle headerTextStyle =
      TextStyle(color: Style.textColor, fontSize: 24.00);

  static const TextStyle buttonTextStyle =
      TextStyle(color: Colors.white, fontSize: 16.00);

  static const TextStyle mainDateTextStyle =
      TextStyle(color: Style.textColor, fontSize: 32.00);

  static const TextStyle cardTitleTextStyle =
      TextStyle(color: Style.textColor, fontSize: 32.00);

  //TODO: delete opacity
  static TextStyle mainDateSubTextStyle =
      TextStyle(color: Style.textColor.withOpacity(0.5), fontSize: 32.00);

  static TextStyle mainTasksTextStyle =
      TextStyle(color: Style.textColor.withOpacity(0.5), fontSize: 16.00);

  static const List<BoxShadow> boxShadows = [
    BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        offset: Offset(6, 2),
        blurRadius: 6.0,
        spreadRadius: 3.0),
    BoxShadow(
        color: Color.fromRGBO(255, 255, 255, 0.4),
        offset: Offset(-6, -2),
        blurRadius: 6.0,
        spreadRadius: 3.0)
  ];

  static List<BoxShadow> buttonGlow = [
    BoxShadow(
        color: Style.primaryColor.withOpacity(0.3),
        offset: Offset(0, 6),
        blurRadius: 12.0,
        spreadRadius: 6.0)
  ];
}
