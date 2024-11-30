import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/screens/project/project_screen.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MaterialPageRoute(builder: (context) => const ProjectScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 116,
                  height: 176,
                  child: Image.memory(
                    Uint8List.fromList(
                        project.imageBytes), // Преобразуем байты в Uint8List
                    fit: BoxFit.cover,
                  ),
                )),
            const SizedBox(
              height: 4,
            ),
            Text(
              project.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
