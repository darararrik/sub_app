import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/screens/new_project/new_project_screen.dart';
import 'package:sub_app/screens/profile/profile_screen.dart';
import 'package:sub_app/screens/project/bloc/subtitles_bloc.dart';
import 'package:sub_app/core/status.dart';
import 'package:sub_app/screens/projects/widgets/horizntal_list_projects.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  void initState() {
    context.read<ProjectBloc>().add(GetAllProjectsEvent(completer: null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Переводы",
        ),
        elevation: 4,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.2),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
              icon: const Icon(
                Icons.account_circle_outlined,
                size: 32,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Completer completer = Completer();
          context
              .read<ProjectBloc>()
              .add(GetAllProjectsEvent(completer: completer));
          return completer.future;
        },
        child: BlocListener<SubtitlesBloc, SubtitlesState>(
          listener: (context, state) {
            if (state is SubtitlesSaved) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Проект сохранен")),
              );
            }
          },
          child: BlocBuilder<ProjectBloc, ProjectState>(
            builder: (context, state) {
              if (state is ProjectLoadingState) {
                return _loadingState();
              }
              if (state is ProjectsLoadedState) {
                final projects = state.projects;
                final projectsN = projects
                    .where((project) => project.status == "Не переведено")
                    .toList();
                final projectsI = projects
                    .where((project) => project.status == "В процессе")
                    .toList();
                final projectsT = projects
                    .where((project) => project.status == "Завершено")
                    .toList();
                return Column(
                  children: [
                    if (projectsN.isNotEmpty) ...[
                      HorizntalListProjects(
                        projects: projectsN,
                        name: Status.notTranslated.displayName,
                      ),
                    ],
                    if (projectsI.isNotEmpty) ...[
                      HorizntalListProjects(
                        projects: projectsI,
                        name: Status.inProgress.displayName,
                      ),
                    ],
                    if (projectsT.isNotEmpty) ...[
                      HorizntalListProjects(
                        projects: projectsT,
                        name: Status.completed.displayName,
                      ),
                    ]
                  ],
                );
              }
              if (state is ProjectErrorState) {
                return _errorState(state);
              }
              if (state is ProjectInitial) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Пока что здесь пусто!',
                        style: TextStyle(fontSize: 40),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Создайте новый проект',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
      floatingActionButton: _floatButton(context),
    );
  }

  Center _errorState(ProjectErrorState state) {
    return Center(
      child: Text(
        'Ошибка: ${state.errorMessage}',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Center _loadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  SizedBox _floatButton(BuildContext context) {
    return SizedBox(
      width: 180,
      child: FloatingActionButton(
        tooltip: 'Создайте новый перевод',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewProjectScreen()),
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit_outlined),
            SizedBox(width: 12),
            Text("Новый перевод")
          ],
        ),
      ),
    );
  }
}
