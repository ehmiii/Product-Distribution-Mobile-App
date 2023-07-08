// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pd_project/constants/AppColors.dart';
import 'package:pd_project/constants/AppTextStyle.dart';
import 'package:pd_project/constants/app_image.dart';
import 'package:pd_project/screens/products_Detail/product_Deails.dart';
import 'package:pd_project/screens/sale_Person/sale_Person.dart';
import 'package:pd_project/screens/shop%20keepers/shop_keepers_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/CustomButton.dart';
import '../component/background_Color.dart';
import '../services/authentication/Login_Screen.dart';
import 'order_Booker/order_Booker.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Logout"),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text("Cancel"),
                ),
              ];
            }, onSelected: (value) async {
              SharedPreferences shrf = await SharedPreferences.getInstance();
              if (value == 2) {
              } else if (value == 1) {
                shrf.clear();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return Login_Screen();
                  },
                ), (route) => false);
              } else if (value == 2) {}
            }),
          )
        ],
        title: Text(
          "WELCOME TO PDA",
          style: AppTextStyle.normalText(
              Colors: AppColors.white,
              fontSize: 26,
              fontweight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.blue,
      ),
      body: Background_Image(
        images: AppImages.admin,
        childs: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: "Order Booker",
                Icons: Icons.edit,
                Onprees: () {
                  Get.to(Order_Booker());
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                Onprees: () {
                  Get.to(Sale_Person());
                },
                text: "Sale Person",
                Icons: Icons.delivery_dining,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                Onprees: () {
                  Get.to(Product_Details());
                },
                text: "Product Detail",
                Icons: Icons.date_range,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                Onprees: () {
                  Get.to(ShopKeepersScreen());
                },
                text: "Shopkeepers",
                Icons: Icons.person,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
