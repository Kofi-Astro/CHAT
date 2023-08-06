import 'package:flutter/material.dart';

import 'colors.dart';

final dividerTheme =
    const DividerThemeData().copyWith(thickness: 1.2, indent: 75.0);
const appBarTheme = AppBarTheme(
  elevation: 0,
  centerTitle: true,
  backgroundColor: Colors.white,
  iconTheme: IconThemeData(
    color: AppColor.primaryText,
  ),
  titleTextStyle: TextStyle(
    color: AppColor.primaryText,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  ),
  toolbarTextStyle: TextStyle(
    color: AppColor.primaryText,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  ),
);

const tabBarTheme = TabBarTheme(
  indicatorSize: TabBarIndicatorSize.label,
  labelColor: AppColor.primaryText,
  unselectedLabelColor: AppColor.secondaryText,
);

const bottomNavigationBar = BottomNavigationBarThemeData(
  backgroundColor: AppColor.primaryBackground,
  unselectedLabelStyle: TextStyle(fontSize: 12),
  selectedLabelStyle: TextStyle(fontSize: 12),
  unselectedItemColor: Color(0xffA2A5B9),
  selectedItemColor: AppColor.accentColor,
);

ThemeData lightTheme(BuildContext context) => ThemeData.light().copyWith(
      brightness: Brightness.light,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColor.primaryBackground,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      primaryColor: AppColor.primaryColor,
      appBarTheme: appBarTheme,
      bottomNavigationBarTheme: bottomNavigationBar,
      tabBarTheme: tabBarTheme,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(
            secondary: AppColor.accentColor,
          )
          .copyWith(secondary: AppColor.accentColor),
    );

ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: AppColor.primaryColor,
    appBarTheme: appBarTheme,
    bottomNavigationBarTheme: bottomNavigationBar,
    tabBarTheme: tabBarTheme,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(
          secondary: AppColor.accentColor,
        )
        .copyWith(secondary: AppColor.accentColor));

bool isLightTheme(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.light;
}
