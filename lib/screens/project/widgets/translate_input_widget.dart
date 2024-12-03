import 'package:flutter/material.dart';

class TranslateInputWidget extends StatelessWidget {
  const TranslateInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 48,
        child: TextField(
          onChanged: (value) {
            //translation[index.toString()] = value;
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF6E6E6E),
                width: 1, // Ширина границы
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF6E6E6E), // Цвет границы в активном состоянии
                width: 1, // Ширина границы при фокусе
              ),
            ),
            hintText: "Введите перевод",
            labelText: "Перевод",
          ),
        ),
      ),
    );
  }
}
