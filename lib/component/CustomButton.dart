import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/AppColors.dart';
import '../constants/AppTextStyle.dart';

class CustomButton extends StatefulWidget {
  final String? text;
  final IconData? Icons;
  final VoidCallback? Onprees;
  const CustomButton({Key? key, this.text,this.Icons, this.Onprees}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: widget.Onprees,
        child: Container(height: 100,width: double.infinity,
          decoration: BoxDecoration(color: AppColors.blue,borderRadius: BorderRadius.circular(60),),
          child: Row(
            children: [
            SizedBox(width: 30,),
            Icon(widget.Icons,size: 55,color: Colors.white,),
            SizedBox(width: 15,),
            Text(widget.text.toString(),style: AppTextStyle.normalText(fontSize: 28,Colors: Colors.white,fontweight: FontWeight.bold),)
          ],),),
      ),
    );
  }
}
