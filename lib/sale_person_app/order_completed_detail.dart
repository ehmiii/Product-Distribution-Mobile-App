import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:pd_project/component/validate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/App_Button.dart';
import '../component/Input_text_field.dart';
import '../component/custom_App_bar.dart';
import '../component/reusbale_row.dart';
import '../constants/AppColors.dart';
import '../constants/firebase_references.dart';

class OrderCompletedDetail extends StatefulWidget {
  final String? id;
  const OrderCompletedDetail({Key? key, this.id}) : super(key: key);

  @override
  State<OrderCompletedDetail> createState() => _OrderCompletedDetailState();
}

class _OrderCompletedDetailState extends State<OrderCompletedDetail> {
  final key = GlobalKey<FormState>();
  // final shop_Name_Controller = TextEditingController();
  // final shopkeeper_NameController = TextEditingController();
  // final phone_Controller = TextEditingController();
  // final cnic_Controller = TextEditingController();
  // final address_Controller = TextEditingController();
  // final product_ordered_Controller = TextEditingController();
  // final price_Controller = TextEditingController();
  // final order_date_Controller = TextEditingController();
  // final delivery_date_Controller = TextEditingController();
  // final quantityController = TextEditingController();
  final payedPriceController = TextEditingController();

  // data() async {
  //   var doc = await FirebaseReferences().orders.doc(widget.id).get();
  //   shop_Name_Controller.text = doc['shopName'];
  //   shopkeeper_NameController.text = doc['shopkeeperName'];
  //   phone_Controller.text = doc['phone'];
  //   cnic_Controller.text = doc['cnic'];
  //   address_Controller.text = doc['address'];
  //   price_Controller.text = doc['price'];
  //   order_date_Controller.text = doc['orderDate'];
  //   product_ordered_Controller.text = doc['products'];
  //   payedPriceController.text = doc['pay'];
  //   delivery_date_Controller.text = doc['deliveryDate'];
  //   quantityController.text = doc['quantity'];
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   data();
  //   super.initState();
  // }

  bool loading = false;
  bool isTotalPrice = true;
  num totalPrice = 0;
  num arrears = 0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          appBar: CustomAppBar.appBar(
            text: "MORE DETAIL",
            onPressed: () => Get.back(),
          ),
          body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseReferences().orders.doc(widget.id).get(),
            builder: (context, orderDetail) {
              // print(orderDetail.data!.data());
              if (orderDetail.hasData) {
                if (isTotalPrice) {
                  for (int index = 0;
                      index < orderDetail.data!["totalProducts"].length;
                      index++) {
                    print(orderDetail.data!["totalProducts"][index]["price"]);
                    totalPrice += (num.parse(orderDetail.data!["totalProducts"]
                            [index]["price"]) *
                        num.parse(orderDetail.data!["totalProducts"][index]
                            ["quantity"]));
                  }
                  isTotalPrice = false;
                }
              }
              return orderDetail.hasData
                  ? Form(
                      key: key,
                      child: ListView(
                        // scrollDirection: Axis.vertical,
                        children: [
                          ReusbaleRow(
                            value: "Shop Name",
                            value1: orderDetail.data!["shopName"],
                          ),
                          ReusbaleRow(
                            value: "Shop Keeper Name",
                            value1: orderDetail.data!["shopkeeperName"],
                          ),
                          ReusbaleRow(
                            value: "Phone",
                            value1: orderDetail.data!["phone"],
                          ),
                          ReusbaleRow(
                            value: "CNIC",
                            value1: orderDetail.data!["cnic"],
                          ),
                          ReusbaleRow(
                            value: "Address",
                            value1: orderDetail.data!["address"],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: constraints.maxWidth * .08,
                                  child: Text(
                                    "S.NO",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * .48,
                                  child: Text(
                                    "Product",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * .17,
                                  child: Text(
                                    "Quantity",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * .20,
                                  child: Text(
                                    "Price",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          for (int index = 0;
                              index < orderDetail.data!["totalProducts"].length;
                              index++)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                child: Row(
                                  children: [
                                    Container(
                                        width: constraints.maxWidth * .07,
                                        child: Text("  ${index + 1}")),
                                    Container(
                                      width: constraints.maxWidth * .5,
                                      child: Text(
                                        "${orderDetail.data!["totalProducts"][index]["product"]}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      width: constraints.maxWidth * .15,
                                      child: Text(
                                        "${orderDetail.data!["totalProducts"][index]["quantity"]}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      width: constraints.maxWidth * .20,
                                      child: Text(
                                        "${(num.parse(orderDetail.data!["totalProducts"][index]["price"]) * num.parse(orderDetail.data!["totalProducts"][index]["quantity"])).toDouble().toPrecision(2)}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ReusbaleRow(
                            value: "Total Price",
                            value1:
                                totalPrice.toDouble().toPrecision(2).toString(),
                          ),
                          ReusbaleRow(
                            value: "Ordered Date",
                            value1: orderDetail.data!["orderDate"],
                          ),
                          ReusbaleRow(
                            value: "Delivery Date",
                            value1: orderDetail.data!["deliveryDate"],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Input_text_field1(
                              myController: payedPriceController,
                              onValidator: (value) {
                                return validatePricreNumber(value);
                              },
                              onChanged: (value) {
                                setState(() {
                                  arrears = totalPrice - num.parse(value!);
                                });
                              },
                              focusNode: null,
                              hint: "Pay",
                              lable: 'Paid',
                              keyboardType: TextInputType.name,
                              obscureTexts: false,
                              onFieldSubmittedValue: (newValue) {},
                            ),
                          ),
                          ReusbaleRow(
                            value: "Arrears ",
                            value1:
                                arrears.toDouble().toPrecision(2).toString(),
                          ),
                          App_button(
                              onPress: () async {
                                if (key.currentState!.validate()) {
                                  SharedPreferences shrf =
                                      await SharedPreferences.getInstance();
                                  String? userId = shrf.getString('userId');
                                  setState(() {
                                    loading = true;
                                  });
                                  FirebaseReferences()
                                      .orders
                                      .doc(widget.id)
                                      .update({
                                    'shopName': orderDetail.data!["shopName"],
                                    'shopkeeperName':
                                        orderDetail.data!["shopkeeperName"],
                                    'phone': orderDetail.data!["phone"],
                                    'cnic': orderDetail.data!["cnic"],
                                    'address': orderDetail.data!["address"],
                                    'totalProducts':
                                        orderDetail.data!["totalProducts"],
                                    'pay': payedPriceController.text,
                                    'orderDate': orderDetail.data!["orderDate"],
                                    'deliveryDate':
                                        DateFormat.yMd().format(DateTime.now()),
                                    'status': 'completed',
                                    'completedBy': userId,
                                    'arrears': arrears,
                                  }).then((value) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Get.back();
                                  });
                                }
                              },
                              tltle: "COMPLETE ORDER",
                              color: Colors.green,
                              loading: loading),
                          Space(10),
                          App_button(
                              onPress: () {
                                Get.back();
                              },
                              tltle: "BACK",
                              loading: false),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
            },
          )
          // body: Form(
          //   key: key,
          //   child: SingleChildScrollView(
          //     child: Padding(
          //       padding: const EdgeInsets.all(10),
          //       child: Column(
          //         children: [

          //           Space(30),
          //           ReusbaleRow(value: "Shop Name",iconData: Icons.person,onPress: () {},value1:shop_Name_Controller.text ),
          //           Space(20),
          //           ReusbaleRow(value: "Shopkeeper Name",iconData: Icons.person,onPress: () {},value1:shopkeeper_NameController.text ),
          //           Space(20),
          //           ReusbaleRow(value: "Phone ",iconData: Icons.phone,onPress: () {},value1:phone_Controller.text ),
          //           Space(20),
          //           ReusbaleRow(value: "CNIC",iconData: Icons.perm_contact_cal,onPress: () {},value1:cnic_Controller.text ),
          //           Space(20),
          //           ReusbaleRow(value: "Address",iconData: Icons.maps_home_work,onPress: () {},value1:address_Controller.text ),
          //           Space(20),
          //           ListTile(
          //             leading:Icon(Icons.production_quantity_limits),
          //             title:Text("Product :  ${product_ordered_Controller.text}",
          //                 style:TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),),
          //           Space(20),
          //           ReusbaleRow(value: "Price",iconData: Icons.price_check,onPress: () {},value1:price_Controller.text ),
          //           Space(20),
          //           ReusbaleRow(value: "Order Date",iconData: Icons.date_range,onPress: () {},value1:order_date_Controller.text ),
          //           Space(30),
          //           ReusbaleRow(value: "Delivery Date",iconData: Icons.date_range,onPress: () {},value1:delivery_date_Controller.text ),
          //           Space(20),
          //           ReusbaleRow(value: "Quantity",iconData: Icons.production_quantity_limits,onPress: () {},value1:quantityController.text ),
          //           Space(10),
          //           Input_text_field1(
          //             myController: payedPriceController,
          //             onValidator: (value) {
          //           return validatePricreNumber(value);
          //             },
          //             focusNode: null,
          //             hint: "Pay",
          //             lable: 'pay',
          //             keyboardType: TextInputType.name,
          //             obscureTexts: false,
          //             onFieldSubmittedValue: (newValue) {},
          //           ),
          //           Space(30),
          //           App_button(
          //               onPress: () async {
          //                if(key.currentState!.validate()){
          //                  SharedPreferences shrf = await SharedPreferences.getInstance();
          //                  String? userId = shrf.getString('userId');
          //                  setState(() {
          //                    loading = true;
          //                  });
          //                  FirebaseReferences().orders.doc(widget.id).update({
          //                    'shopName' : shop_Name_Controller.text,
          //                    'shopkeeperName' : shopkeeper_NameController.text,
          //                    'phone' : phone_Controller.text,
          //                    'cnic' : cnic_Controller.text,
          //                    'address' : address_Controller.text,
          //                    'products' : product_ordered_Controller.text,
          //                    'price' : price_Controller.text,
          //                    'pay' : payedPriceController.text,
          //                    'orderDate' :  order_date_Controller.text,
          //                    'status' : 'completed',
          //                    'completedBy' : userId
          //                  }).then((value) {
          //                    setState(() {
          //                      loading = false;
          //                    });
          //                    Get.back();
          //                  });
          //                }
          //               },
          //               tltle: "COMPLETE ORDER",
          //               color: Colors.green,
          //               loading: loading),
          //           Space(10),
          //           App_button(
          //               onPress: () {
          //                 Get.back();
          //               },
          //               tltle: "BACK",
          //               loading: false),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          );
    });
  }

  Widget Space(double? height) {
    return SizedBox(
      height: height,
    );
  }
}
