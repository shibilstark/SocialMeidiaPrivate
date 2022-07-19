import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
      splashColor: softBlack,
      canvasColor: shimmerLight,
      dividerColor: primaryBlue,
      dialogTheme: const DialogTheme(backgroundColor: primaryBlue),
      scaffoldBackgroundColor: smoothWhite,
      appBarTheme: const AppBarTheme(backgroundColor: primaryBlue),
      iconTheme: const IconThemeData(
        color: darkBlue,
      ),
      primaryIconTheme: const IconThemeData(
        color: pureWhite,
      ),
      drawerTheme: DrawerThemeData(backgroundColor: pureWhite.withOpacity(0.7)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryBlue),
          // foregroundColor: MaterialStateProperty.all(darkBg),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: smoothWhite,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.sm),
                topRight: Radius.circular(40.sm)),
          )),
      dialogBackgroundColor: pureWhite,
      textTheme: TextTheme(
        titleSmall: TextStyle(
            color: pureWhite, fontSize: 18.sm, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(
            color: pureWhite, fontSize: 35.sm, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(
            color: darkBlue, fontSize: 23.sm, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(
            color: darkBlue, fontWeight: FontWeight.w400, fontSize: 17.sm),
        bodyMedium: TextStyle(
            color: softBlack, fontWeight: FontWeight.normal, fontSize: 14.sm),
        bodySmall: TextStyle(
            fontSize: 14.sm, color: pureWhite, fontWeight: FontWeight.w400),
      ),
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(backgroundColor: primaryBlue));
  static ThemeData darkTheme = ThemeData(
    splashColor: smoothWhite,
    dividerColor: softGrey,
    canvasColor: shimmerDark,
    dialogTheme: const DialogTheme(backgroundColor: darkBg),
    scaffoldBackgroundColor: softBlack,
    appBarTheme: const AppBarTheme(backgroundColor: darkBg),
    iconTheme: const IconThemeData(
      color: smoothWhite,
    ),
    dialogBackgroundColor: softBlack,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(darkBg),
        // foregroundColor: MaterialStateProperty.all(softBlack),
      ),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: darkBg.withOpacity(0.6)),
    primaryIconTheme: const IconThemeData(
      color: pureWhite,
    ),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: darkBg,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.sm),
              topRight: Radius.circular(40.sm)),
        )),
    textTheme: TextTheme(
      titleSmall: TextStyle(
          color: pureWhite, fontSize: 18.sm, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          color: pureWhite, fontSize: 35.sm, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          color: pureWhite, fontSize: 23.sm, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(
          color: pureWhite, fontWeight: FontWeight.w400, fontSize: 17.sm),
      bodyMedium: TextStyle(
          color: smoothWhite, fontWeight: FontWeight.normal, fontSize: 14.sm),
      bodySmall: TextStyle(
          fontSize: 14.sm, color: pureWhite, fontWeight: FontWeight.w400),
    ),
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: darkBg),
  );
}

final titleLarge =
    TextStyle(fontSize: 35.sm, color: pureWhite, fontWeight: FontWeight.bold);
final titleAppbar =
    TextStyle(fontSize: 22.sm, color: pureWhite, fontWeight: FontWeight.bold);
final fieldTitle =
    TextStyle(fontSize: 18.sm, color: pureWhite.withOpacity(0.6));
final roundedButtonStyle =
    TextStyle(fontSize: 18.sm, color: primaryBlue, fontWeight: FontWeight.bold);
final smallTextureStyle =
    TextStyle(fontSize: 14.sm, color: pureWhite, fontWeight: FontWeight.normal);
final tabBartitleStyle =
    TextStyle(fontSize: 18.sm, fontWeight: FontWeight.bold, color: primaryBlue);
