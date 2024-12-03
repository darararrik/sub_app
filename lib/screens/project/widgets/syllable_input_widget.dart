import 'package:flutter/material.dart';

class SyllableInputWidget extends StatelessWidget {
  const SyllableInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: TextField(
        textAlign: TextAlign.center, // Горизонтальное выравнивание
        textAlignVertical:
            TextAlignVertical.center, // Вертикальное выравнивание
        keyboardType: TextInputType.number,
        maxLength: 2,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.zero,
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
