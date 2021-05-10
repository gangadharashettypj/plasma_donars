import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:logger/logger.dart';
import 'package:plasma_donars/constants/constants.dart';
import 'package:plasma_donars/router/router.dart';
import 'package:plasma_donars/splash.dart';
import 'package:plasma_donars/theme/dynamic_theme.dart';
import 'package:plasma_donars/theme/theme.dart';
import 'package:provider/provider.dart';

var logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<DynamicTheme>(
      create: (_) => DynamicTheme(),
      child: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DynamicTheme>(context);

    if (Constants.isNeu) {
      return NeumorphicApp(
        debugShowCheckedModeBanner: Constants.debugShowCheckedModeBanner,
        themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: MyTheme.instance.getLightTheme(),
        darkTheme: MyTheme.instance.getDarkTheme(),
        onGenerateRoute: AppRouter.generateRoute,
        home: Splash(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: Constants.debugShowCheckedModeBanner,
        theme: themeProvider.isDarkMode
            ? MyTheme.instance.getDarkTheme()
            : MyTheme.instance.getLightTheme(),
        onGenerateRoute: AppRouter.generateRoute,
        home: Splash(),
      );
    }
  }
}
