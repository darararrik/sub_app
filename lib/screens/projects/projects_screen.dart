import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/core/bloc/project_bloc.dart';
import 'package:sub_app/core/widgets/card_widget.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
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
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          Completer completer = Completer();
          context
              .read<ProjectBloc>()
              .add(GetAllProjectsEvent(completer: completer));
          completer.future;
        },
        child: CustomScrollView(
          slivers: [
            _appBar(),
            SliverToBoxAdapter(
              child: BlocBuilder<ProjectBloc, ProjectState>(
                builder: (context, state) {
                  if (state is ProjectLoadingState) {
                    return _loadingState();
                  }
                  if (state is ProjectsLoadedState) {
                    final projects = state.projects;

                    if (projects.isEmpty) {
                      return _listEmptyState();
                    }
                    return _listNotEmpty(projects);
                  }
                  if (state is ProjectErrorState) {
                    return _errorState(state);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
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

  SizedBox _listNotEmpty(List<Project> projects) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return CardWidget(project: project);
        },
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

Center _listEmptyState() {
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

SliverAppBar _appBar() {
  return const SliverAppBar(
    title: Text("Проекты"),
    pinned: true,
  );
}
