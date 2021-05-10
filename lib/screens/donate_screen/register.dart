import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plasma_donars/common_widgets/app_bar_widget.dart';
import 'package:plasma_donars/common_widgets/button_loader_controller.dart';
import 'package:plasma_donars/common_widgets/button_widget.dart';
import 'package:plasma_donars/common_widgets/scaffold/my_scaffold.dart';
import 'package:plasma_donars/common_widgets/textfield_widget.dart';
import 'package:plasma_donars/models/register_model.dart';
import 'package:plasma_donars/navigator/navigator.dart';
import 'package:plasma_donars/simplifiers/sized_box.dart';

GlobalKey<FormState> formKey = GlobalKey();

class RegisterPlasma extends StatefulWidget {
  static const String route = '/register';

  @override
  _RegisterPlasmaState createState() => _RegisterPlasmaState();
}

class _RegisterPlasmaState extends State<RegisterPlasma> {
  RegisterModel registerModel = RegisterModel();
  ButtonLoadingAnimationController buttonLoadingAnimationController =
      ButtonLoadingAnimationController();
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBarWidget(
        title: 'Register',
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    cacheExtent: 1000,
                    children: [
                      TextFieldWidget(
                        hintText: 'Full Name *',
                        placeholder: 'ex: John Doe',
                        onChanged: (val) {
                          registerModel.fullName = val;
                        },
                        initialValue: registerModel.fullName,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter valid full name';
                          }
                          return null;
                        },
                      ),
                      CustomSizedBox.h30,
                      TextFieldWidget(
                        hintText: 'Area *',
                        placeholder: 'ex: Ashoka nagar',
                        onChanged: (val) {
                          registerModel.area = val;
                        },
                        initialValue: registerModel.area,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter valid area name';
                          }
                          return null;
                        },
                      ),
                      CustomSizedBox.h30,
                      TextFieldWidget(
                        hintText: 'Address',
                        placeholder: 'ex: 1st main, 3rd cross....',
                        numberOfLine: 4,
                        onChanged: (val) {
                          registerModel.address = val;
                        },
                        initialValue: registerModel.address,
                        validator: (val) {
                          if (val.length > 0 && val.length < 10) {
                            return 'Enter valid address or don\'t give';
                          }
                          return null;
                        },
                      ),
                      CustomSizedBox.h30,
                      TextFieldWidget(
                        hintText: 'Aadhar Number *',
                        placeholder: 'ex: 123412341234',
                        maxLength: 12,
                        textInputType: TextInputType.number,
                        onChanged: (val) {
                          registerModel.aadharNumber = int.parse(val);
                        },
                        initialValue: registerModel.aadharNumber?.toString(),
                        validator: (val) {
                          if (val.isEmpty || val.length < 12) {
                            return 'Enter valid aadhar number';
                          }
                          return null;
                        },
                      ),
                      CustomSizedBox.h30,
                      TextFieldWidget(
                        hintText: 'Pincode *',
                        placeholder: 'ex: 572101',
                        maxLength: 6,
                        textInputType: TextInputType.number,
                        onChanged: (val) {
                          if (val.isEmpty) return;
                          registerModel.pinCode = int.parse(val);
                        },
                        initialValue: registerModel.pinCode?.toString(),
                        validator: (val) {
                          if (val.isEmpty || val.length < 6) {
                            return 'Enter valid pincode';
                          }
                          return null;
                        },
                      ),
                      CustomSizedBox.h30,
                      TextFieldWidget(
                        hintText: 'Phone Number *',
                        placeholder: 'ex: 9999999999',
                        maxLength: 10,
                        textInputType: TextInputType.phone,
                        onChanged: (val) {
                          if (val.isEmpty) return;
                          registerModel.phoneNumber = int.parse(val);
                        },
                        initialValue: registerModel.phoneNumber?.toString(),
                        validator: (val) {
                          if (val.isEmpty || val.length < 10) {
                            return 'Enter valid phone number';
                          }
                          return null;
                        },
                      ),
                      CustomSizedBox.h30,
                      TextFieldWidget(
                        hintText: 'Number of days since infected *',
                        placeholder: 'ex: 5',
                        onChanged: (val) {
                          if (val.isEmpty) return;
                          registerModel.numberOfDays = int.parse(val);
                        },
                        initialValue: registerModel.numberOfDays?.toString(),
                        textInputType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Enter valid number of days';
                          }
                          return null;
                        },
                      ),
                      CustomSizedBox.h30,
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  child: ButtonWidget(
                    title: 'Register',
                    controller: buttonLoadingAnimationController,
                    onPressed: () async {
                      FocusManager.instance.primaryFocus.unfocus();
                      if (formKey.currentState.validate()) {
                        buttonLoadingAnimationController
                            .startLoadingAnimation();
                        await FirebaseDatabase.instance
                            .reference()
                            .child('donars')
                            .child(DateTime.now()
                                .microsecondsSinceEpoch
                                .toString())
                            .set(
                              registerModel.toJson(),
                            );
                        buttonLoadingAnimationController.stopLoadingAnimation();
                        Fluttertoast.showToast(
                          msg: 'Registration successfully',
                        );
                        NavigationService.instance.pop(context);
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Please fill all the data and check for errors',
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
