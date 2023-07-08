import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../component/App_Button.dart';
import '../../component/Input_text_field.dart';
import '../../component/custom_App_bar.dart';
import '../../component/reusbale_row.dart';
import '../../constants/AppColors.dart';
import '../../constants/firebase_references.dart';

class ShopkeeperDetailScreen extends StatefulWidget {
  final String? id;
  const ShopkeeperDetailScreen({Key? key, this.id}) : super(key: key);

  @override
  State<ShopkeeperDetailScreen> createState() => _ShopkeeperDetailScreenState();
}

class _ShopkeeperDetailScreenState extends State<ShopkeeperDetailScreen> {
  data() async {
    var doc = await FirebaseReferences().orders.doc(widget.id).get();
    shop_Name_Controller.text = doc['shopName'];
    shopkeeper_NameController.text = doc['shopkeeperName'];
    phone_Controller.text = doc['phone'];
    cnic_Controller.text = doc['cnic'];
    address_Controller.text = doc['address'];
    setState(() {

    });
  }

  @override
  void initState() {
    data();
    super.initState();
  }

  final key = GlobalKey<FormState>();
  final shop_Name_Controller = TextEditingController();
  final shopkeeper_NameController = TextEditingController();
  final phone_Controller = TextEditingController();
  final cnic_Controller = TextEditingController();
  final address_Controller = TextEditingController();

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
                ReusbaleRow(value: "Shop Name",iconData: Icons.person,onPress: () {},value1:shop_Name_Controller.text ),
                Space(20),
                ReusbaleRow(value: "Shopkeeper Name",iconData: Icons.person,onPress: () {},value1:shopkeeper_NameController.text ),
                Space(20),
                ReusbaleRow(value: "Phone",iconData: Icons.phone,onPress: () {},value1:phone_Controller.text ),
                Space(20),
                ReusbaleRow(value: "CNIC",iconData: Icons.phone_iphone_sharp,onPress: () {},value1:cnic_Controller.text ),
                Space(20),
                ReusbaleRow(value: "Address",iconData: Icons.maps_home_work,onPress: () {},value1:address_Controller.text ),
                Space(40),
                App_button(
                    onPress: () {
                      Get.back();
                    },
                    tltle: "BACK",
                    loading: false)
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
