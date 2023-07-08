import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/AppColors.dart';
import '../constants/AppTextStyle.dart';

class Utils {
  Future<bool> exit_app_dialog(
      BuildContext context, String message, VoidCallback onPressed) async {
    bool? exitapp = await showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Column(
          children: [
            Text("Are you sure?"),
          ],
        ),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
              child: Text(
                "CONFIRM",
                style: AppTextStyle.normalText(Colors: AppColors.blue),
              ),
              onPressed: onPressed),
          CupertinoDialogAction(
              child: Text("CANCEL",
                  style: AppTextStyle.normalText(Colors: AppColors.alertColor)),
              onPressed: () {
                Navigator.of(context).pop(false);
              }),
        ],
      ),
    );
    return exitapp ?? false;
  }

  flushBarMessage(String message, IconData icon) {
    Get.closeAllSnackbars();
    return Get.snackbar('Message', message,
        backgroundColor: Colors.black54,
        icon: Icon(
          icon,
          color: Colors.blue,
        ),
        colorText: Colors.white);
  }

  defaultDialog(VoidCallback onPressed, String text) {
    return Get.defaultDialog(
        title: "Are you sure",
        content: Column(
          children: [Text(text)],
        ),
        actions: [
          TextButton(onPressed: onPressed, child: Text("Confirm")),
          TextButton(onPressed: () => Get.back(), child: Text("cancel")),
        ]);
  }

  static void focusField(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
