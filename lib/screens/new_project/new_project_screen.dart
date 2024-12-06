import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/core/cubit/sub_pick_cubit.dart';
import 'package:sub_app/core/theme.dart';
import 'package:sub_app/core/widgets/shadow_header_delegate.dart';
import 'package:sub_app/core/widgets/text_field_widget.dart';
import 'package:sub_app/screens/new_project/cubit/pick_image_cubit.dart';
import 'package:sub_app/screens/new_project/widgets/pick_image_card.dart';

class NewProjectScreen extends StatefulWidget {
  const NewProjectScreen({super.key});

  @override
  NewProjectScreenState createState() => NewProjectScreenState();
}

class NewProjectScreenState extends State<NewProjectScreen> {
  final TextEditingController nameController = TextEditingController();
  String engFilePath = "";
  String selectedStatus = "Не переведено";
  File? imageFile;
  @override
  void initState() {
    super.initState();
    context.read<PickImageCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Новый проект"),
            surfaceTintColor: Colors.white,
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: ShadowHeaderDelegate(),
          ),
          BlocListener<ProjectBloc, ProjectState>(
            listener: (context, state) {
              if (state is ProjectAddedState) {
                context.read<SubPickCubit>().resetState();
                context
                    .read<ProjectBloc>()
                    .add(GetAllProjectsEvent(completer: null));
                Navigator.pop(context); // Возврат на предыдущий экран
              } else if (state is ProjectErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            child: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<PickImageCubit, PickImageState>(
                  builder: (context, state) {
                    if (state is ImagePicked) {
                      imageFile = state.image;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PickImageCard(imageFile: imageFile),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 48,
                                      child: TextFieldWidget(
                                        maxLength: 25,
                                        obscureText: false,
                                        label: "Название проекта",
                                        controller: nameController,
                                      )),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          "Субтитры",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Файл субтитров ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                IconButton(
                                  padding: const EdgeInsets.all(0),
                                  tooltip: "Выбрать субтитры",
                                  icon: Container(
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.file_upload_outlined,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "Загрузить файл",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  onPressed: () async {
                                    final result = await FilePicker.platform
                                        .pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: ['srt']);
                                    if (result != null &&
                                        result.files.isNotEmpty) {
                                      engFilePath = result.files.single.path!;
                                      context
                                          .read<SubPickCubit>()
                                          .loadSubtitles(engFilePath);
                                      setState(() {});
                                    }
                                  },
                                ),
                              ],
                            ),
                            if (engFilePath.isNotEmpty) ...[
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                engFilePath.split('/').last,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    overflow: TextOverflow.fade),
                              ),
                            ]
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 180,
        child: FloatingActionButton(
          onPressed: () {
            final name = nameController.text.trim();
            // Validate if both name and subtitle file are provided
            if (name.isNotEmpty && engFilePath.isNotEmpty) {
              context.read<ProjectBloc>().add(
                    CreateProjectEvent(
                      name: name,
                      engSubtitleFilePath: engFilePath,
                      status: selectedStatus,
                      imageFile: imageFile, // Передача выбранного статуса
                    ),
                  );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Заполните все поля!")),
              );
            }
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check),
              SizedBox(
                width: 12,
              ),
              Text("Создать проект"),
            ],
          ),
        ),
      ),
    );
  }
}
