import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white, // Цвет фона внутри поля
      hintStyle:
          TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Стиль подсказки
      labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Цвет метки
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(Color(0xFF4F52FF)))),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        color: Colors.white,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w400, color: Colors.black, fontSize: 22)),
    colorScheme: const ColorScheme.light(
      primary: Color(
          0xFF4F52FF), // Основной цвет (будет использован вместо accentColor)
      secondary: Color(0xFF5d5d72), // Вторичный цвет, если вам нужен
      surface: Color(0xFFfcf8ff), // Цвет поверхности (например, фон карточек)
      error: Color(0xFFba1a1a), // Цвет для ошибок
      onPrimary: Color(0xFFffffff), // Цвет текста на основном фоне
      onSecondary: Color(0xFFFFFFFF), // Цвет текста на вторичном фоне
      onSurface: Color(0xFF1b1b21), // Цвет текста на поверхности
      onError: Color(0xFFFFFFFF), // Цвет текста на фоне ошибки),
    ));
const primaryColor = Color(0xFF4F52FF);
