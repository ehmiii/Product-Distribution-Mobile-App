import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pd_project/constants/get_user_id.dart';

import '../../component/App_Button.dart';
import '../../component/Utils.dart';
import '../../component/background_Color.dart';
import '../../component/custom_App_bar.dart';
import '../../component/select_date.dart';
import '../../constants/AppColors.dart';
import '../../constants/app_image.dart';
import '../../constants/firebase_references.dart';
import '../order_Booker/order_more_details.dart';

class Order_Detail_Sp extends StatefulWidget {
  const Order_Detail_Sp({Key? key}) : super(key: key);

  @override
  State<Order_Detail_Sp> createState() => _Order_Detail_SpState();
}

class _Order_Detail_SpState extends State<Order_Detail_Sp> {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  String? selectedDate;
  Stream spcurrentDetail() async* {
    yield* selectedDate == null
        ? FirebaseReferences()
            .orders
            .where('status', isEqualTo: 'pending')
            .where(
              'adminId',
              isEqualTo: await GetUserId.GET_USER_ID(),
            )
            .snapshots()
        : FirebaseReferences()
            .orders
            .where('status', isEqualTo: 'pending')
            .where('orderDate', isEqualTo: selectedDate)
            .where(
              'adminId',
              isEqualTo: await GetUserId.GET_USER_ID(),
            )
            .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.appBar(
          text: "SP ORDER DETAIL",
          onPressed: () => Get.back(),
        ),
        body: Background_Image(
          images: AppImages.admin,
          childs: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: App_button(
                    onPress: () async {
                      selectedDate = await SelectDate.SELECTDATE(context);
                      print(selectedDate);
                      setState(() {});
                    },
                    tltle: selectedDate == null ? "Select Date" : selectedDate!,
                    loading: false,
                  ),
                  // child: Container(
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5),
                  //       color: AppColors.white),
                  //   height: 100,
                  //   width: double.infinity,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Row(
                  //       children: [
                  //         Expanded(
                  //           child: TextFormField(
                  //             keyboardType: TextInputType.name,
                  //             controller: startDateController,
                  //             decoration: InputDecoration(
                  //                 hintText: "02/12/2023",
                  //                 labelText: "Select Start Date"),
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 startDateController.text.toString();
                  //                 endDateController.text.toString();
                  //               });
                  //             },
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: 20,
                  //         ),
                  //         // Expanded(
                  //         //   child: TextFormField(
                  //         //     keyboardType: TextInputType.datetime,
                  //         //     controller: endDateController,
                  //         //     decoration: InputDecoration(hintText: "Day/Month/Year",labelText: "Select End Date"),
                  //         //     onChanged: (value) {
                  //         //       setState(() {
                  //         //         startDateController.text.toString();
                  //         //         endDateController.text.toString();
                  //         //       });
                  //         //     },
                  //         //   ),
                  //         // ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: spcurrentDetail(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
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
                                          Get.to(order_detail(
                                            id: snapshot.data!.docs[index]
                                                ['id'],
                                          ));
                                        },
                                        trailing: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                            onPressed: () {
                                              Utils().exit_app_dialog(
                                                context,
                                                "Do you want to delete this product",
                                                () {
                                                  FirebaseReferences()
                                                      .orders
                                                      .doc(snapshot.data!
                                                          .docs[index]['id'])
                                                      .delete();
                                                  Get.back();
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          "${snapshot.data!.docs[index]['shopName']}",
                                          style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.white),
                                        ),
                                        subtitle: Text(
                                          "${snapshot.data!.docs[index]['address']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.white),
                                        ),
                                      )),
                                      decoration: BoxDecoration(
                                          color: AppColors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                ),
              ],
            ),
          ),
        ));
  }
}
