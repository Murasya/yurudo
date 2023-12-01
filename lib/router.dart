import 'package:flutter/material.dart';
import 'package:routine_app/pages/debug/debug_page.dart';
import 'package:routine_app/pages/feedback/feedback_page.dart';
import 'package:routine_app/pages/home/home_page.dart';
import 'package:routine_app/pages/list/list_page.dart';
import 'package:routine_app/pages/search_page.dart';
import 'package:routine_app/pages/signIn/sign_in_fragment.dart';
import 'package:routine_app/pages/taskDetail/task_detail_page.dart';
import 'package:routine_app/pages/taskDetail/task_detail_page_state.dart';
import 'package:routine_app/services/analytics_service.dart';

import 'pages/newTask/new_task_page.dart';

class AppRouter {
  static const home = '/home';
  static const list = '/list';
  static const newTask = '/new';
  static const search = '/search';
  static const detail = '/detail';
  static const feedback = '/feedback';
  static const debug = '/debug';
  static const signIn = '/signIn';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    AnalyticsService.logPage(settings.name ?? '');
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HomePage(),
        );
      case list:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ListPage(),
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
        if (settings.arguments is! TaskDetailPageArgs) {
          throw ArgumentError('TaskDetailPageArgsを引数にしてください');
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => TaskDetailPage(
            args: settings.arguments as TaskDetailPageArgs,
          ),
        );
      case feedback:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const FeedbackPage(),
        );
      case AppRouter.debug:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const DebugPage(),
        );
      case signIn:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SignInFragment(),
        );
    }
    return null;
  }
}
