import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.validator,
    required this.obscureText,
    this.maxLength = 100,
  });
  final String hintText;
  final String labelText;

  final TextEditingController controller;
  final bool obscureText;
  String? Function(String?)? validator;
  int maxLength;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength), // Максимум 20 символов
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
          label: Text(labelText),
          hintText: hintText,
          hintStyle: TextStyle(fontWeight: FontWeight.w400)),
    );
  }
}
