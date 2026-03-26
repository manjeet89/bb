import 'dart:convert';

import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Header.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class Petmedications extends StatefulWidget {
  const Petmedications({super.key});

  @override
  State<Petmedications> createState() => _PetmedicationsState();
}

class _PetmedicationsState extends State<Petmedications> {
  final TextEditingController RevolutionPlusdobController = TextEditingController();

  final TextEditingController BravectoSpotOndobController = TextEditingController();

  final TextEditingController AdvantagedobController = TextEditingController();

  final TextEditingController DrontalCatdobController = TextEditingController();

  final TextEditingController CanwormCatdobController = TextEditingController();

  bool isCheckboxCheckedRevolutionPlus = false;
  bool isCheckboxCheckedBravectoSpotOn = false;
  bool isCheckboxCheckedAdvantage = false;
  bool isCheckboxCheckedDrontalCat = false;
  bool isCheckboxCheckedCanwormCat = false;

  bool rev = false, brav = false, adv = false, dron = false, can = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autoFillVaccination(context); // Moved here to ensure context is fully initialized
  }

  String formatDateUI(String? apiDate) {
    if (apiDate == null || apiDate.isEmpty) return "";
    final parts = apiDate.split("-");
    return "${parts[2]}-${parts[1]}-${parts[0]}";
  }

  void autoFillVaccination(BuildContext context) async {
    final pet = ModalRoute.of(context)?.settings.arguments as Petlistmodel?;
    if (pet == null) return;

    final Map<String, dynamic> data = jsonDecode(pet.medicationinfo.toString());

    /// -------- Mandatory vaccinations --------
    List vaccinations = data["parasite_control"] ?? [];

    if (vaccinations.contains("Revolution Plus")) {
      setState(() {
        isCheckboxCheckedRevolutionPlus = true;
      });
    }

    if (RevolutionPlusdobController.text.isEmpty) {
      setState(() {
        RevolutionPlusdobController.text = formatDateUI(data["medication_revolution_plus_date"]);
      });
    }

    if (vaccinations.contains("Bravecto Spot On")) {
      setState(() {
        isCheckboxCheckedBravectoSpotOn = true;
      });
    }

    if (BravectoSpotOndobController.text.isEmpty) {
      setState(() {
        BravectoSpotOndobController.text = formatDateUI(data["medication_bravecto_spot_on_date"]);
      });
    }

    if (vaccinations.contains("Advantage")) {
      setState(() {
        isCheckboxCheckedAdvantage = true;
      });
    }

    if (AdvantagedobController.text.isEmpty) {
      setState(() {
        AdvantagedobController.text = formatDateUI(data["medication_advantage_date"]);
      });
    }

    /// -------- Optional vaccinations --------
    List optionalVaccinations = data["deworming"] ?? [];

    if (optionalVaccinations.contains("Drontal Cat")) {
      setState(() {
        isCheckboxCheckedDrontalCat = true;
      });
    }

    if (DrontalCatdobController.text.isEmpty) {
      setState(() {
        DrontalCatdobController.text = formatDateUI(data["medication_deworming_date"]);
      });
    }

    if (optionalVaccinations.contains("Canworm Cat")) {
      setState(() {
        isCheckboxCheckedCanwormCat = true;
      });
    }

    if (CanwormCatdobController.text.isEmpty) {
      setState(() {
        CanwormCatdobController.text = formatDateUI(data["medication_canworm_cat_date"]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // const Color darkRed = Color(0xff7A0000);
    // const Color lightRed = Color(0xffFF6F6F);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      // appBar: AppBar(
      //   title: Text(
      //     "Medications",
      //     style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: AppColors.primarycolor,
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
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,

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
                  /// ⚧ Health History
                  _Headerlabel("Mandatory Parasite Control"),

                  _medicineTile(
                    "Revolution Plus",
                    isCheckboxCheckedRevolutionPlus,
                    (v) => setState(() => isCheckboxCheckedRevolutionPlus = v),
                  ),

                  // CheckboxListTile(
                  //   value: isCheckboxCheckedRevolutionPlus,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       isCheckboxCheckedRevolutionPlus = value ?? false;
                  //     });
                  //   },
                  //   title: const Text(
                  //     "Revolution Plus",
                  //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  _label("Medication Date"),
                  _inputField(
                    controller: RevolutionPlusdobController,
                    hint: "Select date",
                    icon: Icons.calendar_month,
                    readOnly: true,
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (picked != null) {
                        RevolutionPlusdobController.text =
                            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                      }
                    },
                  ),
                  const SizedBox(height: 18),
                  _medicineTile(
                    "Bravecto Spot On",
                    isCheckboxCheckedBravectoSpotOn,
                    (v) => setState(() => isCheckboxCheckedBravectoSpotOn = v),
                  ),

                  /// ⚧ Health History
                  // CheckboxListTile(
                  //   value: isCheckboxCheckedBravectoSpotOn,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       isCheckboxCheckedBravectoSpotOn = value ?? false;
                  //     });
                  //   },
                  //   title: const Text(
                  //     " Bravecto Spot On",
                  //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  //   ),
                  // ),

                  /// ⚧ Health History
                  _label("Medication Date"),

                  _inputField(
                    controller: BravectoSpotOndobController,
                    hint: "Select date",
                    icon: Icons.calendar_month,
                    readOnly: true,
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (picked != null) {
                        BravectoSpotOndobController.text =
                            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                      }
                    },
                  ),
                  const SizedBox(height: 18),
                  _medicineTile(
                    "Advantage",
                    isCheckboxCheckedAdvantage,
                    (v) => setState(() => isCheckboxCheckedAdvantage = v),
                  ),

                  /// ⚧ Health History
                  // CheckboxListTile(
                  //   value: isCheckboxCheckedAdvantage,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       isCheckboxCheckedAdvantage = value ?? false;
                  //     });
                  //   },
                  //   title: const Text(
                  //     "Advantage",
                  //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  //   ),
                  // ),

                  /// ⚧ Health History
                  _label("Medication Date"),

                  _inputField(
                    controller: AdvantagedobController,
                    hint: "Select date",
                    icon: Icons.calendar_month,
                    readOnly: true,
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (picked != null) {
                        AdvantagedobController.text =
                            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                      }
                    },
                  ),

                  const SizedBox(height: 18),

                  /// ⚧ Health History
                  _Headerlabel("Deworming"),
                  // CheckboxListTile(
                  //   value: isCheckboxCheckedDrontalCat,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       isCheckboxCheckedDrontalCat = value ?? false;
                  //     });
                  //   },
                  //   title: const Text(
                  //     "Drontal Cat",
                  //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  _medicineTile(
                    "Drontal Cat",
                    isCheckboxCheckedDrontalCat,
                    (v) => setState(() => isCheckboxCheckedDrontalCat = v),
                  ),

                  _label("Medication Date"),
                  _inputField(
                    controller: DrontalCatdobController,
                    hint: "Select date",
                    icon: Icons.calendar_month,
                    readOnly: true,
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (picked != null) {
                        DrontalCatdobController.text =
                            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                      }
                    },
                  ),
                  const SizedBox(height: 18),

                  /// ⚧ Health History
                  // CheckboxListTile(
                  //   value: isCheckboxCheckedCanwormCat,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       isCheckboxCheckedCanwormCat = value ?? false;
                  //     });
                  //   },
                  //   title: const Text(
                  //     "Canworm Cat",
                  //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  _medicineTile(
                    "Canworm Cat",
                    isCheckboxCheckedCanwormCat,
                    (v) => setState(() => isCheckboxCheckedCanwormCat = v),
                  ),

                  _label("Medication Date"),
                  _inputField(
                    controller: CanwormCatdobController,
                    hint: "Select date",
                    icon: Icons.calendar_month,
                    readOnly: true,
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                      if (picked != null) {
                        CanwormCatdobController.text =
                            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                      }
                    },
                  ),

                  const SizedBox(height: 18),

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
                      onPressed: () {
                        onSaveVaccination();
                      },
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
      ),
    );
  }

  /// ---------- Widgets ----------
  ///
  ///
  ///
  ///

  String formatDate(String date) {
    if (date.isEmpty) return "";
    final parts = date.split("-");
    return "${parts[2]}-${parts[1]}-${parts[0]}";
  }

  void onSaveVaccination() {
    List<String> parasite_control = [];
    List<String> deworming_control = [];

    Map<String, dynamic> parasite = {};
    Map<String, dynamic> deworming = {};

    /// -------- Mandatory Vaccinations --------
    if (isCheckboxCheckedRevolutionPlus) {
      parasite_control.add("Revolution Plus");
    }
    parasite["medication_revolution_plus_date"] = formatDate(RevolutionPlusdobController.text);

    if (isCheckboxCheckedBravectoSpotOn) {
      parasite_control.add("Bravecto Spot On");
    }
    parasite["medication_bravecto_spot_on_date"] = formatDate(BravectoSpotOndobController.text);

    if (isCheckboxCheckedAdvantage) {
      parasite_control.add("Advantage");
    }
    parasite["medication_advantage_date"] = formatDate(AdvantagedobController.text);

    //--------------optinal vaccination-----------
    if (isCheckboxCheckedDrontalCat) {
      deworming_control.add("Drontal Cat");
    }
    deworming["medication_deworming_date"] = formatDate(DrontalCatdobController.text);

    if (isCheckboxCheckedCanwormCat) {
      deworming_control.add("Canworm Cat");
    }
    deworming["medication_canworm_cat_date"] = formatDate(CanwormCatdobController.text);

    /// -------- Optional Vaccinations (if needed later) --------
    // if (isCheckboxCheckedFeLV) {
    //   vaccinations.add("FeLV");
    // }

    // if (isCheckboxCheckedChlamydia) {
    //   vaccinations.add("Chlamydia");
    // }

    /// Final payload
    Map<String, dynamic> payload = {
      "parasite_control": parasite_control,
      ...parasite,
      "deworming": deworming_control,
      ...deworming,
      "btn_save_continue": "",
    };

    String encodedBody = jsonEncode(payload);

    debugPrint("ENCODED JSON =====>");
    debugPrint(encodedBody);

    // 🔥 Call API here
    submitVaccination(encodedBody);
  }

  Future<void> submitVaccination(String body) async {
    final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

    try {
      var url = allapiscreen.medication.toString();
      var header = await allapiscreen.headerFunction();

      Dio dio = Dio();

      FormData formData = FormData.fromMap({
        "medication_info": body,
        "pet_id": pet.petId.toString(),
      });

      Response response = await dio.post(
        url,
        data: formData,
        options: Options(headers: header),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Medication saved successfully")));
        // Navigator.pop(context);
        Navigator.pushNamed(context, '/home1');
      }
    } catch (e) {
      debugPrint("API ERROR: $e");
    }
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

  void PetRegistration(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final Object? petId = ModalRoute.of(context)!.settings.arguments;
    print(petId);

    var url = allapiscreen.petadd.toString();
    var Header = await allapiscreen.headerFunction();

    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      // "pet_gender": diabetes == "Male" ? "1" : "0",
      // "country_bred_in": diabetes,
      "pet_category_id": petId,
    });

    Response response = await dio.post(
      url,
      data: formData,
      options: Options(headers: Header),
    );

    if (response.statusCode == 200) {
      print("done");
      print(response);

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text("Uploaded"),
          backgroundColor: Colors.redAccent, // Red for errors
          behavior: SnackBarBehavior.floating, // Modern floating look
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pushNamed(context, '/home1');
    }
  }

  Widget _medicineTile(String name, bool value, ValueChanged<bool> onChanged) {
    return Column(
      children: [
        SwitchListTile(
          value: value,
          onChanged: onChanged,
          title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          activeColor: AppColors.primarycolor,
        ),
        // if (value)
        //   Padding(
        //     padding: const EdgeInsets.only(left: 12, bottom: 12),
        //     child: TextField(
        //       controller: controller,
        //       readOnly: true,
        //       onTap: () async {
        //         final d = await showDatePicker(
        //           context: context,
        //           initialDate: DateTime.now(),
        //           firstDate: DateTime(2000),
        //           lastDate: DateTime.now(),
        //         );
        //         if (d != null) {
        //           controller.text =
        //               "${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}";
        //         }
        //       },
        //       decoration: const InputDecoration(
        //         prefixIcon: Icon(Icons.calendar_today),
        //         hintText: "Medication date",
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}

// Redesigned veterinarian-style medication page
// Focus: clean cards, clinic feel, better spacing, icons, subtle animation

// import 'dart:convert';
// import 'package:bb/ApiFolder/AllapiScreen.dart';
// import 'package:bb/PetInfo/petListModel.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import '../utils/app_colors.dart';

// class Petmedications extends StatefulWidget {
//   const Petmedications({super.key});

//   @override
//   State<Petmedications> createState() => _PetmedicationsState();
// }

// class _PetmedicationsState extends State<Petmedications> with SingleTickerProviderStateMixin {
//   late AnimationController _anim;

//   final RevolutionPlusdobController = TextEditingController();
//   final BravectoSpotOndobController = TextEditingController();
//   final AdvantagedobController = TextEditingController();
//   final DrontalCatdobController = TextEditingController();
//   final CanwormCatdobController = TextEditingController();

//   bool rev = false, brav = false, adv = false, dron = false, can = false;

//   @override
//   void initState() {
//     super.initState();
//     _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
//     _anim.forward();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     autoFillVaccination(context);
//   }

//   @override
//   void dispose() {
//     _anim.dispose();
//     super.dispose();
//   }

//   String formatDateUI(String? apiDate) {
//     if (apiDate == null || apiDate.isEmpty) return "";
//     final p = apiDate.split("-");
//     return "${p[2]}-${p[1]}-${p[0]}";
//   }

//   void autoFillVaccination(BuildContext context) {
//     final pet = ModalRoute.of(context)?.settings.arguments as Petlistmodel?;
//     if (pet == null) return;

//     final data = jsonDecode(pet.medicationinfo.toString());

//     List pc = data["parasite_control"] ?? [];
//     List dw = data["deworming"] ?? [];

//     setState(() {
//       rev = pc.contains("Revolution Plus");
//       brav = pc.contains("Bravecto Spot On");
//       adv = pc.contains("Advantage");
//       dron = dw.contains("Drontal Cat");
//       can = dw.contains("Canworm Cat");

//       RevolutionPlusdobController.text = formatDateUI(data["medication_revolution_plus_date"]);
//       BravectoSpotOndobController.text = formatDateUI(data["medication_bravecto_spot_on_date"]);
//       AdvantagedobController.text = formatDateUI(data["medication_advantage_date"]);
//       DrontalCatdobController.text = formatDateUI(data["medication_deworming_date"]);
//       CanwormCatdobController.text = formatDateUI(data["medication_canworm_cat_date"]);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF4F8F7),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: AppColors.primarycolor,
//         title: const Text("Veterinary Medications"),
//         centerTitle: true,
//       ),
//       body: FadeTransition(
//         opacity: _anim,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               _clinicHeader(),
//               const SizedBox(height: 20),
//               _sectionCard(
//                 title: "Parasite Control",
//                 icon: Icons.bug_report,
//                 children: [
//                   _medicineTile("Revolution Plus", rev, (v) => setState(() => rev = v)),
//                   _medicineTile("Bravecto Spot On", brav, (v) => setState(() => brav = v)),
//                   _medicineTile("Advantage", adv, (v) => setState(() => adv = v)),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               _sectionCard(
//                 title: "Deworming",
//                 icon: Icons.health_and_safety,
//                 children: [
//                   _medicineTile("Drontal Cat", dron, (v) => setState(() => dron = v)),
//                   _medicineTile("Canworm Cat", can, (v) => setState(() => can = v)),
//                 ],
//               ),
//               const SizedBox(height: 28),
//               SizedBox(
//                 width: double.infinity,
//                 height: 54,
//                 child: ElevatedButton.icon(
//                   icon: const Icon(Icons.save),
//                   label: const Text("Save Medication", style: TextStyle(fontSize: 18)),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primarycolor,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//                   ),
//                   onPressed: onSaveVaccination,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _clinicHeader() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
//       ),
//       child: Row(
//         children: const [
//           CircleAvatar(
//             radius: 28,
//             backgroundColor: AppColors.primarycolor,
//             child: Icon(Icons.local_hospital, color: Colors.white, size: 30),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: Text(
//               "Veterinary Medication Record",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _sectionCard({
//     required String title,
//     required IconData icon,
//     required List<Widget> children,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(22),
//         boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color: AppColors.primarycolor),
//               const SizedBox(width: 8),
//               Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             ],
//           ),
//           const Divider(height: 28),
//           ...children,
//         ],
//       ),
//     );
//   }

//   Widget _medicineTile(String name, bool value, ValueChanged<bool> onChanged) {
//     return Column(
//       children: [
//         SwitchListTile(
//           value: value,
//           onChanged: onChanged,
//           title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
//           activeColor: AppColors.primarycolor,
//         ),
//         // if (value)
//         //   Padding(
//         //     padding: const EdgeInsets.only(left: 12, bottom: 12),
//         //     child: TextField(
//         //       controller: controller,
//         //       readOnly: true,
//         //       onTap: () async {
//         //         final d = await showDatePicker(
//         //           context: context,
//         //           initialDate: DateTime.now(),
//         //           firstDate: DateTime(2000),
//         //           lastDate: DateTime.now(),
//         //         );
//         //         if (d != null) {
//         //           controller.text =
//         //               "${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}";
//         //         }
//         //       },
//         //       decoration: const InputDecoration(
//         //         prefixIcon: Icon(Icons.calendar_today),
//         //         hintText: "Medication date",
//         //       ),
//         //     ),
//         //   ),
//       ],
//     );
//   }

//   String formatDate(String date) {
//     if (date.isEmpty) return "";
//     final p = date.split("-");
//     return "${p[2]}-${p[1]}-${p[0]}";
//   }

//   void onSaveVaccination() {
//     List<String> parasite = [];
//     List<String> deworm = [];

//     if (rev) parasite.add("Revolution Plus");
//     if (brav) parasite.add("Bravecto Spot On");
//     if (adv) parasite.add("Advantage");
//     if (dron) deworm.add("Drontal Cat");
//     if (can) deworm.add("Canworm Cat");

//     final payload = {
//       "parasite_control": parasite,
//       "medication_revolution_plus_date": formatDate(RevolutionPlusdobController.text),
//       "medication_bravecto_spot_on_date": formatDate(BravectoSpotOndobController.text),
//       "medication_advantage_date": formatDate(AdvantagedobController.text),
//       "deworming": deworm,
//       "medication_deworming_date": formatDate(DrontalCatdobController.text),
//       "medication_canworm_cat_date": formatDate(CanwormCatdobController.text),
//       "btn_save_continue": "",
//     };

//     submitVaccination(jsonEncode(payload));
//   }

//   Future<void> submitVaccination(String body) async {
//     final pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;
//     var url = allapiscreen.medication.toString();
//     var header = await allapiscreen.headerFunction();
//     print(body);

//     // FormData formData = FormData.fromMap({"medication_info": body, "pet_id": pet.petId.toString()});

//     // await Dio().post(
//     //   url,
//     //   data: formData,
//     //   options: Options(headers: header),
//     // );

//     // ScaffoldMessenger.of(
//     //   context,
//     // ).showSnackBar(const SnackBar(content: Text("Medication saved successfully")));
//   }
// }
