import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/core/cubit/sub_pick_cubit.dart';
import 'package:sub_app/core/widgets/tex_field_widget.dart';
import 'package:sub_app/screens/new_project/cubit/pick_image_cubit.dart';
import 'package:sub_app/screens/new_project/widgets/pick_image_card.dart';

class NewProjectScreen extends StatefulWidget {
  const NewProjectScreen({super.key});

  @override
  _NewProjectScreenState createState() => _NewProjectScreenState();
}

class _NewProjectScreenState extends State<NewProjectScreen> {
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
      appBar: AppBar(title: const Text("Новый проект")),
      body: BlocListener<ProjectBloc, ProjectState>(
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
                          TextFieldWidget(controller: nameController),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  softWrap: true, // Включаем перенос текста
                                  "Статус проекта:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              DropdownButton<String>(
                                value: selectedStatus,
                                items: <String>[
                                  'Не переведено',
                                  'В процессе',
                                  'Переведено'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedStatus = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Субтитры",
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Английские субтитры ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          if (engFilePath.isNotEmpty) ...[
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              engFilePath
                                  .split('/')
                                  .last, // Показывает только имя файла
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ]
                        ],
                      ),
                      IconButton(
                        tooltip: "Выбрать субтитры",
                        icon: const Icon(
                          Icons.upload_rounded,
                          size: 32,
                        ),
                        onPressed: () async {
                          final result = await FilePicker.platform.pickFiles();
                          if (result != null && result.files.isNotEmpty) {
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
                  const SizedBox(
                    height: 12,
                  ),
                ],
              );
            },
          ),
        ),
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
                      imageFile: imageFile!, // Передача выбранного статуса
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
