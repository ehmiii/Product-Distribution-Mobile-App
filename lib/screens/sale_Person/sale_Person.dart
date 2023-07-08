import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pd_project/screens/sale_Person/order_Detail.dart';
import 'package:pd_project/screens/sale_Person/sales_Person.dart';

import '../../component/CustomButton.dart';
import '../../component/background_Color.dart';
import '../../component/custom_App_bar.dart';
import '../../constants/AppColors.dart';
import '../../constants/AppTextStyle.dart';
import '../../constants/app_image.dart';
import '../order_Booker/order_Bookers.dart';
import 'history_Screen.dart';

class Sale_Person extends StatefulWidget {
  const Sale_Person({Key? key}) : super(key: key);

  @override
  State<Sale_Person> createState() => _Sale_PersonState();
}

class _Sale_PersonState extends State<Sale_Person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(
        text: "SALE PERSON",
        onPressed: () => Get.back(),
      ),
      body: Background_Image(
        images: AppImages.admin,
        childs: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: "Sale Persons",
                Icons: Icons.edit,
                Onprees: () {
                  Get.to(Sales_Person());
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                Onprees: () {
                  Get.to(Order_Detail_Sp());
                },
                text: "Order Detail",
                Icons: Icons.delivery_dining,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                Onprees: () {
                  Get.to(history_Screen_Sp());
                },
                text: "History",
                Icons: Icons.date_range,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
