import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    this.labelText,
    required this.controller,
    this.validator,
    required this.obscureText,
    this.maxLength = 100,
    this.showLabel = true, // Добавляем новый параметр
  });

  final String hintText;
  final String? labelText; // Теперь labelText может быть null
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final int maxLength;
  final bool showLabel; // Новый параметр

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(
            maxLength), // Максимум maxLength символов
      ],
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      cursorColor: Colors.black,
      textAlign: TextAlign.start, // Горизонтальное выравнивание
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
              width: 1,
              color: Colors.grey), // Цвет полоски при фокусе (не изменяется)
        ),
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontFamily: "Montserrat",
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 1,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            width: 1,
          ), // Цвет полоски при фокусе (не изменяется)
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            width: 1,
          ), // Цвет полоски при фокусе (не изменяется)
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 1,
          ), // Цвет полоски при фокусе (не изменяется)
        ),
        label: showLabel && labelText != null
            ? Text(labelText!)
            : null, // Условно отображаем label
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: "Montserrat",
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
  }
}
