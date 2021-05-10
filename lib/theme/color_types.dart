/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:plasma_donars/resources/colors.dart';

abstract class ColorTypes {
  static Color get primary => MyColors.primary;
  static Color get error => Colors.red;
  static Color get info => Colors.yellow;
  static Color get plain => Colors.transparent;
  static Color get disabled => RawColors.greyLight;
}
