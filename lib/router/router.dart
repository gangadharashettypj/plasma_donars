/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:plasma_donars/common_widgets/scaffold/my_scaffold.dart';
import 'package:plasma_donars/screens/donate_screen/donate.dart';
import 'package:plasma_donars/screens/donate_screen/register.dart';
import 'package:plasma_donars/screens/home_page.dart';
import 'package:plasma_donars/screens/request_screen/request.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomePage(),
        );
      case Donate.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Donate(),
        );
      case RegisterPlasma.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RegisterPlasma(),
        );
      case RequestScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RequestScreen(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MyScaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
