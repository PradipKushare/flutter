import 'package:flutter/material.dart';
import 'package:flamedemo/utils/colors.dart';
import 'package:flamedemo/utils/screen_util.dart';

class FontFamily {
  static String black = "Rubik-Black";
  static String blackItalic = "Rubik-BlackItalic";
  static String bold = "Rubik-Bold";
  static String boldItalic = "Rubik-BoldItalic";
  static String italic = "Rubik-Italic";
  static String light = "Rubik-Light";
  static String lightItalic = "Rubik-LightItalic";
  static String medium = "Rubik-Medium";
  static String mediumItalic = "Rubik-MediumItalic";
  static String regular = "Rubik-Regular";
}

class TextStyles {
  static TextStyle get snackBarText => TextStyle(
        fontFamily: FontFamily.medium,
        fontSize: FontSize.s15,
        color: Colors.white,
        letterSpacing: 1.4,
        inherit: false,
      );

  static TextStyle get appName => TextStyle(

      
        fontSize: FontSize.s26,
        color: AppColors.primary,
        shadows: [

          Shadow(
              // topRight
              offset: Offset(1.5, 1.5),
              color: Colors.black),
          Shadow(
              // topLeft
              offset: Offset(-1.5, 1.5),
              color: Colors.black),
        ],
        letterSpacing: 5.0,
        inherit: false,
      );

  static TextStyle get editText => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s16,
        color: Colors.black,
        inherit: false,
        textBaseline: TextBaseline.alphabetic,
        letterSpacing: 3.0,
      );

  static TextStyle get labelStyle => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s16,
        color: Colors.grey,
        inherit: false,
      );

  static TextStyle get errorStyle => TextStyle(
        fontFamily: FontFamily.light,
        fontSize: FontSize.s12,
        color: Colors.red,
        inherit: false,
      );

  static TextStyle get buttonText => TextStyle(
        fontFamily: FontFamily.medium,
        fontSize: FontSize.s15,
        color: Colors.white,
        inherit: false,
      );

  static TextStyle get loginTitle => TextStyle(
        fontFamily: FontFamily.bold,
        fontSize: FontSize.s24,
        color: Colors.black,
        inherit: false,
      );

  static TextStyle get loginSubTitle => TextStyle(
        fontFamily: FontFamily.regular,
        fontSize: FontSize.s14,
        color: Colors.grey,
        inherit: false,
      );
}
