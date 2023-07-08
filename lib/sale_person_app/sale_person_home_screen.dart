import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pd_project/component/CustomButton.dart';
import 'package:pd_project/component/background_Color.dart';
import 'package:pd_project/component/custom_App_bar.dart';
import 'package:pd_project/constants/app_image.dart';
import 'package:pd_project/sale_person_app/sale_person_completed_screen.dart';
import 'package:pd_project/sale_person_app/sale_person_order_detail.dart';

class SalePersonHomeScreen extends StatefulWidget {
  const SalePersonHomeScreen({Key? key}) : super(key: key);

  @override
  State<SalePersonHomeScreen> createState() => _SalePersonHomeScreenState();
}

class _SalePersonHomeScreenState extends State<SalePersonHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(
          text: "Sale Person",
          booker: false,
          context: context,
          showAppBar: true),
      body: Background_Image(
        images: AppImages.delivery,
        childs: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: "PENDING ORDER",
                Icons: Icons.shopping_cart,
                Onprees: () {
                  Get.to(SalePersonOrderDetail());
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(
                text: "DELIVERD ORDER",
                Icons: Icons.car_crash_outlined,
                Onprees: () {
                  Get.to(SalePersonCompletedScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
