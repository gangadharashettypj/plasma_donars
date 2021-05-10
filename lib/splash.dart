/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:plasma_donars/common_widgets/image_widget.dart';
import 'package:plasma_donars/common_widgets/label_widget.dart';
import 'package:plasma_donars/common_widgets/scaffold/my_scaffold.dart';
import 'package:plasma_donars/navigator/navigator.dart';
import 'package:plasma_donars/resources/images.dart';
import 'package:plasma_donars/screens/home_page.dart';

class Splash extends StatefulWidget {
  static const String route = '/splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 2), () async {
        NavigationService.instance.pushReplacement(
          context,
          HomePage.route,
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageWidget(
              imageLocation: MyImages.logo,
            ),
            LabelWidget(
              'Plasma Donars',
              size: 30,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
