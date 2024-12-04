import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    required this.obscureText,
  });
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              width: 1,
            ), // Цвет полоски при фокусе (не изменяется)
          ),
          label: Text(
            label,
          )),
    );
  }
}
