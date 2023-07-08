import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pd_project/orderbookerApp/order_booker_order_details_screen.dart';
import 'package:pd_project/orderbookerApp/product_detail_image_view_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/Utils.dart';
import '../component/background_Color.dart';
import '../component/custom_App_bar.dart';
import '../constants/AppColors.dart';
import '../constants/app_image.dart';
import '../constants/firebase_references.dart';
import '../screens/products_Detail/add_Product.dart';

class OrderBookerSelectProducts extends StatefulWidget {
  const OrderBookerSelectProducts({Key? key}) : super(key: key);

  @override
  State<OrderBookerSelectProducts> createState() =>
      _OrderBookerSelectProductsState();
}

class _OrderBookerSelectProductsState extends State<OrderBookerSelectProducts> {
  List selectedProducts = [];
  List selectedProductsPrice = [];
  List selectedQuantity = [];
  List<Map<String, dynamic>> selectedProductDetail = [];
  List<int> selectedProductsIndex = [];
  final quantityController = TextEditingController();
  var productsList;
  num total = 0;
  Stream<QuerySnapshot<Object?>>? currentProducts() async* {
    final shr = await SharedPreferences.getInstance();
    final availableProduct = shr.getString('adminId');
    yield* FirebaseReferences()
        .products
        .where(
          'adminId',
          isEqualTo: availableProduct,
        )
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoButton(
        onPressed: () {
          // List<Map<String, dynamic>> totalProducts = [];
          // for (var i in selectedProductsPrice) {
          //   num value = num.parse(i);
          //   total += value;
          // }
          // for (var index in selectedProductsIndex) {
          //   totalProducts.add({
          //     'product': productsList[index]['product'],
          //     'price': productsList[index]['price'],
          //   });
          // }
          Get.to(OrderBookerOrderDetailsScreen(
            selectedProd: selectedProducts,
            totalSelectedProducts: selectedProductDetail,
            // totalPrice: total,
          ));
          selectedProductDetail = [];
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
                Icons.check_circle,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "SUBMIT",
                style: TextStyle(fontSize: 30, color: AppColors.white),
              ),
            ],
          )),
          color: AppColors.blue,
        ),
      ),
      appBar: CustomAppBar.appBar(
        text: "PRODUCT DETAIL",
        onPressed: () => Get.back(),
      ),
      body: Background_Image(
        images: AppImages.ordernow,
        childs: StreamBuilder<QuerySnapshot>(
          stream: currentProducts(),
          builder: (context, snapshot) {
            // print(snapshot.data!.docs.length);
            if (snapshot.hasData) {
              productsList = snapshot.data!.docs;
              return Container(
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: snapshot.data!.size,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 220,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15),
                  itemBuilder: (context, index) {
                    final product = selectedProductDetail.firstWhereOrNull(
                        (element) =>
                            element['product'] ==
                            snapshot.data!.docs[index]['product']);
                    return GestureDetector(
                      onTap: () {
                        Get.to(ProductDetailImageViewScreen(
                          imageurl: snapshot.data!.docs[index]['imageurl'],
                        ));
                      },
                      onDoubleTap: () {
                        // final value = selectedProductDetail.firstWhere(
                        //     (product) =>
                        //         product['product'] ==
                        //         snapshot.data!.docs[index]['product']);
                        quantityController.text = product?['quantity'] ?? "";
                        if (product != null) {
                          selectedProducts
                              .remove(snapshot.data!.docs[index]['product']);
                          selectedProductsPrice
                              .remove(snapshot.data!.docs[index]['price']);
                          selectedProductsIndex.remove(index);
                          selectedProductDetail.removeWhere((product) =>
                              product['product'] ==
                              snapshot.data!.docs[index]['product']);
                        } else {
                          selectedProducts
                              .add(snapshot.data!.docs[index]['product']);
                          selectedProductsPrice
                              .add(snapshot.data!.docs[index]['price']);
                          selectedProductsIndex.add(index);
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              // backgroundColor: Colors.transparent,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: quantityController,
                                      decoration: InputDecoration(
                                        labelText: "Quantity",
                                        hintText: "Enter Quantity",
                                        suffix: GestureDetector(
                                          onTap: () {
                                            if (quantityController
                                                    .text.isEmpty ||
                                                quantityController.text
                                                    .toLowerCase()
                                                    .contains(
                                                      RegExp("[a-z]"),
                                                    ) ||
                                                quantityController.text
                                                    .toLowerCase()
                                                    .contains(
                                                      RegExp(
                                                          r'[!@#$%^&*(),.?":{}|<>]'),
                                                    )) {
                                              Utils().flushBarMessage(
                                                "Enter quantity in number",
                                                Icons.info,
                                              );
                                            } else {
                                              selectedQuantity.add(int.parse(
                                                  quantityController.text));
                                              Get.back();
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.check,
                                              // color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      quantityController.text = "";
                                      Get.back();
                                    },
                                    child: Text("Close"),
                                  ),
                                ],
                              ),
                            ),
                            barrierDismissible: false,
                          ).then(
                            (value) {
                              if (quantityController.text.isNotEmpty) {
                                selectedProductDetail.add(
                                  {
                                    'product': snapshot.data!.docs[index]
                                        ['product'],
                                    'price': snapshot.data!.docs[index]
                                        ['price'],
                                    'quantity': quantityController.text,
                                  },
                                );
                              }
                              setState(() {});
                            },
                          );
                        }
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white,
                                ),
                                child: Image.network(
                                  "${snapshot.data!.docs[index]['imageurl'][0]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${snapshot.data!.docs[index]['product']}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Text(
                                "Rs : ${snapshot.data!.docs[index]['price']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              product != null ? Colors.green : AppColors.blue,
                        ),
                      ),
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
    );
  }
}
