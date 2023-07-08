import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/AppColors.dart';
import '../constants/AppTextStyle.dart';

class App_button extends StatelessWidget {
  final VoidCallback onPress;
  final String tltle;
  final bool loading;
  final Color? color;
   App_button({
    Key? key, required this.onPress, required this.tltle, required this.loading, this.color = AppColors.blue}) : super(key: key);
 Color bron = AppColors.brown;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPress,
      child: Card(
        child: Container(
          height: 70,
          width: double.infinity,
          child: Center(child: loading? Center(child: CircularProgressIndicator(color: Colors.white,)):Text(tltle,style: AppTextStyle.normalText
            (Colors: Colors.white,fontweight: FontWeight.w500,fontSize: 16),),),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 6),
                  blurRadius: 8,
                  color: Colors.black12.withOpacity(0.2))
            ],
            borderRadius: BorderRadius.circular(10),
          color: color,),
        ),
      ),
    );
  }
}

class App_button1 extends StatelessWidget {
  final VoidCallback onPress;
  final String tltle;
  final bool loading;

  const App_button1({
    Key? key, required this.onPress, required this.tltle, required this.loading,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPress,
      child: Card(
        child: Container(
          height: 45,
          width: double.infinity,
          child: Center(child: loading? Center(child: CircularProgressIndicator(color: Colors.white,)):Text(tltle,style: AppTextStyle.normalText
            (Colors: Colors.white,fontweight: FontWeight.w500,fontSize: 16),),),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 6),
                  blurRadius: 8,
                  color: Colors.black12.withOpacity(0.2))
            ],
            borderRadius: BorderRadius.circular(10),
            color: AppColors.blue,),
        ),
      ),
    );
  }
}
