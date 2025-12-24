import 'package:shared_preferences/shared_preferences.dart';

class allapiscreen {
  static String login = "https://pashuraktkosh.lyferp.com/api/login";
  static String otp = "https://pashuraktkosh.lyferp.com/api/login/verification";
  static const String mypetlist = "https://pashuraktkosh.lyferp.com/api/pet/my_pet_list";

  static Future<Map<String, String>> headerFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("auth_token") ?? "";
    String userId = prefs.getString("auth_userId") ?? "";

    return {"Usertoken": token, "Userid": userId};
  }
}
