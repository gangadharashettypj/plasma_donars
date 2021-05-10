import 'package:flutter/material.dart';
import 'package:plasma_donars/common_widgets/app_bar_widget.dart';
import 'package:plasma_donars/common_widgets/button_widget.dart';
import 'package:plasma_donars/common_widgets/label_widget.dart';
import 'package:plasma_donars/common_widgets/scaffold/my_scaffold.dart';
import 'package:plasma_donars/navigator/navigator.dart';
import 'package:plasma_donars/screens/donate_screen/donate.dart';
import 'package:plasma_donars/screens/request_screen/request.dart';
import 'package:plasma_donars/simplifiers/sized_box.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBarWidget(
        title: 'Plasma Donars',
        showLeftIcon: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizedBox.h30,
            LabelWidget(
              'Intro Text Intro Text Intro Text Intro Text Intro Text Intro Text Intro Text Intro Text Intro Text Intro Text Intro Text Intro Text Intro Text Intro Text Intro Text gs fsddsf d',
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
            CustomSizedBox.h30,
            CustomSizedBox.h30,
            ButtonWidget(
              title: 'Donate',
              onPressed: () {
                NavigationService.instance.push(
                  context,
                  Donate.route,
                );
              },
            ),
            CustomSizedBox.h30,
            ButtonWidget(
              title: 'Request',
              onPressed: () {
                NavigationService.instance.push(
                  context,
                  RequestScreen.route,
                );
              },
            ),
            CustomSizedBox.h30,
          ],
        ),
      ),
    );
  }
}
