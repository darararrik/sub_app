import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/image.dart';
import 'package:sub_app/screens/new_project/cubit/pick_image_cubit.dart';

class PickImageCard extends StatelessWidget {
  const PickImageCard({
    super.key,
    required this.imageFile,
  });

  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<PickImageCubit>()
            .pickImage(); // Выбор изображения через Cubit
      },
      child: Stack(
        children: [
          SizedBox(
            width: 116,
            height: 176,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: imageFile != null
                  ? Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    )
                  : placeholderImage,
            ),
          ),
          if (imageFile == null) ...[
            Container(
              width: 116,
              height: 176,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const Positioned.fill(
              child: Center(
                child: Icon(
                  Icons.add_a_photo_outlined,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
