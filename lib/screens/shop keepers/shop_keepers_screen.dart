import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pd_project/screens/shop%20keepers/shopkeeper_detail_screen.dart';

import '../../component/background_Color.dart';
import '../../component/custom_App_bar.dart';
import '../../constants/AppColors.dart';
import '../../constants/app_image.dart';
import '../../constants/firebase_references.dart';
import '../../constants/get_user_id.dart';
import '../order_Booker/order_more_details.dart';

class ShopKeepersScreen extends StatefulWidget {
  const ShopKeepersScreen({Key? key}) : super(key: key);

  @override
  State<ShopKeepersScreen> createState() => _ShopKeepersScreenState();
}

class _ShopKeepersScreenState extends State<ShopKeepersScreen> {
  Stream<QuerySnapshot<Object?>>? currentShopKeepers() async* {
    yield* FirebaseReferences()
        .orders
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
          text: "SHOPKEEPERS",
          onPressed: () => Get.back(),
        ),
        body: Background_Image(
          images: AppImages.admin,
          childs: StreamBuilder(
            stream: currentShopKeepers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: ListView.builder(
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              width: double.infinity,
                              child: Center(
                                  child: ListTile(
                                onTap: () {
                                  Get.to(ShopkeeperDetailScreen(
                                    id: snapshot.data!.docs[index]['id'],
                                  ));
                                },
                                trailing: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: AppColors.white,
                                ),
                                title: Text(
                                  "${snapshot.data!.docs[index]['shopName']}",
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white),
                                ),
                                subtitle: Text(
                                  "${snapshot.data!.docs[index]['phone']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white),
                                ),
                              )),
                              decoration: BoxDecoration(
                                  color: AppColors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
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

  Widget Space(double? height) {
    return SizedBox(
      height: height,
    );
  }
}
