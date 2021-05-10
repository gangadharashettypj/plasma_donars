import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:plasma_donars/common_widgets/app_bar_widget.dart';
import 'package:plasma_donars/common_widgets/button_widget.dart';
import 'package:plasma_donars/common_widgets/label_widget.dart';
import 'package:plasma_donars/common_widgets/scaffold/my_scaffold.dart';
import 'package:plasma_donars/navigator/navigator.dart';
import 'package:plasma_donars/resources/colors.dart';
import 'package:plasma_donars/screens/donate_screen/register.dart';
import 'package:plasma_donars/simplifiers/sized_box.dart';
import 'package:plasma_donars/utils/info_message_template.dart';

class Donate extends StatefulWidget {
  static const String route = '/donate';
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  List<dynamic> notes;
  @override
  void initState() {
    FirebaseDatabase.instance
        .reference()
        .child('donarsNote')
        .once()
        .then((value) {
      setState(() {
        notes = value.value as List;
      });
    });
    super.initState();
  }

  Widget buildScreen() {
    if (notes == null) {
      return InfoMessageTemplate(
        'Loading',
        showLoader: true,
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      child: Column(
        children: [
          CustomSizedBox.h30,
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: LabelWidget('${index + 1}. ${notes[index]}'),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: MyColors.dividerColors,
                  thickness: 1,
                  height: 30,
                );
              },
              itemCount: notes.length,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ButtonWidget(
              title: 'Next',
              onPressed: () {
                NavigationService.instance.pushReplacement(
                  context,
                  RegisterPlasma.route,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBarWidget(
        title: 'Things to note',
      ),
      body: buildScreen(),
    );
  }
}
