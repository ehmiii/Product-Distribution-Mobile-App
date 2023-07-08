import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../component/App_Button.dart';
import '../component/Input_text_field.dart';
import '../component/Utils.dart';
import '../component/custom_App_bar.dart';
import '../component/product_detail_card.dart';
import '../constants/AppColors.dart';
import '../constants/firebase_references.dart';

class SalePersonOrderDetailScreen extends StatefulWidget {
  final String? id;

  const SalePersonOrderDetailScreen({Key? key, this.id}) : super(key: key);

  @override
  State<SalePersonOrderDetailScreen> createState() =>
      _SalePersonOrderDetailScreenState();
}

class _SalePersonOrderDetailScreenState
    extends State<SalePersonOrderDetailScreen> {
  final key = GlobalKey<FormState>();
  final shop_Name_Controller = TextEditingController();
  final shopkeeper_NameController = TextEditingController();
  final phone_Controller = TextEditingController();
  final cnic_Controller = TextEditingController();
  final address_Controller = TextEditingController();
  final product_ordered_Controller = TextEditingController();
  final price_Controller = TextEditingController();
  final order_date_Controller = TextEditingController();
  final delivery_date_Controller = TextEditingController();
  final payedPriceController = TextEditingController();

  @override
  void initState() {
    data();
    super.initState();
  }

  data() async {
    var doc = await FirebaseReferences().orders.doc(widget.id).get();
    shop_Name_Controller.text = doc['shopName'];
    shopkeeper_NameController.text = doc['shopkeeperName'];
    phone_Controller.text = doc['phone'];
    cnic_Controller.text = doc['cnic'];
    address_Controller.text = doc['address'];
    price_Controller.text = doc['prince'];
    order_date_Controller.text = doc['orderDate'];
    product_ordered_Controller.text = doc['products'];
    setState(() {});
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(
        text: "MORE DETAIL",
        onPressed: () => Get.back(),
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // Text("MORE DETAIL",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: AppColors.brown),),
                Space(30),
                Input_text_field(
                  myController: shop_Name_Controller,
                  onValidator: (value) {
                    if (shop_Name_Controller.text == null ||
                        shop_Name_Controller.text.isEmpty) {
                      return "Shop name is Empty";
                    }
                  },
                  focusNode: null,
                  hint: "Shop name",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field(
                  myController: shopkeeper_NameController,
                  onValidator: (value) {
                    if (shopkeeper_NameController.text == null ||
                        shopkeeper_NameController.text.isEmpty) {
                      return "Shopkeeper is Empty";
                    }
                  },
                  focusNode: null,
                  hint: "Shopkeeper Age",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field(
                  myController: phone_Controller,
                  onValidator: (value) {
                    if (phone_Controller.text == null ||
                        phone_Controller.text.isEmpty) {
                      return "Phone is Empty";
                    }
                  },
                  focusNode: null,
                  hint: "Phone Number",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field(
                  myController: cnic_Controller,
                  onValidator: (value) {
                    if (cnic_Controller.text == null ||
                        cnic_Controller.text.isEmpty) {
                      return "Cnic is Empty";
                    }
                  },
                  focusNode: null,
                  hint: "CNIC",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field(
                  myController: address_Controller,
                  onValidator: (value) {
                    if (address_Controller.text == null ||
                        address_Controller.text.isEmpty) {
                      return "Address is Empty";
                    }
                  },
                  focusNode: null,
                  hint: "Address",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                TextFormField(
                  validator: (value) {
                    if (product_ordered_Controller.text == null ||
                        product_ordered_Controller.text.isEmpty) {
                      return "Product is Empty";
                    }
                  },
                  controller: product_ordered_Controller,
                  cursorHeight: 30,
                  cursorColor: AppColors.orange,
                  minLines: 3,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Product ordered",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(width: 1, color: AppColors.orange),
                    ),
                  ),
                ),
                Space(20),
                Input_text_field(
                  myController: price_Controller,
                  onValidator: (value) {
                    if (price_Controller.text == null ||
                        price_Controller.text.isEmpty) {
                      return "Price is Empty";
                    }
                  },
                  focusNode: null,
                  hint: "Price",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field(
                  myController: payedPriceController,
                  onValidator: (value) {
                    if (price_Controller.text == null ||
                        price_Controller.text.isEmpty) {
                      return "Payed is Empty";
                    }
                  },
                  focusNode: null,
                  hint: "Pay",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field(
                  myController: order_date_Controller,
                  onValidator: (value) {
                    if (order_date_Controller.text == null ||
                        order_date_Controller.text.isEmpty) {
                      return "Order date is Empty";
                    }
                  },
                  focusNode: null,
                  hint: "Order date",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field(
                  myController: delivery_date_Controller,
                  onValidator: (value) {
                    if (delivery_date_Controller.text == null ||
                        delivery_date_Controller.text.isEmpty) {
                      return "Delivery is Empty";
                    }
                  },
                  focusNode: null,
                  hint: "Delivery Data",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(40),
                App_button(
                    onPress: () {
                      if (key.currentState!.validate()) {
                        FirebaseReferences().orders.doc(widget.id).update({
                          'shopName': shop_Name_Controller.text,
                          'shopkeeperName': shopkeeper_NameController.text,
                          'phone': phone_Controller.text,
                          'cnic': cnic_Controller.text,
                          'address': address_Controller.text,
                          'products': product_ordered_Controller.text,
                          'prince': price_Controller.text,
                          'orderDate': order_date_Controller.text,
                          'deliveryDate': delivery_date_Controller.text,
                          'status': 'completed',
                          'pay': payedPriceController.text,
                        }).then((value) {
                          Get.back();
                        });
                      }
                    },
                    tltle: "COMPLETE",
                    loading: false),
                Space(20),
                App_button(
                    onPress: () {
                      Get.back();
                    },
                    tltle: "BACK",
                    loading: false),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Space(double? height) {
    return SizedBox(
      height: height,
    );
  }
}
