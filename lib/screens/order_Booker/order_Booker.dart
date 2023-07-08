import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../component/CustomButton.dart';
import '../../component/background_Color.dart';
import '../../component/custom_App_bar.dart';
import '../../constants/AppColors.dart';
import '../../constants/AppTextStyle.dart';
import '../../constants/app_image.dart';
import 'history_Screen.dart';
import 'order_Bookers.dart';
import 'order_detail.dart';

class Order_Booker extends StatefulWidget {
  const Order_Booker({Key? key}) : super(key: key);

  @override
  State<Order_Booker> createState() => _Order_BookerState();
}

class _Order_BookerState extends State<Order_Booker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(
        text: "ORDER BOOKER",
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
                text: "Order Bookers",
                Icons: Icons.edit,
                Onprees: () {
                  Get.to(Order_Bookers());
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                Onprees: () {
                  Get.to(Order_Detail());
                },
                text: "Order Detail",
                Icons: Icons.delivery_dining,
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // CustomButton(
              //   Onprees: () {
              //     Get.to(History_Screen());
              //   },
              //   text: "History",
              //   Icons: Icons.date_range,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
