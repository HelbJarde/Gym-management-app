import 'package:flutter/material.dart';

class CustomColors {
  static const kGreenColor = Color(0xFF66CAA6);
  static const kRedColor = Color(0xFFFA6060);
  static const kWhiteColor = Color(0xFFFFFFFF);
  static const kBlackColor = Color(0xFF090909);
  static const kPrimaryColor = Color(0xFF60A5FA);
  static const kLightBlackColor = Color(0xFF252525);
  static const kLightGreyColor = Color(0xFF828282);
  static const kDarkGreyColor = Color(0xFF414141);
  static const kMilkyColor = Color(0xFFFAFAFA);
  static const kLightCardColor = Color(0xFFF2F2F2);
  static const kDarkCardColor = Color(0xFF414141);
}

ThemeData lightTheme(String fontName) {
  return ThemeData(
    fontFamily: fontName,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16.0),
      hintStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: CustomColors.kMilkyColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: CustomColors.kLightGreyColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: CustomColors.kPrimaryColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: CustomColors.kRedColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: CustomColors.kRedColor,
        ),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: CustomColors.kBlackColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: CustomColors.kBlackColor,
      ),
      bodySmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: CustomColors.kLightGreyColor,
      ),
    ),
    scaffoldBackgroundColor: CustomColors.kMilkyColor,
    colorScheme: const ColorScheme.light(
      primary: CustomColors.kPrimaryColor,
      onPrimary: CustomColors.kWhiteColor,
      secondary: CustomColors.kWhiteColor,
      onSecondary: CustomColors.kBlackColor,
      tertiary: CustomColors.kLightCardColor,
    ),
  );
}

ThemeData darkTheme(String fontName) {
  return ThemeData(
    fontFamily: fontName,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(16.0),
      hintStyle: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: CustomColors.kLightBlackColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: CustomColors.kLightGreyColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: CustomColors.kPrimaryColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: CustomColors.kRedColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: CustomColors.kRedColor,
        ),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: CustomColors.kWhiteColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: CustomColors.kWhiteColor,
      ),
      bodySmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: CustomColors.kLightGreyColor,
      ),
    ),
    scaffoldBackgroundColor: CustomColors.kLightBlackColor,
    colorScheme: const ColorScheme.dark(
      primary: CustomColors.kPrimaryColor,
      onPrimary: CustomColors.kWhiteColor,
      secondary: CustomColors.kBlackColor,
      onSecondary: CustomColors.kWhiteColor,
      tertiary: CustomColors.kDarkCardColor,
    ),
  );
}
