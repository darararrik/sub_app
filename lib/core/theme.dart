import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFF3B3B3B)))),



            
    scaffoldBackgroundColor: Colors.white,




    appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        color: Colors.white,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w400, color: Colors.black, fontSize: 22)),





    colorScheme: const ColorScheme.light(
      primary: Color(
          0xFF3B3B3B), // Основной цвет (будет использован вместо accentColor)
      secondary: Color(0xFF929090), // Вторичный цвет, если вам нужен
      surface: Color(0xFFfdf8f8), // Цвет поверхности (например, фон карточек)
      error: Color(0xFF8c0009), // Цвет для ошибок
      onPrimary: Color(0xFFffffff), // Цвет текста на основном фоне
      onSecondary: Color(0xFFFFFFFF), // Цвет текста на вторичном фоне
      onSurface: Color(0xFF1c1b1b), // Цвет текста на поверхности
      onError: Color(0xFFFFFFFF), // Цвет текста на фоне ошибки),
    ));
const primaryColor = Color(0xFF3B3B3B);
