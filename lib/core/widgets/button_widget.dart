// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool hasColor; // Добавлен булевый параметр
  final bool hasColorText; // Добавлен булевый параметр

  final Color color;

  double? width;

  double? height; // Добавлен булевый параметр

  ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.hasColor = true,
    this.hasColorText = true,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all(hasColor ? color : Colors.transparent),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: theme.textTheme.titleSmall!.copyWith(
            color: hasColorText ? Colors.white : theme.colorScheme.primary,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
