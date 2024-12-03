import 'package:flutter/material.dart';

class TranslateInputWidget extends StatefulWidget {
  final Map<int, String> translate;
  final int index;

  const TranslateInputWidget({
    super.key,
    required this.translate,
    required this.index,
  });

  @override
  State<TranslateInputWidget> createState() => _TranslateInputWidgetState();
}

class _TranslateInputWidgetState extends State<TranslateInputWidget> {
  late TextEditingController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 48,
        child: TextField(
          controller: _controller,
          onChanged: (value) {
            widget.translate[widget.index] = value;
          },
          decoration: InputDecoration(
            fillColor: const Color(0xFFFFFFFF),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromARGB(0, 110, 110, 110),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color.fromARGB(0, 110, 110, 110),
                width: 1,
              ),
            ),
            hintText: "Введите перевод",
            labelText: "Перевод",
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
