import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../component/App_Button.dart';
import '../component/Input_text_field.dart';
import '../component/custom_App_bar.dart';
import '../component/reusbale_row.dart';
import '../constants/AppColors.dart';
import '../constants/firebase_references.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  String? id;
  
  final key = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final ageController = TextEditingController();
  final cnicController = TextEditingController();
  final emailController = TextEditingController();
  final joinDateController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    data();
    super.initState();
  }

  data() async {
    SharedPreferences shrf = await SharedPreferences.getInstance();
    String? userId = shrf.getString('userId');
    id = userId;
    var doc = await FirebaseReferences().order_bookersReference.doc(userId).get();
    nameController.text = doc['name'];
    addressController.text = doc['address'];
    ageController.text = doc['phone'];
    cnicController.text = doc['cnic'];
    emailController.text = doc['email'];
    joinDateController.text = doc['joindate'];
    phoneController.text = doc['phone'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("MY PROFILE",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: AppColors.blue,
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ReusbaleRow(value: "Email",iconData: Icons.email,onPress: () {},value1:emailController.text ),
                Space(20),
                ReusbaleRow(value: "Name",iconData: Icons.person,onPress: () {},value1:nameController.text ),
                Space(20),
                ReusbaleRow(value: "Address",iconData: Icons.home,onPress: () {},value1:addressController.text ),
                Space(20),
                ReusbaleRow(value: "CNIC",iconData: Icons.phone_iphone_sharp,onPress: () {},value1:cnicController.text ),
                Space(20),
                ReusbaleRow(value: "Phone",iconData: Icons.phone,onPress: () {},value1:phoneController.text ),
                Space(20),
                ReusbaleRow(value: "join date",iconData: Icons.email,onPress: () {},value1:joinDateController.text ),
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
