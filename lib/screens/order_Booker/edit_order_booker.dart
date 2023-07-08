import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../component/App_Button.dart';
import '../../component/Input_text_field.dart';
import '../../component/custom_App_bar.dart';
import '../../component/reusbale_row.dart';
import '../../constants/AppColors.dart';
import '../../constants/firebase_references.dart';

class EditOrderBooker extends StatefulWidget {
  String? id;
  EditOrderBooker({this.id, Key? key}) : super(key: key);

  @override
  State<EditOrderBooker> createState() => _EditOrderBookerState();
}

class _EditOrderBookerState extends State<EditOrderBooker> {
  final key = GlobalKey<FormState>();
  final BookerNameController = TextEditingController();
  final BookerAgeController = TextEditingController();
  final PhoneController = TextEditingController();
  final CnicController = TextEditingController();
  final AddressController = TextEditingController();
  final joinDateController = TextEditingController();
  final emialController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    data();
    super.initState();
  }

  data() async {
    var doc =
        await FirebaseReferences().order_bookersReference.doc(widget.id).get();
    joinDateController.text = doc['joindate'];
    BookerNameController.text = doc['name'];
    AddressController.text = doc['address'];
    BookerAgeController.text = doc['age'];
    CnicController.text = doc['cnic'];
    joinDateController.text = doc['joindate'];
    PhoneController.text = doc['phone'];
    emialController.text = doc['email'];
    passwordController.text = doc['password'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.appBar(
        text: "ORDER BOOKER DETAIL",
        onPressed: () => Get.back(),
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Space(30),

                ReusbaleRow(
                    value: "Email",
                    iconData: Icons.email,
                    onPress: () {},
                    value1: emialController.text),
                Space(20),
                ReusbaleRow(
                    value: "Password",
                    iconData: Icons.password,
                    onPress: () {},
                    value1: passwordController.text),
                Space(20),
                ReusbaleRow(
                    value: "Booker Name",
                    iconData: Icons.person,
                    onPress: () {},
                    value1: BookerNameController.text),
                Space(20),
                ReusbaleRow(
                    value: "Booker Age",
                    iconData: Icons.perm_contact_cal,
                    onPress: () {},
                    value1: BookerAgeController.text),
                Space(20),
                ReusbaleRow(
                    value: "Phone",
                    iconData: Icons.phone,
                    onPress: () {},
                    value1: PhoneController.text),
                Space(20),
                ReusbaleRow(
                    value: "CNIC",
                    iconData: Icons.phone_iphone_sharp,
                    onPress: () {},
                    value1: CnicController.text),
                Space(20),
                ReusbaleRow(
                    value: "Address",
                    iconData: Icons.maps_home_work,
                    onPress: () {},
                    value1: AddressController.text),
                Space(20),
                ReusbaleRow(
                    value: "Join Date",
                    iconData: Icons.date_range,
                    onPress: () {},
                    value1: joinDateController.text),
                Space(30),
                // App_button(onPress: () async {
                //   if(key.currentState!.validate()){
                //     addData();
                //   }
                //
                // }, tltle: "SAVE", loading: false),
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
    try {
      FirebaseReferences().order_bookersReference.doc(widget.id).update({
        'name': BookerNameController.text.toString(),
        'age': BookerAgeController.text,
        'address': AddressController.text,
        'phone': PhoneController.text,
        'cnic': CnicController.text,
        'joindate': joinDateController.text,
        'status': 'pending',
      }).then((value) {
        Get.back();
      });
    } catch (e) {
      print(" -------- $e");
    }
  }
}
