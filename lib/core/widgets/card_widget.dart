import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.project,
  });

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              // Убедитесь, что project.id не null
              context.go('/project', extra: project.id);
            },
            child: ClipRRect(
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
          ),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
            width: 116,
            child: Text(
              project.name,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
