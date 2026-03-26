// import 'package:bb/ApiFolder/AllapiScreen.dart';
// import 'package:bb/PetInfo/PetListController.dart';
// import 'package:bb/PetInfo/petListModel.dart';
// import 'package:bb/PetInfo/petWeightHistoryModel.dart';
// import 'package:bb/main.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../utils/app_colors.dart';

// class Weightupdate extends StatefulWidget {
//   const Weightupdate({super.key});

//   @override
//   State<Weightupdate> createState() => _WeightupdateState();
// }

// class _WeightupdateState extends State<Weightupdate> {
//   final TextEditingController weightController = TextEditingController();
//   late Petlistmodel pet;

//   @override
//   Widget build(BuildContext context) {
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;
//     weightController.value = TextEditingValue(text: pet.petWeightInKg.toString());

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           "Update Weight",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.primarycolor,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             /// ---------- FORM ----------
//             Container(
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: const [
//                   BoxShadow(color: AppColors.secondrycolor, blurRadius: 8, offset: Offset(0, 4)),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _label("Pet Weight (KG)"),
//                     _inputField(
//                       controller: weightController,
//                       hint: "Enter pet weight",
//                       icon: Icons.monitor_weight,
//                     ),
//                     const SizedBox(height: 30),

//                     /// ---------- SUBMIT ----------
//                     SizedBox(
//                       width: double.infinity,
//                       height: 52,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primarycolor,
//                           foregroundColor: AppColors.white,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                         ),
//                         onPressed: () {
//                           if (weightController.text.isEmpty) {
//                             scaffoldMessenger.showSnackBar(
//                               const SnackBar(
//                                 content: Text('Please enter pet weight'),
//                                 backgroundColor: Colors.redAccent,
//                               ),
//                             );
//                           } else {
//                             PetRegistration(context);
//                           }
//                         },
//                         child: const Text(
//                           "Update Weight",
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),
//             Divider(),
//             _Headinglabel("Pet Weight History"),
//             Divider(),

//             /// ---------- WEIGHT HISTORY ----------
//             FutureBuilder<List<Petweighthistorymodel>>(
//               future: PetService.fetchPetsWeightHistory(
//                 pet.petId.toString(),
//                 pet.petWeightInKg.toString(),
//               ),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Padding(
//                     padding: EdgeInsets.all(20),
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return const Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Text("No weight history found"),
//                   );
//                 }

//                 final history = snapshot.data!;

//                 return ListView.builder(
//                   shrinkWrap: true, // ✅ VERY IMPORTANT
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: history.length,
//                   itemBuilder: (context, index) {
//                     final item = history[index];
//                     String dates = item.weightUpdateOn.toString().split(" ").first;

//                     final inputFormat = DateFormat('yyyy-MM-d');
//                     final outputFormat = DateFormat('dd-MMMM-yyyy');

//                     DateTime date = inputFormat.parse(dates);
//                     String formattedDate = outputFormat.format(date);

//                     return Container(
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       padding: const EdgeInsets.all(14),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColors.secondrycolor.withOpacity(0.4),
//                             blurRadius: 10,
//                             offset: const Offset(1, 2),
//                           ),
//                         ],
//                         gradient: const LinearGradient(
//                           colors: [AppColors.primarycolor, AppColors.cardBackgroundWhite],
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Old Weight: ${item.weightCurrent}",
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: AppColors.white,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 formattedDate,
//                                 style: const TextStyle(color: AppColors.warningOrange),
//                               ),
//                             ],
//                           ),
//                           const Icon(Icons.line_weight, color: AppColors.primarycolor),
//                         ],
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

//   void PetRegistration(BuildContext context) async {
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;
//     print(pet.petId);

//     var url = allapiscreen.petweight.toString();
//     var Header = await allapiscreen.headerFunction();

//     Dio dio = Dio();

//     FormData formData = FormData.fromMap({
//       "pet_id": pet.petId,
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

//       scaffoldMessenger.showSnackBar(
//         SnackBar(
//           content: Text("Weight updated successfully"),
//           backgroundColor: AppColors.successGreen, // Red for errors
//           behavior: SnackBarBehavior.floating, // Modern floating look
//           duration: Duration(seconds: 2),
//         ),
//       );
//       setState(() {
//         navigatorKey.currentState?.pushNamed('/petList');
//       });

//       // Navigator.pop(context);
//     }
//   }

//   /// ---------- API CALL ----------
//   Future<void> _submitWeight() async {
//     final scaffoldMessenger = ScaffoldMessenger.of(context);

//     try {
//       var url = allapiscreen.petadd.toString();
//       var header = await allapiscreen.headerFunction();

//       FormData formData = FormData.fromMap({
//         "pet_category_id": pet.petId.toString(),
//         "pet_weight_in_kg": weightController.text.trim(),
//       });

//       Response response = await Dio().post(
//         url,
//         data: formData,
//         options: Options(headers: header),
//       );

//       if (response.statusCode == 200) {
//         scaffoldMessenger.showSnackBar(
//           const SnackBar(
//             content: Text("Weight updated successfully"),
//             backgroundColor: Colors.green,
//           ),
//         );
//         Navigator.pop(context);
//       }
//     } catch (e) {
//       scaffoldMessenger.showSnackBar(
//         SnackBar(content: Text("Error: $e"), backgroundColor: Colors.redAccent),
//       );
//     }
//   }

//   /// ---------- UI HELPERS ----------
//   Widget _label(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Text(
//         text,
//         style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _Headinglabel(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Text(
//         text,
//         style: const TextStyle(
//           color: AppColors.primarycolor,
//           fontWeight: FontWeight.bold,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }

//   Widget _inputField({
//     required TextEditingController controller,
//     required String hint,
//     required IconData icon,
//   }) {
//     return TextField(
//       style: TextStyle(color: AppColors.primarycolor, fontWeight: FontWeight.bold),
//       controller: controller,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon),
//         hintText: hint,
//         filled: true,
//         fillColor: AppColors.border,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }

import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Header.dart';
import 'package:bb/PetInfo/PetListController.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/PetInfo/petWeightHistoryModel.dart';
import 'package:bb/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    weightController.text = pet.petWeightInKg.toString();

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      // appBar: AppBar(
      //   backgroundColor: AppColors.primarycolor,
      //   title: const Text(
      //     "Update Weight",
      //     style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
      //   ),
      //   centerTitle: true,
      // ),
      appBar: const CommonAppBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🐾 PET INFO CARD
            _petHeaderCard(),

            const SizedBox(height: 20),

            /// ⚖️ UPDATE FORM
            _weightForm(scaffoldMessenger),

            const SizedBox(height: 30),

            /// 📊 HISTORY TITLE
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Weight History",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primarycolor,
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// 📈 HISTORY LIST
            _weightHistory(),
          ],
        ),
      ),
    );
  }

  // ---------------- PET HEADER ----------------

  Widget _petHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primarycolor, AppColors.secondrycolor]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primarycolor.withOpacity(.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            backgroundImage: pet.petImage.toString() != "null"
                ? NetworkImage("https://pashuraktkosh.lyferp.com/${pet.petImage}")
                : const AssetImage("assest/bblogo.png") as ImageProvider,
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pet.petName.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(pet.petName.toString(), style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.2);
  }

  // ---------------- FORM ----------------

  Widget _weightForm(ScaffoldMessengerState scaffoldMessenger) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Current Weight (KG)", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.monitor_weight),
              filled: true,
              fillColor: AppColors.border,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarycolor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                if (weightController.text.isEmpty) {
                  scaffoldMessenger.showSnackBar(const SnackBar(content: Text("Enter weight")));
                } else {
                  PetRegistration(context);
                }
              },
              child: const Text(
                "Update Weight",
                style: TextStyle(fontSize: 16, color: AppColors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2);
  }

  // ---------------- HISTORY ----------------

  Widget _weightHistory() {
    return FutureBuilder<List<Petweighthistorymodel>>(
      future: PetService.fetchPetsWeightHistory(pet.petId.toString(), pet.petWeightInKg.toString()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Padding(padding: EdgeInsets.all(20), child: Text("No weight history found"));
        }

        final history = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          itemBuilder: (context, index) {
            final item = history[index];
            final date = DateTime.parse(item.weightUpdateOn.toString());
            final formatted = DateFormat('dd MMM yyyy').format(date);

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)],
              ),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.successGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item.weightCurrent} KG",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(formatted, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: (index * 120).ms).slideX(begin: 0.2);
          },
        );
      },
    );
  }

  // ---------------- API ----------------

  void PetRegistration(BuildContext context) async {
    var url = allapiscreen.petweight.toString();
    var header = await allapiscreen.headerFunction();

    FormData formData = FormData.fromMap({
      "pet_id": pet.petId,
      "pet_weight_in_kg": weightController.text,
    });

    await Dio().post(
      url,
      data: formData,
      options: Options(headers: header),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Weight updated successfully"),
        backgroundColor: AppColors.successGreen,
      ),
    );

    navigatorKey.currentState?.pushNamed('/home');
  }
}
