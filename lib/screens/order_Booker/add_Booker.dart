import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pd_project/component/App_Button.dart';
import 'package:pd_project/component/Utils.dart';
import 'package:pd_project/constants/AppColors.dart';
import 'package:pd_project/constants/firebase_references.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component/Input_text_field.dart';
import '../../component/check_user_availability.dart';
import '../../component/custom_App_bar.dart';
import '../../component/validate.dart';

class Add_Booker extends StatefulWidget {
  Add_Booker({Key? key}) : super(key: key);

  @override
  State<Add_Booker> createState() => _Add_BookerState();
}

class _Add_BookerState extends State<Add_Booker> {
  final key = GlobalKey<FormState>();
  final BookerNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final BookerAgeController = TextEditingController();
  final PhoneController = TextEditingController();
  final CnicController = TextEditingController();
  final AddressController = TextEditingController();
  final joinDateController = TextEditingController();
  final DeliveryDateController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    joinDateController.text =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(
        text: "ADD BOOKER",
        onPressed: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: key,
            child: Column(
              children: [
                Space(30),
                Input_text_field1(
                  myController: emailController,
                  onValidator: (value) {
                    if (value!.isNotEmpty) {
                      if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return null;
                      } else {
                        return "Invalid Email";
                      }
                    } else {
                      return "Fill email field";
                    }
                  },
                  focusNode: null,
                  lable: "Email",
                  hint: "example@gmail.com",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field1(
                  myController: passwordController,
                  onValidator: (value) {
                    return validatePassword(value);
                    // if(value.toString().isEmpty){
                    //   return "password is empty";
                    // }else if(value.toString().length <= 6){
                    //   return "password must be grater then 6 characters";
                    // }else{
                    //   return null;
                    // }
                  },
                  focusNode: null,
                  lable: "Password",
                  hint: "Password: 123456",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field1(
                  myController: BookerNameController,
                  onValidator: (value) {
                    if (BookerNameController.text == null ||
                        BookerNameController.text.isEmpty) {
                      return "BookerName is Empty";
                    }
                  },
                  focusNode: null,
                  lable: "Name",
                  hint: "Booker name",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field1(
                  myController: BookerAgeController,
                  onValidator: (value) {
                    if (BookerAgeController.text == null ||
                        BookerAgeController.text.isEmpty) {
                      return "Booker Age is Empty";
                    }
                  },
                  focusNode: null,
                  hint: "Booker Age",
                  lable: "Booker Age",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field1(
                  myController: PhoneController,
                  onValidator: (value) {
                    return validatePhoneNumber(value);
                  },
                  focusNode: null,
                  hint: "+920000000000",
                  lable: "Phone",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field1(
                  myController: CnicController,
                  onValidator: (value) {
                    return validateCnicNumber(value);
                  },
                  focusNode: null,
                  hint: "0000-00000000-0",
                  lable: "CNIC",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field1(
                  myController: AddressController,
                  onValidator: (value) {
                    if (AddressController.text == null ||
                        AddressController.text.isEmpty) {
                      return "Address is Empty";
                    }
                  },
                  focusNode: null,
                  hint: "Address",
                  lable: "Address",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field1(
                  myController: joinDateController,
                  onValidator: (value) {},
                  focusNode: null,
                  hint: "Joining Data",
                  lable: "Join Date",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(40),
                App_button(
                    onPress: () async {
                      if (key.currentState!.validate()) {
                        Utils().exit_app_dialog(
                            context, "Do you want to add this booker?", () {
                          addData();
                          Get.back();
                        });
                      }
                    },
                    tltle: "ADD",
                    loading: loading),
                Space(10),
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

  Future addData() async {
    setState(() {
      loading = true;
    });
    try {
      if (await CheckUserAvailability.USER_DOES_NOT_AVAILABLE(
          CnicController.text)) {
        final shr = await SharedPreferences.getInstance();
        String adminId = shr.getString("userId")!;
        FirebaseReferences().order_bookersReference.add({
          'email': emailController.text.trim(),
          'password': passwordController.text,
          'name': BookerNameController.text,
          'age': BookerAgeController.text,
          'address': AddressController.text,
          'phone': PhoneController.text,
          'cnic': CnicController.text,
          'joindate': joinDateController.text,
          'adminId': adminId
        }).then((value) {
          value.update({'id': value.id.toString()}).then((value) {
            Utils()
                .flushBarMessage("Booker Add successfully", Icons.check_circle);
          });

          Get.back();
        });
      } else {
        Utils().flushBarMessage(
            "User alread exist please use another CNIC", Icons.info);
      }
    } catch (e) {
      print(" -------- $e");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
