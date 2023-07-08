import 'package:flutter/material.dart';

import '../constants/AppColors.dart';


class ProductDetailCard extends StatelessWidget {
 final String? text;
 final IconData? icon;
  const ProductDetailCard({Key? key, this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(height: 80,width: double.infinity,
      child: Card(child: Padding(
          padding: const EdgeInsets.all(3),
          child: ListTile(leading: CircleAvatar(
              backgroundColor: AppColors.white,
              child: Icon(icon,size: 30,)),title: Text(text.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),)
      )),);
  }
}
