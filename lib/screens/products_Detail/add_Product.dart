import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pd_project/component/Utils.dart';
import 'package:pd_project/component/validate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../component/App_Button.dart';
import '../../component/Input_text_field.dart';
import '../../component/custom_App_bar.dart';
import '../../constants/AppColors.dart';
import '../../constants/firebase_references.dart';

class Add_Product extends StatefulWidget {
  const Add_Product({Key? key}) : super(key: key);

  @override
  State<Add_Product> createState() => _Add_ProductState();
}

class _Add_ProductState extends State<Add_Product> {
  final key = GlobalKey<FormState>();
  final newProductController = TextEditingController();
  final productPriceController = TextEditingController();
  bool loading = false;
  File? _imageFile;
  final picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  // List<File> _selectedImages = [];

  // Future<void> _selectImages() async {
  //   List<XFile>? imagePickerFiles = await ImagePicker().pickMultiImage();
  //   if (imagePickerFiles != null) {
  //     setState(() {
  //       _selectedImages = imagePickerFiles.map((file) => File(file.path)).toList();
  //     });
  //   }
  // }
  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(
        text: "ADD PRODUCT",
        onPressed: () => Get.back(),
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  getMultipImage();
                },
                child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_file,
                              size: 50,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text("Upload Images"),
                          ],
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                height: 150,
                child: images.length == 0
                    ? Center(
                        child: Text("No Images found"),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, i) {
                          return Container(
                              width: 100,
                              margin: EdgeInsets.only(right: 10),
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Image.file(
                                images[i],
                                fit: BoxFit.cover,
                              ));
                        },
                        itemCount: images.length,
                      ),
              ),
              SizedBox(
                height: 35,
              ),
              Input_text_field(
                myController: newProductController,
                onValidator: (value) {
                  if (newProductController.text == null ||
                      newProductController.text.isEmpty) {
                    return "Product Name is Empty";
                  }
                },
                focusNode: null,
                hint: "Product Name",
                keyboardType: TextInputType.name,
                obscureTexts: false,
                onFieldSubmittedValue: (newValue) {},
              ),
              SizedBox(
                height: 10,
              ),
              Input_text_field(
                myController: productPriceController,
                onValidator: (value) {
                  if (value
                      .toString()
                      .toLowerCase()
                      .contains(RegExp("[a-z]"))) {
                    return "Price should be in numbers";
                  } else {
                    return null;
                  }
                },
                focusNode: null,
                hint: "Product Price",
                keyboardType: TextInputType.name,
                obscureTexts: false,
                onFieldSubmittedValue: (newValue) {},
              ),
              SizedBox(
                height: 20,
              ),
              App_button(
                tltle: 'ADD PRODUCT',
                onPress: () async {
                  final shr = await SharedPreferences.getInstance();
                  final userId = shr.getString('userId');
                  if (key.currentState!.validate()) {
                    for (int i = 0; i < images.length; i++) {
                      String url = await uploadFile(images[i], userId!);
                      downloadUrls.add(url);

                      if (i == images.length - 1) {
                        storeEntry(downloadUrls, newProductController.text,
                            productPriceController.text, userId);
                      } else {
                        print("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
                      }
                    }
                  }
                },
                loading: loading,
              ),
            ]),
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

  storeEntry(List<String> imageUrls, String productName, productPrice,
      String? userId) {
    FirebaseReferences().products.add({
      'imageurl': imageUrls,
      'product': productName,
      'price': productPrice,
      'adminId': userId,
    }).then((value) {
      value.update({'id': value.id.toString()}).then((value) {
        Utils().flushBarMessage("Product Add Successful", Icons.check_circle);
        setState(() {
          loading = false;
        });
      });
      Get.back();
    });
  }

  List<String> downloadUrls = [];
  final ImagePicker _picker = ImagePicker();
  getMultipImage() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();

    if (pickedImages != null) {
      pickedImages.forEach((e) {
        images.add(File(e.path));
      });

      setState(() {});
    }
  }

  Future<String> uploadFile(File file, String userId) async {
    setState(() {
      loading = true;
    });
    final metaData = SettableMetadata(contentType: 'image/jpeg');
    final storageRef = FirebaseStorage.instance.ref();
    // final shr = await SharedPreferences.getInstance();
    // final userId = shr.getString('userId');
    Reference ref = storageRef
        .child('$userId/pictures/${DateTime.now().microsecondsSinceEpoch}.jpg');
    final uploadTask = ref.putFile(file, metaData);
    final taskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}
// Future addData() async{
//   setState(() {
//     loading = true;
//   });
//   try{
//     String fileName = (_imageFile!.path);
//     final firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
//     final uploadTask = firebaseStorageRef.putFile(_imageFile!);
//     final taskSnapshot = await uploadTask.then((p0){
//       p0.ref.getDownloadURL().then((value){
//         FirebaseReferences().products.add({
//           'name': newProductController.text,
//           'price' : productPriceController.text,
//           'imageUrl' : value.toString()
//         }).then((value){
//           value.update({'id' : value.id.toString()}).then((value){
//             Utils().flushBarMessage("Product add successfully", Icons.check_circle);
//           });
//         });
//       });
//     });
//     Get.back();
//   }catch(e){
//     print(" -------- $e");
//   }
// }
// Future pickImage() async {
//   final pickedFile = await picker.getImage(source: ImageSource.gallery);
//
//   setState(() {
//     _imageFile = File(pickedFile!.path);
//   });
// }
//
// Future<void> addData() async {
//   for (var i = 0; i < _selectedImages.length; i++) {
//     File image = _selectedImages[i];
//     String fileName = 'image_$i.jpg';
//     Reference ref = _storage.ref().child(fileName);
//     UploadTask uploadTask = ref.putFile(image);
//
//     TaskSnapshot snapshot = await uploadTask;
//     if (snapshot.state == TaskState.success) {
//       String downloadURL = await snapshot.ref.getDownloadURL();
//     final data =  await FirebaseReferences().products.add({
//           'imageUrl': downloadURL,
//           'product': newProductController.text,
//           'price': productPriceController.text,
//       });
//       String datw = downloadURL.data;
//     Utils().flushBarMessage('Images upload Successful', Icons.check_circle);
//     } else {
//       print('Error uploading image');
//     }
//   }
// }





//    addData() async{
//   setState(() {
//     loading = true;
//   });
//   try{
//     for (var i = 0; i < _selectedImages.length; i++) {
//       File image = _selectedImages[i];
//       String fileName = 'image_$i.jpg';
//       Reference ref = _storage.ref().child(fileName);
//       UploadTask uploadTask = ref.putFile(image);
//
//       TaskSnapshot snapshot = await uploadTask;
//       if (snapshot.state == TaskState.success) {
//         String downloadURL = await snapshot.ref.getDownloadURL().then((value){
//
//           FirebaseReferences().products.add({
//             'name': newProductController.text,
//             'price': productPriceController.text,
//             'imageUrl': value.toString(),
//           }).then((value) {
//             value.update({'id': value.id.toString()}).then((value){
//               return
//               Utils().flushBarMessage("Product add successfully", Icons.check_circle);
//             } );
//           });
//         });
//         print('Download URL: $downloadURL');
//       } else {
//         print('Error uploading image');
//       }
//     }
//   }catch(e){
//     print(" -------- $e");
//   }
//
// }
// return Scaffold(
//   appBar: CustomAppBar.appBar(text: "ADD PRODUCT",onPressed: () => Get.back(),),
//   body: SingleChildScrollView(
//     child: Form(
//       key: key,
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(children: [
//           // GestureDetector(
//           //   onTap: () {
//           //     _selectImages();
//           //   },
//           //   child: Container(height: 200,width: 300,
//           //   child: _imageFile.isNull ? Center(child: Icon(Icons.camera_alt),): Image.file(File(_imageFile!.path)),
//           //   decoration:BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white,),),
//           // ),
//           // InkWell(
//           //   onTap: () {
//           //     _selectImages();
//           //   },
//           //   child: Container(height: 200,
//           //     width: double.infinity,
//           //     child: ListView.builder(
//           //       itemCount: _selectedImages.length,
//           //       itemBuilder: (context, index) {
//           //         File image = _selectedImages[index];
//           //         return ListTile(
//           //           leading: Image.file(image),
//           //           title: Text('Image $index'),
//           //         );
//           //       },
//           //     ),
//           //   ),
//           // ),
//
//           Space(30),
//           Input_text_field(myController: newProductController,onValidator: (value) {
//             if(newProductController.text == null || newProductController.text.isEmpty ){
//               return "Product Name is Empty";
//             }
//
//           },
//             focusNode: null ,hint: "Product Name" ,keyboardType:TextInputType.name ,obscureTexts: false,onFieldSubmittedValue: (newValue) {},),
//           Space(20),
//           Input_text_field(myController: productPriceController,onValidator: (value) {
//             phonevalidata(value);
//
//           },
//             focusNode: null ,hint: "Product Price" ,keyboardType:TextInputType.name ,obscureTexts: false,onFieldSubmittedValue: (newValue) {},),
//           Space(30),
//           App_button(onPress:() {
//             if(key.currentState!.validate()){
//               // addData();
//             }
//           },tltle: "ADD",loading: loading,),
//           Space(10),
//           App_button(onPress:() {Get.back();},tltle: "BACK",loading: false,),
//           App_button(onPress:() {Get.to(
//             MultiFileUplaodScreen(),
//           );},tltle: "BACK",loading: false,),
//
//         ],),
//       ),
//     ),
//   ),
// );