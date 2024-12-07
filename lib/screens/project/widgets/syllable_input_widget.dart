// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SyllableInputWidget extends StatefulWidget {
  Map<int, String> syll;
  final int index;

  SyllableInputWidget({
    super.key,
    required this.syll,
    required this.index,
  });

  @override
  State<SyllableInputWidget> createState() => _SyllableInputWidgetState();
}

class _SyllableInputWidgetState extends State<SyllableInputWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.syll[widget.index] ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          setState(() {
            widget.syll[widget.index] = value;
          });
        },
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
