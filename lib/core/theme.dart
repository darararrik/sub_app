import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.white),
        color: primaryColor,
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w400, color: Colors.white, fontSize: 22)),
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
final primaryColor = const Color(0xFF3B3B3B);
