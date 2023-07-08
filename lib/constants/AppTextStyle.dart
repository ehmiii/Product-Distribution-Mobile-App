import 'package:flutter/material.dart';

class AppTextStyle{

  static  TextStyle normalText({double  fontSize = 14,Color? Colors = Colors.black,FontWeight fontweight
  = FontWeight.normal,FontStyle? fontstyle}) =>
      TextStyle(fontSize: fontSize,color: Colors,fontWeight: fontweight,fontStyle: fontstyle);
}