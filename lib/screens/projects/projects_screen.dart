import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/screens/auth/sign_up_screen.dart';
import 'package:sub_app/screens/new_project/new_project_screen.dart';
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
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
          child: BlocConsumer<ProjectBloc, ProjectState>(
            listener: (BuildContext context, ProjectState state) {
              if (state is ProjectDeleted) {
                context
                    .read<ProjectBloc>()
                    .add(GetAllProjectsEvent(completer: null));
              }
            },
            builder: (context, state) {
              if (state is ProjectLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProjectsLoadedState) {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(top: 24),
                  child: Column(
                    children: [
                      if (state.projectsN.isNotEmpty) ...[
                        HorizntalListProjects(
                          projects: state.projectsN,
                          name: Status.notTranslated.displayName,
                        ),
                      ],
                      if (state.projectsI.isNotEmpty) ...[
                        HorizntalListProjects(
                          projects: state.projectsI,
                          name: Status.inProgress.displayName,
                        ),
                      ],
                      if (state.projectsT.isNotEmpty) ...[
                        HorizntalListProjects(
                          projects: state.projectsT,
                          name: Status.completed.displayName,
                        ),
                      ]
                    ],
                  ),
                );
              }
              if (state is ProjectErrorState) {
                return Center(
                  child: Text(
                    'Ошибка: ${state.errorMessage}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              if (state is ProjectsEmptyState) {
                return Center(
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
              return SizedBox();
            },
          ),
        ),
      ),
      floatingActionButton: _floatButton(context),
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
