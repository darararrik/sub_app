import 'package:flutter/material.dart';

class SubtitleDataWidget extends StatelessWidget {
  const SubtitleDataWidget({
    super.key,
    required this.subtitleData,
  });

  final String subtitleData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Text(
          subtitleData,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
