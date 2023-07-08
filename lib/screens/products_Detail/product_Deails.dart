import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pd_project/constants/AppColors.dart';
import 'package:pd_project/constants/get_user_id.dart';
import 'package:pd_project/screens/products_Detail/product_view_screen.dart';
import '../../component/Utils.dart';
import '../../component/background_Color.dart';
import '../../component/custom_App_bar.dart';
import '../../constants/app_image.dart';
import '../../constants/firebase_references.dart';
import '../../orderbookerApp/order_booker_order_details_screen.dart';
import 'add_Product.dart';

class Product_Details extends StatefulWidget {
  const Product_Details({Key? key}) : super(key: key);

  @override
  State<Product_Details> createState() => _Product_DetailsState();
}

class _Product_DetailsState extends State<Product_Details> {
  List<String> imageUrls = [];

  Future<void> _getImageUrls() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('images').get();
    setState(() {
      imageUrls = snapshot.docs
          .map((doc) => doc.get('imageUrl'))
          .cast<String>()
          .toList();
    });
  }

  @override
  void initState() {
    _getImageUrls();
    super.initState();
  }

  Stream<QuerySnapshot<Object?>>? currentProducts() async* {
    yield* FirebaseReferences()
        .products
        .where(
          'adminId',
          isEqualTo: await GetUserId.GET_USER_ID(),
        )
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CupertinoButton(
          onPressed: () {
            Get.to(Add_Product());
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
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "ADD",
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
          images: AppImages.admin,
          childs: StreamBuilder<QuerySnapshot>(
            stream: currentProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
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
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(Product_View_Screen(
                                  imageurl: snapshot.data!.docs[index]
                                      ['imageurl']));
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.white,
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
                                        Text(
                                          "Rs: ${snapshot.data!.docs[index]['price']}",
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
                                    // Text(
                                    //   "Rs : ${snapshot.data!.docs[index]['price']}",
                                    //   textAlign: TextAlign.center,
                                    //   style: TextStyle(
                                    //       fontSize: 20,
                                    //       fontWeight: FontWeight.bold,
                                    //       color: AppColors.white),maxLines: 1,overflow: TextOverflow.ellipsis,
                                    // ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.blue,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 2,
                            child: CircleAvatar(
                              radius: 19,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  Utils().exit_app_dialog(context,
                                      'Do you want to delete this product', () {
                                    FirebaseReferences()
                                        .products
                                        .doc(snapshot.data!.docs[index]['id'])
                                        .delete();
                                    Get.back();
                                  });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          )
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
}
