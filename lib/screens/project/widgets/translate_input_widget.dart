import 'package:flutter/material.dart';

class TranslateInputWidget extends StatefulWidget {
  Map<int, String> translatedSubtitles;
  final int index;

  TranslateInputWidget({
    super.key,
    required this.index,
    required this.translatedSubtitles,
  });

  @override
  State<TranslateInputWidget> createState() => _TranslateInputWidgetState();
}

class _TranslateInputWidgetState extends State<TranslateInputWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
        text: widget.translatedSubtitles[widget.index] ?? "");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        onChanged: (value) {
          setState(() {
            widget.translatedSubtitles[widget.index] = value;
          });
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12, // Высота контента
            horizontal: 12, // Горизонтальные отступы
          ),
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
          hintStyle:  TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.grey,
          ),
          labelText: "Перевод",
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
