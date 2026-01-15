import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'package:http/http.dart' as http;

class Petveterinarianinfo extends StatefulWidget {
  const Petveterinarianinfo({super.key});

  @override
  State<Petveterinarianinfo> createState() => _PetveterinarianinfoState();
}

class _PetveterinarianinfoState extends State<Petveterinarianinfo> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String selectedGender = "Yes";

  UploadValue() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    var url = allapiscreen.userupdate.toString();
    var Header = await allapiscreen.headerFunction();

    Dio dio = Dio();
    DateTime now = DateTime.now();

    FormData formData = FormData.fromMap({
      "user_address": addressController.text,
      "user_pin_code": pincodeController.text,
    });

    Response response = await dio.post(
      url,
      data: formData,
      options: Options(headers: Header),
    );

    if (response.statusCode == 200) {
      print("done");
      print(response);
      // String body = response.body;

      // // Remove anything after the last closing brace
      // int jsonEndIndex = body.lastIndexOf('}');
      // if (jsonEndIndex != -1) {
      //   body = body.substring(0, jsonEndIndex + 1);
      // }

      // final data = json.decode(body);

      // print(data['data']);
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text("User profile update successfully"),
          backgroundColor: AppColors.successGreen, // Red for errors
          behavior: SnackBarBehavior.floating, // Modern floating look
          duration: Duration(seconds: 2),
          // action: SnackBarAction(
          //   label: 'RETRY',
          //   textColor: Colors.white,
          //   onPressed: () => firstnameController.clear(),
          // ),
        ),
      );
      Navigator.pop(context, true); // Return true to indicate success
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // const Color darkRed = Color(0xff7A0000);
    // const Color lightRed = Color(0xffFF6F6F);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text(
          "Veterinarian Information",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primarycolor,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          // color: AppColors.cardBackgroundWhite,
          decoration: BoxDecoration(
            color: AppColors.border,
            // gradient: const LinearGradient(
            //   // colors:AppColors.cardBackgroundWhite,
            //   // [AppColors.darkRed, AppColors.mediumRed, AppColors.lightRed],
            //   begin: Alignment.centerLeft,
            //   end: Alignment.centerRight,
            // ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(color: AppColors.secondrycolor, blurRadius: 8, offset: Offset(0, 4)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Headerlabel("Veterinary Clinic Details"),

                /// 🐾 PET NAME
                _label("Clinic Name"),
                _inputField(
                  controller: firstnameController,
                  hint: "Enter clinic name",
                  icon: Icons.person,
                ),

                const SizedBox(height: 18),

                /// 🐾 PET NAME
                _label("City / Area / State"),
                _inputField(
                  controller: lastnameController,
                  hint: "Enter city/area/state",
                  icon: Icons.location_city_rounded,
                ),

                const SizedBox(height: 18),

                /// 🐾 PET NAME
                _label("Veterinarian Name"),
                _inputField(
                  controller: emailController,
                  hint: "Enter veterinarian name",
                  icon: Icons.home_work,
                ),

                const SizedBox(height: 18),

                /// 🐾 PET NAME
                _label("Clinic Phone"),
                _inputField(
                  controller: emailController,
                  hint: "Enter clinic phone",
                  icon: Icons.phone,
                ),

                const SizedBox(height: 18),

                /// ⚧ GENDER
                _label("Consent to contact vet for verification?"),
                Row(
                  children: [
                    _genderButton("Yes", Icons.check),
                    const SizedBox(width: 10),
                    _genderButton("No", Icons.cancel),
                  ],
                ),

                const SizedBox(height: 30),

                /// 🩸 SUBMIT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primarycolor,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ---------- Widgets ----------

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _Headerlabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.secondrycolor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.secondrycolor),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.dividerGrey),
        ),
      ),
    );
  }

  Widget _genderButton(String gender, IconData icon) {
    final bool isSelected = selectedGender == gender;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedGender = gender;
          });
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primarycolor : AppColors.white.withOpacity(0.8),

            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.white : AppColors.secondrycolor.withOpacity(0.8),
              ),
              const SizedBox(width: 6),
              Text(
                gender,
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.primarycolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
