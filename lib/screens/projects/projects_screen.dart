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
    super.initState();
    context.read<ProjectBloc>().add(LoadProjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Проекты"),
        centerTitle: true,
      ),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state is ProjectsLoadedState) {
            final projects = state.projects;
            return ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return ListTile(
                  leading: const Icon(Icons.folder),
                  title: Text(project.name),
                  onTap: () {
                    // TODO: Реализовать переход к экрану деталей проекта
                  },
                );
              },
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
        },
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
