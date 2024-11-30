import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/screens/new_project/new_project_screen.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Проекты"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Completer completer = Completer();
          context
              .read<ProjectBloc>()
              .add(GetAllProjectsEvent(completer: completer));
          completer.future;
        },
        child: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProjectsLoadedState) {
              final projects = state.projects;
              if (projects.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Пока что здесь пусто!',
                        style: TextStyle(fontSize: 45),
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
              return SizedBox(
                height: 500,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                                "https://via.placeholder.com/116x176"),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(project.name),
                        ],
                      ),
                    );
                  },
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
            if (state is ProjectLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Center(
              child: Text("ПРивеь"),
            );
          },
        ),
      ),
      floatingActionButton: SizedBox(
        width: 180,
        child: FloatingActionButton(
          tooltip: 'Создайте новый перевод',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewProjectScreen()),
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
      ),
    );
  }
}
