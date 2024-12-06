import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_app/repositories/model/project/project_model.dart';
import 'package:sub_app/repositories/project_repo/project_repo_interface.dart';

class CardSubtitleCubit extends Cubit<Map<int, bool>> {
  final IProjectRepo projectRepo;
  Project? project;

  CardSubtitleCubit(this.projectRepo) : super({});

  // Метод для инициализации с проектом
  void initialize(Project project) {
    this.project = project;
    _loadExpansionState();
  }

  void _loadExpansionState() {
    if (project != null) {
      // Преобразуем записи из project.isExpanded, преобразуя ключи в int
      final Map<int, bool> savedState = {
        for (var entry in project!.isExpanded.entries)
          int.tryParse(entry.key) ?? -1: entry
              .value, // Если int.parse не удастся, используем -1 как значение по умолчанию
      };
      emit(savedState);
    }
  }

  void toggleExpansion(int index) {

    final currentState = Map<int, bool>.from(state); // Копия текущего состояния
    final isExpanded =
        currentState[index] ?? true; // Получаем текущее состояние
    currentState[index] = !isExpanded; // Переключаем состояние

    emit(currentState); // Эмитируем новое состояние

    // Обновляем состояние в репозитории
    projectRepo.updateExpansionState(project!, {
      index.toString(): !isExpanded
    }); // Передаем обновленное состояние в репозиторий
  }
}
