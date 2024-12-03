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
              fillColor:  const Color.fromARGB(176, 246, 246, 246),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color.fromARGB(0, 110, 110, 110),
                  width: 1, // Ширина границы
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color.fromARGB(
                      0, 110, 110, 110), // Цвет границы в активном состоянии
                  width: 1, // Ширина границы при фокусе
                ),
              ),
              hintText: "Введите перевод",
              labelText: "Перевод",
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              hintStyle:
                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
        ),
      ),
    );
  }
}
