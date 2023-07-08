import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pd_project/constants/firebase_references.dart';

class CheckUserAvailability {
  static Future<bool> USER_DOES_NOT_AVAILABLE(String cnic) async {
    QuerySnapshot<Object?> userDetail;
    userDetail = await FirebaseReferences()
        .sale
        .where(
          "cnic",
          isEqualTo: cnic,
        )
        .get();
    if (userDetail.docs.isEmpty) {
      userDetail = await FirebaseReferences()
          .order_bookersReference
          .where(
            "cnic",
            isEqualTo: cnic,
          )
          .get();
    }
    return userDetail.docs.isEmpty ? true : false;
  }
}
