// import 'dart:io';

// import 'package:bb/AddressModule/Country/CountryModel.dart';
// import 'package:bb/AddressModule/Country/CountryWidget.dart';
// import 'package:bb/ApiFolder/AllapiScreen.dart';
// import 'package:bb/Breed/BreedModel.dart';
// import 'package:bb/Breed/Breedwidget.dart';
// import 'package:bb/PetInfo/PetListController.dart';
// import 'package:bb/PetInfo/petListModel.dart';
// import 'package:bb/PetInfo/petWeightHistoryModel.dart';
// import 'package:bb/main.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import '../utils/app_colors.dart';

// class Weightupdate extends StatefulWidget {
//   const Weightupdate({super.key});

//   @override
//   State<Weightupdate> createState() => _WeightupdateState();
// }

// class _WeightupdateState extends State<Weightupdate> {
//   final TextEditingController weight = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController weightController = TextEditingController();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     // final Object? petIds = ModalRoute.of(context)!.settings.arguments;
//     final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

//     // const Color darkRed = Color(0xff7A0000);
//     // const Color lightRed = Color(0xffFF6F6F);

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//       appBar: AppBar(
//         title: Text(
//           "Update weight",
//           style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.primarycolor,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: AppColors.border,
//                 // gradient: const LinearGradient(
//                 //   colors: [AppColors.darkRed, AppColors.mediumRed, AppColors.lightRed],
//                 //   begin: Alignment.centerLeft,
//                 //   end: Alignment.centerRight,
//                 // ),
//                 borderRadius: BorderRadius.circular(24),
//                 boxShadow: const [
//                   BoxShadow(color: AppColors.secondrycolor, blurRadius: 8, offset: Offset(0, 4)),
//                 ],
//               ),

//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// 🐾 PET NAME
//                     _label("Pet Weight"),
//                     _inputField(controller: weight, hint: "Enter pet weight", icon: Icons.pets),

//                     const SizedBox(height: 18),

//                     const SizedBox(height: 30),

//                     /// 🩸 SUBMIT BUTTON
//                     SizedBox(
//                       width: double.infinity,
//                       height: 52,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.white,
//                           foregroundColor: AppColors.darkRed,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                         ),
//                         onPressed: () {
//                           if (weight.text.isEmpty) {
//                             scaffoldMessenger.showSnackBar(
//                               SnackBar(
//                                 content: Text('pet name enter'),
//                                 backgroundColor: Colors.redAccent, // Red for errors
//                                 behavior: SnackBarBehavior.floating, // Modern floating look
//                                 duration: Duration(seconds: 3),
//                                 action: SnackBarAction(
//                                   label: 'RETRY',
//                                   textColor: Colors.white,
//                                   onPressed: () => weight.clear(),
//                                 ),
//                               ),
//                             );
//                           } else {
//                             PetRegistration(context);
//                           }
//                         },

//                         child: const Text(
//                           "Register Pet",
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             FutureBuilder<List<Petweighthistorymodel>>(
//               future: PetService.fetchPetsWeightHistory(
//                 pet.petId.toString(),
//                 pet.petWeightInKg.toString(),
//               ),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return const Center(child: Text("No pets found"));
//                 }

//                 final pets = snapshot.data!;

//                 return ListView.builder(
//                   padding: const EdgeInsets.all(12),
//                   itemCount: pets.length,
//                   itemBuilder: (context, index) {
//                     final pet = pets[index];
//                     List reqnumber = pet.weightUpdateOn.toString().split(" ");
//                     String req = reqnumber[0];

//                     return GestureDetector(
//                       onTap: () {
//                         navigatorKey.currentState?.pushNamed('/petDetails', arguments: pet);
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(vertical: 10),

//                         decoration: BoxDecoration(
//                           color: AppColors.border,

//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppColors.secondrycolor.withOpacity(0.4),

//                               blurRadius: 10,
//                               offset: const Offset(0, 6),
//                             ),
//                           ],
//                         ),

//                         child: Padding(
//                           padding: const EdgeInsets.all(14),
//                           child: Row(
//                             children: [
//                               // 📄 Pet Info
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         const Icon(
//                                           Icons.bloodtype,
//                                           color: AppColors.secondrycolor,
//                                           size: 18,
//                                         ),
//                                         const SizedBox(width: 6),
//                                         Text(
//                                           pet.weightId.toString(),
//                                           style: const TextStyle(
//                                             color: AppColors.primarycolor,

//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),

//                                     const SizedBox(height: 6),

//                                     Text(
//                                       "${req.replaceAll("-", "")}",
//                                       style: const TextStyle(
//                                         color: AppColors.fontGrey,

//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                               // ➡️ Action Icon
//                               GestureDetector(
//                                 onTap: () {
//                                   navigatorKey.currentState?.pushNamed(
//                                     '/petDetails',
//                                     arguments: pet,
//                                   );
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.15),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Icon(
//                                     Icons.arrow_forward_ios,
//                                     color: AppColors.primarycolor,
//                                     size: 16,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ---------- Widgets ----------

//   Widget _label(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Text(
//         text,
//         style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.bold),
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
//         prefixIcon: Icon(icon),
//         hintText: hint,
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }

//   void PetRegistration(BuildContext context) async {
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     final Object? petId = ModalRoute.of(context)!.settings.arguments;
//     print(petId);

//     var url = allapiscreen.petadd.toString();
//     var Header = await allapiscreen.headerFunction();

//     Dio dio = Dio();
//     DateTime now = DateTime.now();

//     FormData formData = FormData.fromMap({
//       "pet_category_id": petId,
//       "pet_weight_in_kg": weightController.text.toString(),
//     });

//     Response response = await dio.post(
//       url,
//       data: formData,
//       options: Options(headers: Header),
//     );

//     if (response.statusCode == 200) {
//       print("done");
//       print(response);
//       // String body = response.body;

//       // // Remove anything after the last closing brace
//       // int jsonEndIndex = body.lastIndexOf('}');
//       // if (jsonEndIndex != -1) {
//       //   body = body.substring(0, jsonEndIndex + 1);
//       // }

//       // final data = json.decode(body);

//       // print(data['data']);
//       scaffoldMessenger.showSnackBar(
//         SnackBar(
//           content: Text("Uploaded"),
//           backgroundColor: Colors.redAccent, // Red for errors
//           behavior: SnackBarBehavior.floating, // Modern floating look
//           duration: Duration(seconds: 2),
//           // action: SnackBarAction(
//           //   label: 'RETRY',
//           //   textColor: Colors.white,
//           //   onPressed: () => firstnameController.clear(),
//           // ),
//         ),
//       );
//       Navigator.pop(context);
//     }
//   }
// }

import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/PetInfo/PetListController.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/PetInfo/petWeightHistoryModel.dart';
import 'package:bb/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_colors.dart';

class Weightupdate extends StatefulWidget {
  const Weightupdate({super.key});

  @override
  State<Weightupdate> createState() => _WeightupdateState();
}

class _WeightupdateState extends State<Weightupdate> {
  final TextEditingController weightController = TextEditingController();
  late Petlistmodel pet;

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;
    weightController.value = TextEditingValue(text: pet.petWeightInKg.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Update Weight",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primarycolor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ---------- FORM ----------
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: AppColors.secondrycolor, blurRadius: 8, offset: Offset(0, 4)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label("Pet Weight (KG)"),
                    _inputField(
                      controller: weightController,
                      hint: "Enter pet weight",
                      icon: Icons.monitor_weight,
                    ),
                    const SizedBox(height: 30),

                    /// ---------- SUBMIT ----------
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primarycolor,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          if (weightController.text.isEmpty) {
                            scaffoldMessenger.showSnackBar(
                              const SnackBar(
                                content: Text('Please enter pet weight'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          } else {
                            PetRegistration(context);
                          }
                        },
                        child: const Text(
                          "Update Weight",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Divider(),
            _Headinglabel("Pet Weight History"),
            Divider(),

            /// ---------- WEIGHT HISTORY ----------
            FutureBuilder<List<Petweighthistorymodel>>(
              future: PetService.fetchPetsWeightHistory(
                pet.petId.toString(),
                pet.petWeightInKg.toString(),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("No weight history found"),
                  );
                }

                final history = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true, // ✅ VERY IMPORTANT
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final item = history[index];
                    String dates = item.weightUpdateOn.toString().split(" ").first;

                    final inputFormat = DateFormat('yyyy-MM-d');
                    final outputFormat = DateFormat('dd-MMMM-yyyy');

                    DateTime date = inputFormat.parse(dates);
                    String formattedDate = outputFormat.format(date);

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.secondrycolor.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(1, 2),
                          ),
                        ],
                        gradient: const LinearGradient(
                          colors: [AppColors.primarycolor, AppColors.cardBackgroundWhite],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Old Weight: ${item.weightCurrent}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                formattedDate,
                                style: const TextStyle(color: AppColors.warningOrange),
                              ),
                            ],
                          ),
                          const Icon(Icons.line_weight, color: AppColors.primarycolor),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void PetRegistration(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;
    print(pet.petId);

    var url = allapiscreen.petweight.toString();
    var Header = await allapiscreen.headerFunction();

    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      "pet_id": pet.petId,
      "pet_weight_in_kg": weightController.text.toString(),
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
          content: Text("Weight updated successfully"),
          backgroundColor: AppColors.successGreen, // Red for errors
          behavior: SnackBarBehavior.floating, // Modern floating look
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        navigatorKey.currentState?.pushNamed('/petList');
      });

      // Navigator.pop(context);
    }
  }

  /// ---------- API CALL ----------
  Future<void> _submitWeight() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      var url = allapiscreen.petadd.toString();
      var header = await allapiscreen.headerFunction();

      FormData formData = FormData.fromMap({
        "pet_category_id": pet.petId.toString(),
        "pet_weight_in_kg": weightController.text.trim(),
      });

      Response response = await Dio().post(
        url,
        data: formData,
        options: Options(headers: header),
      );

      if (response.statusCode == 200) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text("Weight updated successfully"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.redAccent),
      );
    }
  }

  /// ---------- UI HELPERS ----------
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _Headinglabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primarycolor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      style: TextStyle(color: AppColors.primarycolor, fontWeight: FontWeight.bold),
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: AppColors.border,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
