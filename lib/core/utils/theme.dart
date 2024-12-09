import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    textTheme: TextTheme(
      titleMedium: TextStyle(
          fontFamily: "Montserrat", fontSize: 24, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(
          fontFamily: "Montserrat", fontSize: 16, fontWeight: FontWeight.w400),
      titleSmall: TextStyle(
          fontFamily: "Montserrat", fontSize: 20, fontWeight: FontWeight.w500),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white, // Цвет фона внутри поля
      hintStyle: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontFamily: "Montserrat",
          fontSize: 16), // Стиль подсказки
      labelStyle: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontFamily: "Montserrat",
          fontSize: 16), // Цвет метки
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        color: Color(0xFF4F52FF),
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontFamily: "Montserrat_Alternates",
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20)),
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
