import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pd_project/component/Utils.dart';
import 'package:pd_project/constants/get_user_id.dart';

import '../../component/App_Button.dart';
import '../../component/Input_text_field.dart';
import '../../component/check_user_availability.dart';
import '../../component/custom_App_bar.dart';
import '../../component/validate.dart';
import '../../constants/AppColors.dart';
import '../../constants/firebase_references.dart';

class Add_Sale_Person extends StatefulWidget {
  const Add_Sale_Person({Key? key}) : super(key: key);

  @override
  State<Add_Sale_Person> createState() => _Add_Sale_PersonState();
}

class _Add_Sale_PersonState extends State<Add_Sale_Person> {
  final key = GlobalKey<FormState>();
  final spNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final spAgeController = TextEditingController();
  final phoneController = TextEditingController();
  final cnicController = TextEditingController();
  final addressController = TextEditingController();
  final joinDateController = TextEditingController();

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
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.appBar(
        text: "ADD SALE PERSON",
        onPressed: () => Get.back(),
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Space(10),
                Space(30),
                Input_text_field1(
                  myController: emailController,
                  onValidator: (value) {
                    return validateEmail(value);
                  },
                  focusNode: null,
                  hint: "example@gmail.com",
                  lable: "Email",
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field1(
                  myController: passwordController,
                  onValidator: (value) {
                    return validatePassword(value);
                  },
                  focusNode: null,
                  hint: "Password1234",
                  lable: 'Password',
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field1(
                  myController: spNameController,
                  onValidator: (value) {
                    if (spNameController.text == null ||
                        spNameController.text.isEmpty) {
                      return "Sale person is Name";
                    }
                  },
                  focusNode: null,
                  hint: "Sale person name",
                  lable: 'Sale Person Name',
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field1(
                  myController: spAgeController,
                  onValidator: (value) {
                    if (spAgeController.text == null ||
                        spAgeController.text.isEmpty) {
                      return "Shopkeeper Name is Empty";
                    }
                  },
                  focusNode: null,
                  hint: "Salepersons Age",
                  lable: 'Sale Person Age',
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field1(
                  myController: phoneController,
                  onValidator: (value) {
                    return validatePhoneNumber(value);
                  },
                  focusNode: null,
                  hint: "01234567890",
                  lable: "Phone",
                  keyboardType: TextInputType.phone,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field1(
                  myController: cnicController,
                  onValidator: (value) {
                    if (cnicController.text == null ||
                        cnicController.text.isEmpty) {
                      return "Sale Person is Cnic";
                    }
                  },
                  focusNode: null,
                  hint: "0000-00000000-000",
                  lable: "CNIC",
                  keyboardType: TextInputType.phone,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(20),
                Input_text_field1(
                  myController: addressController,
                  onValidator: (value) {
                    if (addressController.text == null ||
                        addressController.text.isEmpty) {
                      return "Address is Empty";
                    }
                  },
                  focusNode: null,
                  hint: "Address",
                  lable: 'Address',
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
                  lable: 'join Date',
                  keyboardType: TextInputType.name,
                  obscureTexts: false,
                  onFieldSubmittedValue: (newValue) {},
                ),
                Space(40),
                App_button(
                    onPress: () async {
                      if (key.currentState!.validate()) {
                        Utils().exit_app_dialog(
                            context, "Do you want to add this Sale person?",
                            () {
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
          cnicController.text)) {
        FirebaseReferences().sale.add({
          'email': emailController.text,
          'password': passwordController.text,
          'name': spNameController.text,
          'age': spAgeController.text,
          'address': addressController.text,
          'phone': phoneController.text,
          'cnic': cnicController.text,
          'joindate':
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
          'status': 'pending',
          'adminId': await GetUserId.GET_USER_ID()
        }).then((value) {
          value.update({'id': value.id.toString()}).then((value) {
            Utils().flushBarMessage(
                "SalePerson Add Successfully", Icons.check_circle);
          });
        });
        Get.back();
      } else {
        Utils().flushBarMessage(
            "User already exist please use different CNIC", Icons.info);
      }
    } catch (e) {
      print(" -------- $e");
    }
  }
}
