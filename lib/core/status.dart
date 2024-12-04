import 'package:flutter/material.dart';

enum Status {
  notTranslated,
  inProgress,
  completed,
}

extension StatusExtension on Status {
  String get displayName {
    switch (this) {
      case Status.notTranslated:
        return 'Не переведено';
      case Status.inProgress:
        return 'В процессе';
      case Status.completed:
        return 'Завершено';
    }
  }

  IconData get icon {
    switch (this) {
      case Status.notTranslated:
        return Icons.translate;
      case Status.inProgress:
        return Icons.work;
      case Status.completed:
        return Icons.done;
    }
  }
}
