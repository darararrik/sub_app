import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool hasColor; // Добавлен булевый параметр
  final Color color; // Добавлен булевый параметр

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.hasColor = true,
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
            borderRadius: BorderRadius.circular(36),
            side: const BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
        ),
      ),
      child: Text(text,
          style: theme.textTheme.labelLarge!
              .copyWith(fontSize: 18, color: hasColor ? Colors.white : color)),
    );
  }
}
