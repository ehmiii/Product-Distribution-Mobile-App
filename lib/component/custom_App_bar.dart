import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pd_project/orderbookerApp/order_booker_profile_screen.dart';
import 'package:pd_project/sale_person_app/sale_person_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/AppColors.dart';
import '../services/authentication/Login_Screen.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

SampleItem? selectedMenu;

class CustomAppBar {
  static AppBar appBar(
      {String? text,
      VoidCallback? onPressed,
      bool booker = true,
      BuildContext? context,
      bool showAppBar = false}) {
    return AppBar(
      leading: onPressed == null
          ? null
          : GestureDetector(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.black,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
      actions: [
        showAppBar
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: PopupMenuButton(
                    color: Colors.white,
                    icon: Icon(Icons.menu),
                    // add icon, by default "3 dot" icon
                    // icon: Icon(Icons.book)
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text(
                            "Profile",
                            style: TextStyle(
                              color: Color.fromRGBO(10, 18, 88, 0.969),
                            ),
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              color: Color.fromRGBO(10, 18, 88, 0.969),
                            ),
                          ),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Color.fromRGBO(10, 18, 88, 0.969),
                            ),
                          ),
                        ),
                      ];
                    },
                    onSelected: (value) async {
                      SharedPreferences shrf =
                          await SharedPreferences.getInstance();
                      if (value == 0) {
                        booker
                            ? Get.to(() => ProfileScreen())
                            : Get.to(() => SalePersonProfileScreen());
                      } else if (value == 1) {
                        shrf.clear();
                        Navigator.pushAndRemoveUntil(context!,
                            MaterialPageRoute(
                          builder: (context) {
                            return Login_Screen();
                          },
                        ), (route) => false);
                      } else if (value == 2) {}
                    }),
              )
            : Container()
      ],
      centerTitle: true,
      backgroundColor: AppColors.blue,
      title: Text(
        text.toString(),
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 27, color: AppColors.white),
      ),
    );
  }
}
