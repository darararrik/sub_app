import 'package:flutter/material.dart';
import 'package:sub_app/core/utils/svg.dart';

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

  Widget get icon {
    switch (this) {
      case Status.notTranslated:
        return projects;
      case Status.inProgress:
        return projectsI;
      case Status.completed:
        return confirmProjectBlack;
    }
  }
}
