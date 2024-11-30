import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/core/cubit/sub_pick_cubit.dart';
import 'package:sub_app/core/widgets/tex_field_widget.dart';

class NewProjectScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  NewProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String filePath = "";
    String selectedStatus = "Created"; // Дефолтный статус

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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      //TODO: Доделать реализацию
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                            "https://via.placeholder.com/116x176")),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      TextFieldWidget(controller: nameController),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Статус:"),
                          DropdownMenu(
                            label: const Text("Выбери статус проекта"),
                            onSelected: (value) => selectedStatus = value!,
                            dropdownMenuEntries: const <DropdownMenuEntry<
                                String>>[
                              DropdownMenuEntry(
                                  value: "Созданный", label: "Созданный"),
                              DropdownMenuEntry(
                                  value: "В процессе", label: "В процессе"),
                              DropdownMenuEntry(
                                  value: "Переведено", label: "Переведено"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();

                  if (result != null && result.files.isNotEmpty) {
                    filePath = result.files.single.path!;
                    context.read<SubPickCubit>().loadSubtitles(filePath);
                  }
                },
                child: const Text("Выбрать файл субтитров"),
              ),
              BlocBuilder<SubPickCubit, SubPickState>(
                builder: (context, state) {
                  if (state is SubPickLoaded) {
                    return Text(
                        "Субтитров загружено: ${state.subtitles.length}");
                  }
                  return const SizedBox();
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  if (name.isNotEmpty) {
                    context.read<ProjectBloc>().add(
                          CreateProjectEvent(
                            name: name,
                            subtitleFilePath: filePath,
                            status:
                                selectedStatus, // Передача выбранного статуса
                          ),
                        );
                  }
                },
                child: const Text("Создать проект"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
