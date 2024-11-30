
import 'package:flutter/material.dart';
import 'package:sub_app/new_project_screen.dart';

void main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ProjectsScreen(),
    );
  }
}

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Проекты"),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Пока что здесь пусто!',
              style: TextStyle(fontSize: 45),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Создайте новый проект',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 180,
        child: FloatingActionButton(
          tooltip: 'СОздайте нвоый перевод',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewProjectScreen()),
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              SizedBox(
                width: 12,
              ),
              Text("Новый перевод")
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
