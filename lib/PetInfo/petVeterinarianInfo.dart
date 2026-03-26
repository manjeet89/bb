// import 'dart:convert';

// import 'package:bb/ApiFolder/AllapiScreen.dart';
// import 'package:bb/PetInfo/petListModel.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import '../utils/app_colors.dart';
// import 'package:http/http.dart' as http;

// class Petveterinarianinfo extends StatefulWidget {
//   const Petveterinarianinfo({super.key});

//   @override
//   State<Petveterinarianinfo> createState() => _PetveterinarianinfoState();
// }

// class _PetveterinarianinfoState extends State<Petveterinarianinfo> {
//   final TextEditingController clinicNameController = TextEditingController();
//   final TextEditingController clinicStateController = TextEditingController();
//   final TextEditingController vetNameController = TextEditingController();
//   final TextEditingController clinicPhoneController = TextEditingController();

//   String selectedGender = "Yes";

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     autofillHealthInfo(context); // Moved here to ensure context is fully initialized
//   }

//   Future<void> autofillHealthInfo(BuildContext contex) async {
//     final pet = ModalRoute.of(context)?.settings.arguments as Petlistmodel?;
//     if (pet == null) return;

//     final Map<String, dynamic> data = jsonDecode(pet.veterinarian.toString());

//     setState(() {
//       clinicNameController.text = data['clinic_name'] ?? '';
//       clinicStateController.text = data['clinic_state'] ?? '';
//       vetNameController.text = data['veterinarian_name'] ?? '';
//       clinicPhoneController.text = data['clinic_phone'] ?? '';
//       selectedGender = data['contact_vet_for_verification'] == "1" ? "Yes" : "No";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final scaffoldMessenger = ScaffoldMessenger.of(context);

//     // const Color darkRed = Color(0xff7A0000);
//     // const Color lightRed = Color(0xffFF6F6F);

//     return Scaffold(
//       backgroundColor: const Color(0xffF5F5F5),
//       appBar: AppBar(
//         title: Text(
//           "Veterinarian Information",
//           style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.primarycolor,
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           // color: AppColors.cardBackgroundWhite,
//           decoration: BoxDecoration(
//             color: AppColors.border,
//             // gradient: const LinearGradient(
//             //   // colors:AppColors.cardBackgroundWhite,
//             //   // [AppColors.darkRed, AppColors.mediumRed, AppColors.lightRed],
//             //   begin: Alignment.centerLeft,
//             //   end: Alignment.centerRight,
//             // ),
//             borderRadius: BorderRadius.circular(24),
//             boxShadow: const [
//               BoxShadow(color: AppColors.secondrycolor, blurRadius: 8, offset: Offset(0, 4)),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _Headerlabel("Veterinary Clinic Details"),

//                 /// 🐾 PET NAME
//                 _label("Clinic Name"),
//                 _inputField(
//                   controller: clinicNameController,
//                   hint: "Enter clinic name",
//                   icon: Icons.person,
//                 ),

//                 const SizedBox(height: 18),

//                 /// 🐾 PET NAME
//                 _label("City / Area / State"),
//                 _inputField(
//                   controller: clinicStateController,
//                   hint: "Enter city/area/state",
//                   icon: Icons.location_city_rounded,
//                 ),

//                 const SizedBox(height: 18),

//                 /// 🐾 PET NAME
//                 _label("Veterinarian Name"),
//                 _inputField(
//                   controller: vetNameController,
//                   hint: "Enter veterinarian name",
//                   icon: Icons.home_work,
//                 ),

//                 const SizedBox(height: 18),

//                 /// 🐾 PET NAME
//                 _label("Clinic Phone"),
//                 _inputField(
//                   controller: clinicPhoneController,
//                   hint: "Enter clinic phone",
//                   icon: Icons.phone,
//                 ),

//                 const SizedBox(height: 18),

//                 /// ⚧ GENDER
//                 _label("Consent to contact vet for verification?"),
//                 Row(
//                   children: [
//                     _genderButton("Yes", Icons.check),
//                     const SizedBox(width: 10),
//                     _genderButton("No", Icons.cancel),
//                   ],
//                 ),

//                 const SizedBox(height: 30),

//                 /// 🩸 SUBMIT BUTTON
//                 SizedBox(
//                   width: double.infinity,
//                   height: 52,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primarycolor,
//                       foregroundColor: AppColors.white,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                     ),
//                     onPressed: () {
//                       uploadVetInfo(context);
//                     },
//                     child: const Text(
//                       "Save",
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// ---------- Widgets ----------

//   Future<void> uploadVetInfo(BuildContext context) async {
//     final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

//     var url = allapiscreen.veterinarian.toString();
//     var headers = await allapiscreen.headerFunction();

//     final body = {
//       "clinic_name": clinicNameController.text,
//       "clinic_state": clinicStateController.text,
//       "veterinarian_name": vetNameController.text,
//       "clinic_phone": clinicPhoneController.text,
//       "contact_vet_for_verification": selectedGender == "Yes" ? "1" : "0",
//       "btn_save_continue": "",
//     };
//     String encodedBody = jsonEncode(body);

//     final response = await http.post(
//       Uri.parse(url),
//       headers: headers,
//       body: {"pet_id": pet.petId.toString(), "veterinarian_info": encodedBody},
//     );

//     if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Veterinarian info saved successfully"),
//           backgroundColor: AppColors.successGreen,
//         ),
//       );
//       // Navigator.pop(context, true);
//     }
//   }

//   Widget _label(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Text(
//         text,
//         style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _Headerlabel(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: AppColors.secondrycolor,
//           fontWeight: FontWeight.bold,
//           fontSize: 20,
//         ),
//       ),
//     );
//   }

//   Widget _inputField({
//     required TextEditingController controller,
//     required String hint,
//     required IconData icon,
//     bool readOnly = false,
//     VoidCallback? onTap,
//   }) {
//     return TextField(
//       controller: controller,
//       readOnly: readOnly,
//       onTap: onTap,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: AppColors.secondrycolor),
//         hintText: hint,
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(4),
//           borderSide: BorderSide(color: AppColors.dividerGrey),
//         ),
//       ),
//     );
//   }

//   Widget _genderButton(String gender, IconData icon) {
//     final bool isSelected = selectedGender == gender;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             selectedGender = gender;
//           });
//         },
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: isSelected ? AppColors.primarycolor : AppColors.white.withOpacity(0.8),

//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 color: isSelected ? AppColors.white : AppColors.secondrycolor.withOpacity(0.8),
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 gender,
//                 style: TextStyle(
//                   color: isSelected ? AppColors.white : AppColors.primarycolor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Header.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/app_colors.dart';
import 'package:http/http.dart' as http;

class Petveterinarianinfo extends StatefulWidget {
  const Petveterinarianinfo({super.key});

  @override
  State<Petveterinarianinfo> createState() => _PetveterinarianinfoState();
}

class _PetveterinarianinfoState extends State<Petveterinarianinfo> {
  final clinicNameController = TextEditingController();
  final clinicStateController = TextEditingController();
  final vetNameController = TextEditingController();
  final clinicPhoneController = TextEditingController();

  String selectedConsent = "Yes";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autofillHealthInfo(context);
  }

  Future<void> autofillHealthInfo(BuildContext context) async {
    final pet = ModalRoute.of(context)?.settings.arguments as Petlistmodel?;
    if (pet == null || pet.veterinarian == null) return;

    final data = jsonDecode(pet.veterinarian.toString());

    setState(() {
      clinicNameController.text = data['clinic_name'] ?? '';
      clinicStateController.text = data['clinic_state'] ?? '';
      vetNameController.text = data['veterinarian_name'] ?? '';
      clinicPhoneController.text = data['clinic_phone'] ?? '';
      selectedConsent = data['contact_vet_for_verification'] == "1" ? "Yes" : "No";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.w,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: AppColors.primarycolor,
      //   centerTitle: true,
      //   title: const Text("Veterinarian Info", style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.white)),
      // ),
            appBar: const CommonAppBar(),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.white, AppColors.secondrycolor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _headerCard().animate().fadeIn().slideY(),

              _sectionCard(
                title: "Clinic Details",
                icon: Icons.local_hospital,
                children: [
                  _input("Clinic Name", clinicNameController, Icons.business),
                  _input("City / State", clinicStateController, Icons.location_on),
                ],
              ).animate().fadeIn(delay: 200.ms).slideX(),

              _sectionCard(
                title: "Veterinarian Contact",
                icon: Icons.person,
                children: [
                  _input("Veterinarian Name", vetNameController, Icons.medical_services),
                  _input(
                    "Clinic Phone",
                    clinicPhoneController,
                    Icons.phone,
                    keyboard: TextInputType.phone,
                  ),
                ],
              ).animate().fadeIn(delay: 350.ms).slideX(),

              _consentCard().animate().fadeIn(delay: 500.ms).slideY(),

              const SizedBox(height: 30),

              _saveButton().animate().fadeIn(delay: 650.ms).scale(),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------- UI COMPONENTS ----------

  Widget _headerCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primarycolor,
            child: Icon(Icons.pets, color: Colors.white, size: 30),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              "Veterinary Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primarycolor),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _consentCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Consent", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          const SizedBox(height: 12),
          const Text(
            "Allow us to contact your veterinarian for verification?",
            style: TextStyle(color: AppColors.fontGrey),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _pillButton("Yes", Icons.check),
              const SizedBox(width: 12),
              _pillButton("No", Icons.close),
            ],
          ),
        ],
      ),
    );
  }

  Widget _saveButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primarycolor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        onPressed: () => uploadVetInfo(context),
        child: const Text(
          "Save Information",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.white),
        ),
      ),
    );
  }

  Widget _input(
    String hint,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          filled: true,
          fillColor: AppColors.border,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _pillButton(String value, IconData icon) {
    final bool active = selectedConsent == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedConsent = value),
        child: AnimatedContainer(
          duration: 300.ms,
          height: 46,
          decoration: BoxDecoration(
            color: active ? AppColors.primarycolor : AppColors.border,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: active ? Colors.white : AppColors.fontGrey),
              const SizedBox(width: 6),
              Text(
                value,
                style: TextStyle(
                  color: active ? Colors.white : AppColors.fontGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------- API ----------

  Future<void> uploadVetInfo(BuildContext context) async {
    final pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

    final body = jsonEncode({
      "clinic_name": clinicNameController.text,
      "clinic_state": clinicStateController.text,
      "veterinarian_name": vetNameController.text,
      "clinic_phone": clinicPhoneController.text,
      "contact_vet_for_verification": selectedConsent == "Yes" ? "1" : "0",
      "btn_save_continue": "",
    });

    final response = await http.post(
      Uri.parse(allapiscreen.veterinarian.toString()),
      headers: await allapiscreen.headerFunction(),
      body: {"pet_id": pet.petId.toString(), "veterinarian_info": body},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Veterinarian info saved successfully",
            style: TextStyle(color: AppColors.successGreen),
          ),
        ),
      );
      Navigator.pushNamed(context, '/home1');
    }
  }
}
