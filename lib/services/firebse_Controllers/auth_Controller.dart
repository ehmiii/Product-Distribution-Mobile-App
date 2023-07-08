import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pd_project/screens/Home_Screen.dart';
import 'package:pd_project/screens/order_Booker/order_Booker.dart';
import 'package:pd_project/screens/sale_Person/sale_Person.dart';
import '../../component/Utils.dart';
import '../../constants/Sessions.dart';



class Login_Controller extends ChangeNotifier {

  bool _loading = false;

  get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  void Login(String email, String password, BuildContext context) async  {
    setLoading(true);
    try {
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password).then((value) {
        SessionControler().userId = value.user!.uid.toString();
        setLoading(false);
        Get.to(Home_Screen());
        // if(auth.currentUser!.emailVerified == true){
        //   return Get.off(dashboard());
        // }else{
        //   auth.currentUser!.sendEmailVerification();
        //   return Get.off(dashboard());
        // }
      });

    }  on FirebaseAuthException catch (e) {
      setLoading(false);
      if (e.code == 'user-not-found') {
        setLoading(false);
        // Utils.flushBarMessage("No user found for that email.",context);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setLoading(false);
        // Utils.flushBarMessage("invalid password. please try again.",context);
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  void LoginControllers(String? email,password)async{
    final login = await auth.signInWithEmailAndPassword(email: email.toString(), password: password).then((value){
      if(email.toString() == "adman@gmail.com" && password == 1234567){
        Get.to(Home_Screen());
      }else if(email.toString() == "saleperson@gmail.com" && password == 1234567){
        return Get.to(Sale_Person());
      }else if(email.toString() == "orderbooker@gmail.com" && password == 1234567){
        return Get.to(Order_Booker());
      }
    } );
  }
  }
