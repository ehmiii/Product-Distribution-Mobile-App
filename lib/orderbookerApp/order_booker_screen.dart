import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pd_project/component/background_Color.dart';
import 'package:pd_project/constants/app_image.dart';
import 'package:pd_project/orderbookerApp/order_booker_order_details.dart';
import 'package:pd_project/orderbookerApp/order_booker_order_details_screen.dart';
import 'package:pd_project/orderbookerApp/order_booker_orders_history.dart';
import 'package:pd_project/orderbookerApp/order_booker_select_products.dart';
import 'package:pd_project/screens/order_Booker/history_Screen.dart';

import '../component/CustomButton.dart';
import '../component/custom_App_bar.dart';
import '../screens/order_Booker/order_detail.dart';
import '../screens/products_Detail/product_Deails.dart';

class OrderBookerScreen extends StatefulWidget {
  const OrderBookerScreen({Key? key}) : super(key: key);

  @override
  State<OrderBookerScreen> createState() => _OrderBookerScreenState();
}

class _OrderBookerScreenState extends State<OrderBookerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(text: "ORDER BOOKER",context: context,showAppBar: true),
      body:Background_Image(
        images: AppImages.ordernow,
        childs: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                   CustomButton(
                text: "Product Detail",
                Icons: Icons.date_range,
                Onprees: () {
                  Get.to(OrderBookerSelectProducts());
                },
              ),
                   SizedBox(height: 30,),
                   CustomButton(
                text: "Order Detail",
                Icons: Icons.shopping_cart,
                Onprees: () {
                  Get.to(OrderBookerOrderDetails());
                },
              ),
                   SizedBox(height: 30,),
                   CustomButton(
                    text: "History",
                    Icons: Icons.message_rounded,
                    Onprees: () {
                      Get.to(OrderBookerOrdersHistory());
                    },
                  ),



            ]),
          ),
      ),

    );
  }
}
