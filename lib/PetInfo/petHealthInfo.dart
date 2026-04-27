// import 'dart:convert';

// import 'package:bb/ApiFolder/AllapiScreen.dart';
// import 'package:bb/PetInfo/petListModel.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import '../utils/app_colors.dart';

// class Pethealthinfo extends StatefulWidget {
//   const Pethealthinfo({super.key});

//   @override
//   State<Pethealthinfo> createState() => _PethealthinfoState();
// }

// class _PethealthinfoState extends State<Pethealthinfo> {
//   String diabetes = "Yes";
//   String bloodTrans = "Yes";
//   String camvisit = "Yes";

//   String? implementedBy = "Indoor and Outdoor";

//   final List<String> implementedByList = ['Indoor Only', 'Indoor and Outdoor', 'Outdoor Only'];

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     autofillHealthInfo(context); // Moved here to ensure context is fully initialized
//   }

//   void autofillHealthInfo(BuildContext c) async{
//     final pet = ModalRoute.of(c)?.settings.arguments as Petlistmodel?;
//     if (pet == null) return;

//     final Map<String, dynamic> data = jsonDecode(pet.healthinfo.toString());

//     setState(() {
//       // Yes / No buttons
//       diabetes = data['any_disease'] == "1" ? "Yes" : "No";
//       bloodTrans = data['transfusion'] == "1" ? "Yes" : "No";
//       camvisit = data['calm_during_vet_visits'] == "1" ? "Yes" : "No";

//       // Dropdown mapping
//       implementedBy = data['indoor_or_outdoor'] == "1"
//           ? "Indoor Only"
//           : data['indoor_or_outdoor'] == "2"
//           ? "Indoor and Outdoor"
//           : "Outdoor Only";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     // const Color darkRed = Color(0xff7A0000);
//     // const Color lightRed = Color(0xffFF6F6F);

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//       appBar: AppBar(
//         title: Text(
//           "Health Information",
//           style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.primarycolor,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColors.border,

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
//                 /// ⚧ Health History
//                 _Headerlabel("Health History"),

//                 _label("Any history of kidney disease, heart disease, FIV, FeLV, diabetes?"),
//                 Row(
//                   children: [
//                     _diabetes("No", Icons.close),
//                     const SizedBox(width: 10),
//                     _diabetes("Yes", Icons.check),
//                   ],
//                 ),

//                 const SizedBox(height: 18),

//                 /// ⚧ Health History
//                 _label("Ever received a blood transfusion?"),
//                 Row(
//                   children: [
//                     _bloodTransf("No", Icons.close),
//                     const SizedBox(width: 10),
//                     _bloodTransf("Yes", Icons.check),
//                   ],
//                 ),

//                 const SizedBox(height: 18),
//                 _Headerlabel("Lifestyle"),

//                 _label("Indoor or Outdoor?"),
//                 _buildDropdown(),

//                 const SizedBox(height: 18),
//                 _label("Calm during vet visits?"),
//                 Row(
//                   children: [
//                     _calmvisit("No", Icons.close),
//                     const SizedBox(width: 10),
//                     _calmvisit("Yes", Icons.check),
//                   ],
//                 ),
//                 const SizedBox(height: 18),

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
//                       createHealthInfoJson();

//                       // print("healthinfo: $healthInfoJson");

//                       // // Example API body
//                       // final body = {"healthinfo": healthInfoJson};

//                       // // send body via Dio or HTTP
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
//   ///
//   ///
//   ///
//   ///
//   ///
//   void createHealthInfoJson() {
//     final Map<String, String> healthInfo = {
//       "any_disease": diabetes == "Yes" ? "1" : "0",
//       "transfusion": bloodTrans == "Yes" ? "1" : "0",
//       "indoor_or_outdoor": implementedBy == "Indoor Only"
//           ? "1"
//           : implementedBy == "Outdoor Only"
//           ? "2"
//           : "3",
//       "calm_during_vet_visits": camvisit == "Yes" ? "1" : "0",
//       "btn_save_continue": "",
//     };
//     String encodedBody = jsonEncode(healthInfo);

//     submitVaccination(encodedBody);
//   }

//   Future<void> submitVaccination(String body) async {
//     final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

//     try {
//       var url = allapiscreen.healthinfo.toString();
//       var header = await allapiscreen.headerFunction();

//       Dio dio = Dio();

//       FormData formData = FormData.fromMap({"health_info": body, "pet_id": pet.petId.toString()});

//       Response response = await dio.post(
//         url,
//         data: formData,
//         options: Options(headers: header),
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text("Health info saved successfully")));
//         // Navigator.pop(context);
//       }
//     } catch (e) {
//       debugPrint("API ERROR: $e");
//     }
//   }

//   /// 🎨 Input Decoration
//   InputDecoration _inputDecoration() {
//     return InputDecoration(
//       filled: true,
//       fillColor: AppColors.white,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide(color: AppColors.border),
//       ),
//     );
//   }

//   /// /// 🔹 Dropdown
//   Widget _buildDropdown() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: DropdownButtonFormField<String>(
//         initialValue: implementedBy,
//         items: implementedByList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//         onChanged: (v) => setState(() => implementedBy = v),
//         validator: (v) => v == null ? 'Required' : null,
//         decoration: _inputDecoration(),
//       ),
//     );
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

//   Widget _diabetes(String gender, IconData icon) {
//     final bool isSelected = diabetes == gender;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             diabetes = gender;
//           });
//           //8084974200 salab ji
//         },
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: isSelected ? AppColors.primarycolor : AppColors.white.withOpacity(0.7),

//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 color: isSelected ? AppColors.white : AppColors.primarycolor.withOpacity(0.3),
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

//   Widget _bloodTransf(String gender, IconData icon) {
//     final bool isSelected = bloodTrans == gender;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             bloodTrans = gender;
//           });
//           //8084974200 salab ji
//         },
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: isSelected ? AppColors.primarycolor : AppColors.white.withOpacity(0.7),

//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 color: isSelected ? AppColors.white : AppColors.primarycolor.withOpacity(0.3),
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

//   Widget _calmvisit(String gender, IconData icon) {
//     final bool isSelected = camvisit == gender;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             camvisit = gender;
//           });
//           //8084974200 salab ji
//         },
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: isSelected ? AppColors.primarycolor : AppColors.white.withOpacity(0.7),

//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 color: isSelected ? AppColors.white : AppColors.primarycolor.withOpacity(0.3),
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
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class Pethealthinfo extends StatefulWidget {
  const Pethealthinfo({super.key});

  @override
  State<Pethealthinfo> createState() => _PethealthinfoState();
}

class _PethealthinfoState extends State<Pethealthinfo> {
  String diabetes = "Yes";
  String bloodTrans = "Yes";
  String calmVisit = "Yes";

  String? livingStyle = "Indoor and Outdoor";
  final List<String> livingStyleList = ['Indoor Only', 'Indoor and Outdoor', 'Outdoor Only'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autofillHealthInfo(context); // Moved here to ensure context is fully initialized
  }

  void autofillHealthInfo(BuildContext c) async {
    final pet = ModalRoute.of(c)?.settings.arguments as Petlistmodel?;
    if (pet == null || pet.healthinfo == null) {
      // Handle the case where pet or healthinfo is null
      return;
    }

    try {
      final Map<String, dynamic> data = jsonDecode(pet.healthinfo.toString());

      setState(() {
        // Yes / No buttons
        diabetes = data['any_disease'] == "1" ? "Yes" : "No";
        bloodTrans = data['transfusion'] == "1" ? "Yes" : "No";
        calmVisit = data['calm_during_vet_visits'] == "1" ? "Yes" : "No";

        // Dropdown mapping
        livingStyle = data['indoor_or_outdoor'] == "1"
            ? "Indoor Only"
            : data['indoor_or_outdoor'] == "2"
            ? "Indoor and Outdoor"
            : "Outdoor Only";
      });
    } catch (e) {
      debugPrint("Error decoding healthinfo: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),
      // appBar: AppBar(
      //   backgroundColor: AppColors.primarycolor,
      //   title: const Text(
      //     "Health Information",
      //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      //   ),
      //   centerTitle: true,
      // ),
            appBar: const CommonAppBar(),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors:[AppColors.AddButtonColor, AppColors.CatSilhouter],
            //  [AppColors.white, AppColors.secondrycolor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _sectionCard(
                title: "Health History",
                children: [
                  _question(
                    "Any history of kidney disease, heart disease, FIV, FeLV, diabetes?",
                    value: diabetes,
                    onChanged: (v) => setState(() => diabetes = v),
                  ),
                  _question(
                    "Ever received a blood transfusion?",
                    value: bloodTrans,
                    onChanged: (v) => setState(() => bloodTrans = v),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _sectionCard(
                title: "Lifestyle",
                children: [
                  _label("Indoor or Outdoor?"),
                  DropdownButtonFormField<String>(
                    value: livingStyle,
                    items: livingStyleList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => livingStyle = v),
                    decoration: _inputDecoration(),
                  ),
                  const SizedBox(height: 16),
                  _question(
                    "Calm during vet visits?",
                    value: calmVisit,
                    onChanged: (v) => setState(() => calmVisit = v),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.AddButtonColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: _submit,
                  child: const Text(
                    "Save Health Info",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= SUBMIT =================

  void _submit() {
    final body = {
      "any_disease": diabetes == "Yes" ? "1" : "0",
      "transfusion": bloodTrans == "Yes" ? "1" : "0",
      "indoor_or_outdoor": livingStyle == "Indoor Only"
          ? "1"
          : livingStyle == "Indoor and Outdoor"
          ? "2"
          : "3",
      "calm_during_vet_visits": calmVisit == "Yes" ? "1" : "0",
      "btn_save_continue": "",
    };

    submitVaccination(jsonEncode(body));
  }

  Future<void> submitVaccination(String body) async {
    final pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;
    try {
      Dio dio = Dio();
      final url = allapiscreen.healthinfo.toString();
      final headers = await allapiscreen.headerFunction();

      final response = await dio.post(
        url,
        data: FormData.fromMap({"pet_id": pet.petId.toString(), "health_info": body}),
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Health info saved successfully")));
        Navigator.pushNamed(context, '/home1');
      }
    } catch (e) {
      debugPrint("API ERROR: $e");
    }
  }

  // ================= UI WIDGETS =================

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.secondrycolor,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _question(String text, {required String value, required Function(String) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(text),
        Row(
          children: [
            _yesNoButton("Yes", value, onChanged),
            const SizedBox(width: 10),
            _yesNoButton("No", value, onChanged),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _yesNoButton(String text, String groupValue, Function(String) onChanged) {
    final selected = groupValue == text;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => onChanged(text),
        child: Container(
          height: 46,
          decoration: BoxDecoration(
            color: selected ? AppColors.AddButtonColor : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : AppColors.CatSilhouter,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.fontGrey),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.border),
      ),
    );
  }
}
