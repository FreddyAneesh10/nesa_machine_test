import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import 'widget_theme.dart';

final ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,

  scaffoldBackgroundColor: AppColors.white,
  textTheme: lightTextTheme,

  // make sure you define this
  colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.purple,
    onPrimary: Colors.white,
    secondary: Colors.purpleAccent,
    surface: Colors.white,
    onSurface: Colors.black,
  ),

  // AppBar Theme
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.purple,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'inter',
    ),
    surfaceTintColor: Colors.transparent,
  ),

  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      // text color
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: const StadiumBorder(),
      minimumSize: const Size(double.infinity, 50),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade100,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.purple),
    ),
  ),
);
