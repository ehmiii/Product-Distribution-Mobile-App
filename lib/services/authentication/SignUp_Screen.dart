import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pd_project/component/Utils.dart';

import '../../component/App_Button.dart';
import '../../component/Input_text_field.dart';
import '../../component/background_Color.dart';
import '../../constants/AppColors.dart';
import '../../screens/Home_Screen.dart';
import 'Login_Screen.dart';

class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({Key? key}) : super(key: key);

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  bool _loading = false;
  bool hideobscure = true;
  final key = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final PhoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode EmailFocusNode = FocusNode();
  FocusNode PasswordFocusNode = FocusNode();
  FocusNode NameFocusNode = FocusNode();
  FocusNode PhoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Background_Color(
          childs: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  space(25),
                  Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  space(30),
                  Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  space(3),
                  Input_text_field(
                      myController: userNameController,
                      onFieldSubmittedValue: (newValue) {},
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your user Name";
                        } else {
                          return null;
                        }
                      },
                      hint: "name",
                      keyboardType: TextInputType.name,
                      focusNode: NameFocusNode,
                      obscureTexts: false),
                  space(15),
                  Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  space(3),
                  Input_text_field(
                      myController: emailController,
                      onFieldSubmittedValue: (newValue) {},
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Email";
                        } else if (!GetUtils.isEmail(value)) {
                          return "Please enter correct email";
                        } else {
                          return null;
                        }
                      },
                      hint: 'name@example.com',
                      keyboardType: TextInputType.emailAddress,
                      focusNode: EmailFocusNode,
                      obscureTexts: false),
                  space(15),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  space(3),
                  Input_text_field(
                      myController: passwordController,
                      onFieldSubmittedValue: (newValue) {},
                      sufixicon: InkWell(
                        onTap: () {
                          paswod();
                        },
                        child: Icon(
                            hideobscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.orange,
                            size: 20),
                      ),
                      onValidator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        } else if (value.length < 6) {
                          return "Password lengtt must be greater then 5";
                        } else {
                          return null;
                        }
                      },
                      hint: 'min. 6 characters',
                      keyboardType: TextInputType.emailAddress,
                      focusNode: PasswordFocusNode,
                      obscureTexts: hideobscure),
                  space(15),
                  // Text(
                  //   "Phone Number",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  space(3),
                  // Input_text_field(
                  //     myController: PhoneController,
                  //     onFieldSubmittedValue: (newValue) {},
                  //     onValidator: (value) {},
                  //     hint: '11 characters',
                  //     keyboardType: TextInputType.phone,
                  //     focusNode: PhoneFocusNode,
                  //     obscureTexts: false),
                  space(40),
                  _loading
                      ? Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : App_button(
                          onPress: () async {
                            try {
                              setState(() {
                                _loading = true;
                              });

                              final user = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              await user.user!
                                  .updateDisplayName(userNameController.text);
                              Get.to(Login_Screen());
                            } catch (e) {
                              if (e
                                  .toString()
                                  .contains("email-already-in-use")) {
                                Utils().flushBarMessage(
                                    "Email alread exist", Icons.info);
                              } else {
                                Utils().flushBarMessage(
                                    "Some Error occured try again", Icons.info);
                              }
                            } finally {
                              setState(() {
                                _loading = false;
                              });
                            }
                            // Get.to(Home_Screen());
                          },
                          loading: false,
                          tltle: "Create Account",
                        ),
                  space(40),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account"),
                        InkWell(
                            onTap: () {
                              Get.to(Login_Screen());
                            },
                            child: Text(
                              "  Sign in?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.blue),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  paswod() {
    setState(() {
      hideobscure = !hideobscure;
    });
  }

  Widget space(double height) {
    return SizedBox(
      height: height,
    );
  }
}
