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
        keyboardType: TextInputType.number,
        maxLength: 2,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF6E6E6E),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF6E6E6E),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
