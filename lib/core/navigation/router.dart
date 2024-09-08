import 'package:flutter/material.dart';

import '../../feature/debug/debug_page.dart';
import '../../feature/feedback/feedback_page.dart';
import '../../feature/home/home_page.dart';
import '../../feature/list/list_page.dart';
import '../../feature/newTask/new_task_page.dart';
import '../../feature/signIn/sign_in_fragment.dart';
import '../../feature/taskDetail/task_detail_page.dart';
import '../../feature/taskDetail/task_detail_page_state.dart';
import '../services/analytics_service.dart';

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
      // case search:
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (context) => const SearchPage(),
      //   );
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
