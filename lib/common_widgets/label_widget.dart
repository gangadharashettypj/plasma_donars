/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:plasma_donars/resources/colors.dart';

class LabelWidget extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final EdgeInsets padding;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  LabelWidget(
    this.text, {
    this.size,
    this.color,
    this.padding,
    this.fontWeight,
    this.textAlign,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          color: color ?? MyColors.textColor,
          fontWeight: fontWeight ?? FontWeight.w400,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
