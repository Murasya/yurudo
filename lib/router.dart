import 'package:flutter/material.dart';
import 'package:routine_app/model/todo.dart';
import 'package:routine_app/pages/feedback/feedback_page.dart';
import 'package:routine_app/pages/home/home_page.dart';
import 'package:routine_app/pages/search_page.dart';
import 'package:routine_app/pages/taskDetail/task_detail_page.dart';

import 'pages/newTask/new_task_page.dart';

class AppRouter {
  static const home = '/home';
  static const newTask = '/new';
  static const search = '/search';
  static const detail = '/detail';
  static const feedback = '/feedback';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HomePage(),
        );
      case newTask:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const NewTaskPage(),
        );
      case search:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SearchPage(),
        );
      case detail:
        if (settings.arguments is! Todo) {
          throw ArgumentError('Todoを引数にしてください');
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => TaskDetailPage(
            todo: settings.arguments as Todo,
          ),
        );
      case feedback:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const FeedbackPage(),
        );
    }
    return null;
  }
}
