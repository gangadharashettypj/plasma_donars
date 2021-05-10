import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:plasma_donars/common_widgets/app_bar_widget.dart';
import 'package:plasma_donars/common_widgets/label_widget.dart';
import 'package:plasma_donars/common_widgets/scaffold/my_scaffold.dart';
import 'package:plasma_donars/common_widgets/textfield_widget.dart';
import 'package:plasma_donars/models/register_model.dart';
import 'package:plasma_donars/simplifiers/sized_box.dart';
import 'package:plasma_donars/theme/sizes.dart';
import 'package:plasma_donars/utils/info_message_template.dart';

class RequestScreen extends StatefulWidget {
  static const String route = '/request_screen';
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  List<RegisterModel> donarsList;
  String searchKey = '';

  List<RegisterModel> getDonarsList() {
    if (searchKey == null || searchKey.isEmpty || searchKey.length < 3) {
      return donarsList;
    }
    return donarsList
        .where(
          (element) => (element.pinCode.toString().contains(searchKey) ||
              element.area.toString().contains(searchKey) ||
              element.address.toString().contains(searchKey)),
        )
        .toList();
  }

  Widget buildScreen() {
    if (donarsList == null) {
      return InfoMessageTemplate(
        'Fetching',
        showLoader: true,
        subTitle: 'Getting donars list',
      );
    }
    if (donarsList.isEmpty) {
      return InfoMessageTemplate(
        'Sorry!',
        showLoader: true,
        subTitle: 'No donars found',
      );
    }
    List<RegisterModel> filteredDonars = getDonarsList();
    return Column(
      children: [
        Container(
          child: TextFieldWidget(
            placeholder: 'Search by area, picode, address...',
            onChanged: (val) {
              setState(() {
                searchKey = val;
              });
            },
            initialValue: searchKey ?? '',
          ),
        ),
        CustomSizedBox.h40,
        Expanded(
          child: ListView.separated(
            itemCount: filteredDonars.length,
            separatorBuilder: (BuildContext context, int index) {
              return CustomSizedBox.h30;
            },
            itemBuilder: (BuildContext context, int index) {
              return Neumorphic(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelWidget(
                      '${index + 1}. ${donarsList[index].fullName}',
                      size: TextSize.subTitle1,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomSizedBox.h18,
                    LabelWidget(
                      'Area: ${donarsList[index].area}',
                      size: TextSize.h5,
                    ),
                    CustomSizedBox.h12,
                    LabelWidget(
                      'Address: ${donarsList[index].address}',
                      size: TextSize.h5,
                    ),
                    CustomSizedBox.h12,
                    LabelWidget(
                      'Pic code: ${donarsList[index].pinCode}',
                      size: TextSize.h5,
                    ),
                    CustomSizedBox.h12,
                    LabelWidget(
                      'Phone: ${donarsList[index].phoneNumber}',
                      size: TextSize.h5,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    FirebaseDatabase.instance.reference().child('donars').once().then((value) {
      donarsList = [];
      value.value.forEach((key, value) {
        donarsList.add(
          RegisterModel.fromJson(
            Map.castFrom<dynamic, dynamic, String, dynamic>(value),
          ),
        );
      });
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBarWidget(
        title: 'Request',
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 32,
          horizontal: 16,
        ),
        child: buildScreen(),
      ),
    );
  }
}
