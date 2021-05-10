/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:plasma_donars/common_widgets/label_widget.dart';
import 'package:plasma_donars/resources/images.dart';
import 'package:plasma_donars/theme/sizes.dart';

class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(MyImages.noInternet),
        Column(
          children: [
            LabelWidget(
              'No Internet Connection!',
              size: TextSize.h3,
            ),
            LabelWidget(
              'Please turn on mobile data',
              size: TextSize.h3,
            ),
          ],
        ),
      ],
    );
  }
}
