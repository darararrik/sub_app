import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${index + 1}",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(width: 10),
        const Text(
          "Строка",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontFamily: "Montserrat_Alternates"),
        ),
      ],
    );
  }
}
