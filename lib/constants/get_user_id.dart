import 'package:shared_preferences/shared_preferences.dart';

class GetUserId {
  static Future<String> GET_USER_ID() async {
    final shr = await SharedPreferences.getInstance();
    return shr.getString("userId")!;
  }
}
