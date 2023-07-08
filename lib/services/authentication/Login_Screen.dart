import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pd_project/component/Utils.dart';
import 'package:pd_project/constants/firebase_references.dart';
import 'package:pd_project/screens/Home_Screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/App_Button.dart';
import '../../component/Input_text_field.dart';
import '../../component/background_Color.dart';
import '../../component/validate.dart';
import '../../constants/AppColors.dart';
import '../../orderbookerApp/order_booker_screen.dart';
import '../../sale_person_app/sale_person_home_screen.dart';
import '../../screens/order_Booker/order_Booker.dart';
import '../../screens/sale_Person/sale_Person.dart';
import '../firebse_Controllers/auth_Controller.dart';
import 'Forgot_Screen.dart';
import 'SignUp_Screen.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  bool _loading = false;
  bool hideobscure = true;
  final key = GlobalKey<FormState>();
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  FocusNode EmailFocusNode = FocusNode();
  FocusNode PasswordFocusNode = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background_Color(
      childs: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Center(
                    child: Image.asset(
                      "assets/login.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                space(20),

                Text(
                  "Login",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Sign in with your data that you entered during your registration."),
                space(30),
                // Text("Email",style: TextStyle(fontWeight: FontWeight.w500),),
                space(3),

                Input_text_field(
                    myController: EmailController,
                    onFieldSubmittedValue: (newValue) {},
                    onValidator: (value) {
                      return validateEmail(value);
                    },
                    hint: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    focusNode: EmailFocusNode,
                    obscureTexts: false),
                SizedBox(
                  height: 13,
                ),
                // Text("Password",style: TextStyle(fontWeight: FontWeight.w500,),),
                space(3),

                Input_text_field(
                    myController: PasswordController,
                    onFieldSubmittedValue: (newValue) {},
                    sufixicon: InkWell(
                      onTap: () {
                        paswod();
                      },
                      child: Icon(
                          hideobscure ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.orange,
                          size: 20),
                    ),
                    onValidator: (value) {
                      if (value.toString().isEmpty) {
                        return "password is empty";
                      } else if (value.toString().length < 6) {
                        return "password must be grater then 6 characters";
                      } else {
                        return null;
                      }
                    },
                    hint: 'min. 6 characters',
                    keyboardType: TextInputType.emailAddress,
                    focusNode: PasswordFocusNode,
                    obscureTexts: hideobscure),
                space(10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          final restEmailController = TextEditingController();
                          showDialog(
                            context: context,
                            builder: (context) => StatefulBuilder(
                              builder: (context, setState) => Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      App_button(
                                        onPress: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                StatefulBuilder(
                                              builder: (context, setState) =>
                                                  Dialog(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextFormField(
                                                        controller:
                                                            restEmailController,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Enter your Email",
                                                          labelText: "Email",
                                                          filled: true,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          suffix:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              if (restEmailController
                                                                  .text
                                                                  .isEmpty) {
                                                                Utils().flushBarMessage(
                                                                    "Please Enter your Email",
                                                                    Icons.info);
                                                              } else {
                                                                try {
                                                                  await FirebaseAuth
                                                                      .instance
                                                                      .sendPasswordResetEmail(
                                                                          email:
                                                                              restEmailController.text);
                                                                  Get.back();
                                                                } on FirebaseAuthException catch (error) {
                                                                  Utils().flushBarMessage(
                                                                      error
                                                                          .message
                                                                          .toString(),
                                                                      Icons
                                                                          .info);
                                                                }
                                                              }
                                                            },
                                                            child: Icon(
                                                              Icons.check,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                          "Close",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        tltle: "Admin",
                                        loading: false,
                                      ),
                                      // ElevatedButton(
                                      //   onPressed: () {},
                                      //   child: Text("Admin"),
                                      // ),

                                      App_button(
                                          onPress: () async {
                                            QuerySnapshot<Object?>? userDetail =
                                                null;
                                            CollectionReference<Object?>?
                                                userType;
                                            final cnicController =
                                                TextEditingController();
                                            final newPasswordController =
                                                TextEditingController();
                                            final confrimPasswordController =
                                                TextEditingController();
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  StatefulBuilder(
                                                builder: (context, setState) =>
                                                    Dialog(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextFormField(
                                                            controller:
                                                                cnicController,
                                                            enabled:
                                                                userDetail ==
                                                                    null,
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              hintText:
                                                                  "Enter your CNIC e.g 1620232123452",
                                                              labelText: "CNIC",
                                                              suffix: userDetail !=
                                                                      null
                                                                  ? SizedBox()
                                                                  : GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        if (cnicController.text.isEmpty ||
                                                                            cnicController.text.contains(RegExp(
                                                                                r"[a-z]"))) {
                                                                          Utils().flushBarMessage(
                                                                              "Please enter a valid cnic",
                                                                              Icons.info);
                                                                        } else if (cnicController.text.length ==
                                                                            13) {
                                                                          try {
                                                                            userDetail = await FirebaseReferences()
                                                                                .sale
                                                                                .where(
                                                                                  "cnic",
                                                                                  isEqualTo: cnicController.text,
                                                                                )
                                                                                .get();

                                                                            if (userDetail!.docs.isNotEmpty) {
                                                                              userType = FirebaseReferences().sale;
                                                                            }
                                                                            print(userDetail!.docs.isEmpty);
                                                                            if (userDetail!.docs.isEmpty) {
                                                                              userDetail = await FirebaseReferences()
                                                                                  .order_bookersReference
                                                                                  .where(
                                                                                    "cnic",
                                                                                    isEqualTo: cnicController.text,
                                                                                  )
                                                                                  .get();
                                                                              if (userDetail!.docs.isNotEmpty) {
                                                                                userType = FirebaseReferences().order_bookersReference;
                                                                              }
                                                                              setState(() {});
                                                                            }
                                                                            setState(() {});
                                                                          } catch (error) {
                                                                            print(error.toString());
                                                                          } finally {
                                                                            if (userDetail!.docs.isEmpty) {
                                                                              Utils().flushBarMessage("Given CNIC not found!!!", Icons.error);
                                                                            }
                                                                          }
                                                                        } else {
                                                                          Utils().flushBarMessage(
                                                                              "Cnic length must be 13",
                                                                              Icons.info);
                                                                        }
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_forward,
                                                                      ),
                                                                    ),
                                                            ),
                                                          ),
                                                        ),
                                                        userDetail == null ||
                                                                userDetail!.docs
                                                                    .isEmpty
                                                            ? SizedBox()
                                                            : Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          newPasswordController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        filled:
                                                                            true,
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        hintText:
                                                                            "Enter New Password",
                                                                        labelText:
                                                                            "New Password",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          confrimPasswordController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        filled:
                                                                            true,
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        hintText:
                                                                            "Enter Confirm Password",
                                                                        labelText:
                                                                            "Confirm Password",
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                        Row(
                                                          children: [
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              child: Text(
                                                                "Close",
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: userDetail ==
                                                                          null ||
                                                                      userDetail!
                                                                          .docs
                                                                          .isEmpty
                                                                  ? null
                                                                  : () async {
                                                                      if (newPasswordController
                                                                              .text
                                                                              .length <
                                                                          6) {
                                                                        Utils()
                                                                            .flushBarMessage(
                                                                          "Password length should be minimum 6",
                                                                          Icons
                                                                              .info,
                                                                        );
                                                                      } else if (newPasswordController
                                                                              .text !=
                                                                          confrimPasswordController
                                                                              .text) {
                                                                        Utils()
                                                                            .flushBarMessage(
                                                                          "New and confirma password should be same",
                                                                          Icons
                                                                              .info,
                                                                        );
                                                                      } else {
                                                                        print(userDetail!
                                                                            .docs[0]
                                                                            .data());
                                                                        await userType!
                                                                            .doc(userDetail!.docs[0]['id']
                                                                                as String?)
                                                                            .update(
                                                                          {
                                                                            "password":
                                                                                newPasswordController.text,
                                                                          },
                                                                        );
                                                                        Utils().flushBarMessage(
                                                                            "Password succefully updated",
                                                                            Icons.info);
                                                                        Get.back();
                                                                        Get.back();
                                                                      }
                                                                    },
                                                              child: Text(
                                                                "Update Password",
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          tltle: "Sale Person/Order Booker",
                                          loading: false),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("Close"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Passwrod?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                space(10),
                // ChangeNotifierProvider(create: (_) => Login_Controller(),
                //   child: Consumer<Login_Controller>(builder: (context, Provider, child) {
                //     return App_button(tltle: "Login " , loading: Provider.loading,onPress: () {
                //       if(key.currentState!.validate()){
                //         Provider.LoginControllers(EmailController.text, PasswordController.text,);
                //
                //       }
                //     },);
                //
                //   },),),
                _loading
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : App_button(
                        onPress: () {
                          if (key.currentState!.validate()) {
                            LoginControllers(
                                email: EmailController.text,
                                password: PasswordController.text);
                          }
                        },
                        tltle: "Login",
                        loading: _loading,
                      ),
                space(3),
                // Row(mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     InkWell(onTap: () {
                //
                //     },
                //         child: InkWell(onTap: () {
                //           Get.to(Forgot_Screen());
                //         },
                //             child: Text("Forgot Password?",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.blue),))),
                //   ],
                // ),

                space(40),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account"),
                      InkWell(
                        onTap: () {
                          Get.to(SignUp_Screen());
                        },
                        child: Text(
                          " Sign up?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.blue),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
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

  checkUser() async {
    SharedPreferences shrf = await SharedPreferences.getInstance();
    String? user = shrf.getString('usertype');
    String? userId = shrf.getString('userId');

    if (user == 'admin') {
      Get.off(() => Home_Screen());
    } else if (user == 'booker') {
      Get.off(() => OrderBookerScreen());
    } else if (user == 'saleperson') {
      Get.off(() => SalePersonHomeScreen());
    } else {
      print("NA");
    }
  }

  void LoginControllers({String? email, String? password}) async {
    String? error;
    SharedPreferences shrf = await SharedPreferences.getInstance();
    var user;
    try {
      setState(() {
        _loading = true;
      });
      user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      await shrf.setString("userId", user.user?.uid);
      // print(shrf.getString("userId"));
    } on FirebaseAuthException catch (e) {
      // Utils().flushBarMessage(e.message.toString(), Icons.info);
      error = e.message.toString();
      user = null;
    }
    print('Hello');
    if (user != null) {
      shrf.setString('usertype', 'admin');
      Utils().flushBarMessage("Admin Login Successfully", Icons.error_outline);
      Get.off(() => Home_Screen());
      // }).catchError((e) {

      //   Utils()
      //       .flushBarMessage("Email password incorrect", Icons.error_outline);
      //   setState(() {
      //     _loading = false;
      //   });
      // }).onError((error, stackTrace) {
      //   Utils()
      //       .flushBarMessage("Email password incorrect", Icons.error_outline);
      //   setState(() {
      //     _loading = false;
      //   });
      // });
    } else {
      String? orderBookerId;
      String? salePersonId;
      String? orderadminId;
      String? saleadminId;
      QuerySnapshot querySnapshot =
          await FirebaseReferences().order_bookersReference.get();

      List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      var lst = allData.where((element) => element["email"] == email).toList();
      orderBookerId = lst.isEmpty ? "null" : lst[0]['id'];
      orderadminId = lst.isEmpty ? "null" : lst[0]['adminId'];

      QuerySnapshot querySnapshot2 = await FirebaseReferences().sale.get();
      List allData2 = querySnapshot2.docs.map((doc) => doc.data()).toList();
      var lst2 =
          allData2.where((element) => element["email"] == email).toList();
      salePersonId = lst2.isEmpty ? "null" : lst2[0]['id'];
      saleadminId = lst2.isEmpty ? "null" : lst2[0]['adminId'];

      setState(() {
        _loading = false;
      });
      if (orderBookerId != "null") {
        DocumentSnapshot documentSnapshot = await FirebaseReferences()
            .order_bookersReference
            .doc(orderBookerId)
            .get();
        if (documentSnapshot['email'] == email) {
          setState(() {
            _loading = false;
          });
          if (documentSnapshot['password'] == password) {
            shrf.setString('userId', orderBookerId!);
            shrf.setString('adminId', orderadminId!);
            shrf.setString('usertype', 'booker');
            Get.off(() => OrderBookerScreen());
            setState(() {
              _loading = false;
            });
          }
        }
      } else {
        if (salePersonId != "null") {
          DocumentSnapshot documentSnapshot2 =
              await FirebaseReferences().sale.doc(salePersonId).get();
          if (documentSnapshot2['email'] == email) {
            setState(() {
              _loading = false;
            });
            if (documentSnapshot2['password'] == password) {
              shrf.setString('userId', salePersonId!);
              shrf.setString('adminId', saleadminId!);
              shrf.setString('usertype', 'saleperson');
              Get.off(() => SalePersonHomeScreen());
              setState(() {
                _loading = false;
              });
            } else {
              Utils().flushBarMessage("Password is Incorrect", Icons.info);
            }
          } else {
            Utils().flushBarMessage("Email is Incorrect", Icons.info);
          }
        }
      }
      if (error != null) {
        print(error);
        if (error.toLowerCase().contains(
            "The password is invalid or the user does not have a password.")) {
          Utils().flushBarMessage("Password is Incorrect", Icons.info);
        }
      }
      if (orderBookerId == "null" && salePersonId == "null" && user == null) {
        Utils().flushBarMessage("Email not found!!", Icons.info);
      }
    }
    // var collection = FirebaseFirestore.instance.collection('bookerOrder');
    // var querySnapshot = await collection.get();
    // Map<String, dynamic>? data;
    // for (var doc in querySnapshot.docs) {
    //    data = doc.data();
    // }
    //
    // if(data!.containsKey("name3")){
    //   print("true");
    // }else{
    //   print("false");
    // }
  }
}

// final login = await auth.signInWithEmailAndPassword(email: email.toString(), password: password).then((value){
// if(email.toString() == "adman@gmail.com"){
// Get.off(Home_Screen());
// }else if(email.toString() == "delivery@gmail.com"){
// return Get.off(SalePersonHomeScreen());
// }else if(email.toString() == "saleperson@gmail.com"){
// return Get.off(OrderBookerScreen());
// }
// } );
