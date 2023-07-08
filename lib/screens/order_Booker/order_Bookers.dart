import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pd_project/component/Utils.dart';
import 'package:pd_project/constants/AppColors.dart';
import 'package:pd_project/constants/firebase_references.dart';
import 'package:pd_project/constants/get_user_id.dart';
import 'package:pd_project/screens/order_Booker/edit_order_booker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component/background_Color.dart';
import '../../component/custom_App_bar.dart';
import '../../constants/app_image.dart';
import 'add_Booker.dart';

class Order_Bookers extends StatefulWidget {
  const Order_Bookers({Key? key}) : super(key: key);

  @override
  State<Order_Bookers> createState() => _Order_BookersState();
}

class _Order_BookersState extends State<Order_Bookers> {
  Stream<QuerySnapshot<Object?>>? currentOrderBookers() async* {
    yield* FirebaseReferences()
        .order_bookersReference
        .where(
          "adminId",
          isEqualTo: await GetUserId.GET_USER_ID(),
        )
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.appBar(
          text: "ORDER BOOKERS",
          onPressed: () => Get.back(),
        ),
        bottomNavigationBar: CupertinoButton(
          onPressed: () {
            Get.to(Add_Booker());
          },
          padding: EdgeInsets.zero,
          child: Container(
            height: 70,
            width: double.infinity,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 50,
                    color: Colors.white,
                  ),
                  Text(
                    "Add More",
                    style: TextStyle(fontSize: 30, color: AppColors.white),
                  ),
                ],
              ),
            ),
            color: AppColors.blue,
          ),
        ),
        body: Background_Image(
          images: AppImages.admin,
          childs: StreamBuilder<QuerySnapshot>(
            stream: currentOrderBookers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        child: Center(
                            child: ListTile(
                          onTap: () {
                            Get.to(() => EditOrderBooker(
                                  id: snapshot.data!.docs[index]['id'],
                                ));
                          },
                          title: Text(
                            "${snapshot.data!.docs[index]['name']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: Icon(
                              Icons.person,
                              size: 40,
                            ),
                          ),
                          subtitle: Text(
                              "Phone :${snapshot.data!.docs[index]['phone']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          trailing: InkWell(
                              onTap: () {
                                Utils().exit_app_dialog(context,
                                    'Do yo want to delete the OrderBooker', () {
                                  FirebaseReferences()
                                      .order_bookersReference
                                      .doc(snapshot.data!.docs[index]['id'])
                                      .delete();
                                  Get.back();
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                child: Icon(
                                  Icons.delete,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              )),
                        )),
                        decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
