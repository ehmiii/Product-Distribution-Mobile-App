import 'package:flutter/material.dart';
import 'package:pd_project/component/background_Color.dart';

import '../../component/App_Button.dart';
import '../../component/Input_text_field.dart';

class Forgot_Screen extends StatefulWidget {
  const Forgot_Screen({Key? key}) : super(key: key);

  @override
  State<Forgot_Screen> createState() => _Forgot_ScreenState();
}

class _Forgot_ScreenState extends State<Forgot_Screen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final Emailcontroller = TextEditingController();
  final confirmcontroller = TextEditingController();
  FocusNode EmailFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(212, 141, 75, 10),
        ),
        body: Background_Color(
            childs: SingleChildScrollView(
                child: Form(
                    key: key,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),

                              Text(
                                "Reset Password",
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "Enter the email associated with your accountand we'll send an email with instructions toreset your password."),

                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "Email",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),

                              SizedBox(
                                height: 4,
                              ),
                              Input_text_field(
                                obscureTexts: false,
                                myController: Emailcontroller,
                                focusNode: EmailFocusNode,
                                onFieldSubmittedValue: (newValue) {},
                                onValidator: (value) {
                                  if (value!.isEmpty) {
                                    return "Email is Empty";
                                  }
                                },
                                hint: "name@example.com",
                                keyboardType: TextInputType.emailAddress,
                              ),

                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              // ChangeNotifierProvider(create: (_) => forgot_Controller(),
                              //   child: Consumer<forgot_Controller>(builder: (context, Provider, child) {
                              //     return CustomButton(tltle: "Recover " , loading: Provider.loading,onPress: () {
                              //       if(key.currentState!.validate()){
                              //         Provider.forgot(Emailcontroller.text, context);
                              //
                              //       }
                              //     },);
                              //
                              //   },),),
                              App_button(
                                  tltle: "Reset Password",
                                  onPress: () {},
                                  loading: false),

                              SizedBox(height: 10),
                            ]))))));
  }
}
