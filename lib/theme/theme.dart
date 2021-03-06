/*
 * @Author GS
 */

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:plasma_donars/constants/constants.dart';
import 'package:plasma_donars/resources/colors.dart';

class MyTheme {
  static MyTheme _instance;
  static MyTheme get instance {
    _instance ??= MyTheme();
    return _instance;
  }

  dynamic getDarkTheme() {
    if (Constants.isNeu) {
      return NeumorphicThemeData(
        accentColor: MyColors.primary,
        baseColor: MyColors.neuBackground,
        lightSource: LightSource.topLeft,
        shadowLightColorEmboss: MyColors.neuShadowLightColor,
        shadowLightColor: MyColors.neuShadowLightColor,
        shadowDarkColor: MyColors.neuShadowDarkColor,
        shadowDarkColorEmboss: MyColors.neuShadowDarkColor,
        iconTheme: IconThemeData(
          color: RawColors.blackLighter,
        ),
        depth: 4,
      );
    } else {
      return ThemeData.dark();
    }
  }

  dynamic getLightTheme() {
    if (Constants.isNeu) {
      return NeumorphicThemeData(
        accentColor: MyColors.primary,
        baseColor: MyColors.neuBackground,
        lightSource: LightSource.topLeft,
        shadowLightColorEmboss: MyColors.neuShadowLightColor,
        shadowLightColor: MyColors.neuShadowLightColor,
        shadowDarkColor: MyColors.neuShadowDarkColor,
        shadowDarkColorEmboss: MyColors.neuShadowDarkColor,
        iconTheme: IconThemeData(
          color: RawColors.blackLighter,
        ),
        depth: 4,
      );
    } else {
      return ThemeData.light();
    }
  }
}
