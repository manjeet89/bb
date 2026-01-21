import 'package:shared_preferences/shared_preferences.dart';

class allapiscreen {
  static String imageapi = "https://pashuraktkosh.lyferp.com/";
  static String login = "https://pashuraktkosh.lyferp.com/api/login";
  static String otp = "https://pashuraktkosh.lyferp.com/api/login/verification";
  static const String mypetlist = "https://pashuraktkosh.lyferp.com/api/pet/my_pet_list";
  static const String userprofile = "https://pashuraktkosh.lyferp.com/api/user/user_profile";
  static const String country = "https://pashuraktkosh.lyferp.com/api/user/country_list";
  static const String state = "https://pashuraktkosh.lyferp.com/api/user/state_from_country_id";
  static const String district =
      "https://pashuraktkosh.lyferp.com/api/user/district_list_from_state_id";
  static const String bloodgroup = "https://pashuraktkosh.lyferp.com/api/pet/user_blood_gorup_list";
  static const String userupdate = "https://pashuraktkosh.lyferp.com/api/user/user_profile_update";
  static const String microchipupdate =
      "https://pashuraktkosh.lyferp.com/api/pet/microchip_detail_update";
  static const String petcategory = "https://pashuraktkosh.lyferp.com/api/pet/pet_category";
  static const String petadd = "https://pashuraktkosh.lyferp.com/api/pet/add_pet";
  static const String sosblood = "https://pashuraktkosh.lyferp.com/api/pet/need_blood_donor";
  static const String breed = "https://pashuraktkosh.lyferp.com/api/pet/breed_list";
  static const String petweight = "https://pashuraktkosh.lyferp.com/api/pet/update_pet_weight";

  static Future<Map<String, String>> headerFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("auth_token") ?? "";
    String userId = prefs.getString("auth_userId") ?? "";

    return {"Usertoken": token, "Userid": userId};
  }
}
