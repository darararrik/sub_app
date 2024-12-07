import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/core/cubit/sub_pick_cubit.dart';
import 'package:sub_app/core/utils/svg.dart';
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
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Новый проект"),
            leading: IconButton(onPressed: () => context.pop(), icon: backIcon),
            actions: [
              IconButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    // Validate if both name and subtitle file are provided
                    if (name.isNotEmpty && engFilePath.isNotEmpty) {
                      context.read<ProjectBloc>().add(
                            CreateProjectEvent(
                              name: name,
                              engSubtitleFilePath: engFilePath,
                              status: selectedStatus,
                              imageFile:
                                  imageFile, // Передача выбранного статуса
                            ),
                          );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Заполните все поля!")),
                      );
                    }
                  },
                  icon: confirmProjectWhite)
            ],
          ),
          BlocListener<ProjectBloc, ProjectState>(
            listener: (context, state) {
              if (state is ProjectAddedState) {
                context.read<SubPickCubit>().resetState();
                context
                    .read<ProjectBloc>()
                    .add(GetAllProjectsEvent(completer: null));
                context.pop();
              } else if (state is ProjectErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            child: SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                                        hintText: "Введите имя проекта",
                                        controller: nameController,
                                        labelText: 'Имя проекта',
                                      )),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text("Субтитры",
                              style: theme.textTheme.titleMedium),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                folder,
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Файл субтитров",
                                          style: theme.textTheme.bodyMedium),
                                      IconButton(
                                        padding: const EdgeInsets.all(0),
                                        tooltip: "Выбрать субтитры",
                                        icon: Container(
                                          decoration: BoxDecoration(
                                              color: theme.colorScheme.primary,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
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
                                                "Файл",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ),
                                        onPressed: () async {
                                          final result = await FilePicker
                                              .platform
                                              .pickFiles(
                                                  type: FileType.custom,
                                                  allowedExtensions: ['srt']);
                                          if (result != null &&
                                              result.files.isNotEmpty) {
                                            engFilePath =
                                                result.files.single.path!;
                                            context
                                                .read<SubPickCubit>()
                                                .loadSubtitles(engFilePath);
                                            setState(() {});
                                          }
                                        },
                                      ),
                                    ],
                                  ),
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
    );
  }
}
