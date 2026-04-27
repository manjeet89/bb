// import 'dart:convert';

// import 'package:bb/ApiFolder/AllapiScreen.dart';
// import 'package:bb/Header.dart';
// import 'package:bb/PetInfo/PetListController.dart';
// import 'package:bb/PetInfo/petListModel.dart';
// import 'package:bb/PetInfo/petWeightHistoryModel.dart';
// import 'package:bb/main.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:intl/intl.dart';
// import '../utils/app_colors.dart';
// import 'package:http/http.dart' as http;

// class Weightupdate extends StatefulWidget {
//   const Weightupdate({super.key});

//   @override
//   State<Weightupdate> createState() => _WeightupdateState();
// }

// class _WeightupdateState extends State<Weightupdate> {
//   TextEditingController weightController = TextEditingController();
//   late Petlistmodel pet;

//   @override
//   Widget build(BuildContext context) {
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;
//     // weightController.text = pet.petWeightInKg.toString();

//     return Scaffold(
//       backgroundColor: const Color(0xffF5F6FA),
//       // appBar: AppBar(
//       //   backgroundColor: AppColors.primarycolor,
//       //   title: const Text(
//       //     "Update Weight",
//       //     style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
//       //   ),
//       //   centerTitle: true,
//       // ),
//       appBar: const CommonAppBar(),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             /// 🐾 PET INFO CARD
//             _petHeaderCard(),

//             const SizedBox(height: 20),

//             /// ⚖️ UPDATE FORM
//             _weightForm(scaffoldMessenger),

//             const SizedBox(height: 30),

//             /// 📊 HISTORY TITLE
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Weight History",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.primarycolor,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 12),

//             /// 📈 HISTORY LIST
//             _weightHistory(),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------- PET HEADER ----------------

//   Widget _petHeaderCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(colors: [AppColors.primarycolor, AppColors.secondrycolor]),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.primarycolor.withOpacity(.4),
//             blurRadius: 12,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 32,
//             backgroundColor: Colors.white,
//             backgroundImage: pet.petImage.toString() != "null"
//                 ? NetworkImage("https://pashuraktkosh.lyferp.com/${pet.petImage}")
//                 : const AssetImage("assest/bblogo.png") as ImageProvider,
//           ),
//           const SizedBox(width: 14),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 pet.petName.toString(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(pet.petName.toString(), style: const TextStyle(color: Colors.white70)),
//             ],
//           ),
//         ],
//       ),
//     ).animate().fadeIn().slideY(begin: -0.2);
//   }

//   // ---------------- FORM ----------------

//   Widget _weightForm(ScaffoldMessengerState scaffoldMessenger) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 12)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Current Weight (KG)", style: TextStyle(fontWeight: FontWeight.bold)),
//           const SizedBox(height: 10),
//           TextField(
//             controller: weightController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               prefixIcon: const Icon(Icons.monitor_weight),
//               filled: true,
//               fillColor: AppColors.border,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),

//           SizedBox(
//             width: double.infinity,
//             height: 50,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primarycolor,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//               ),
//               onPressed: () async {
//                 if (weightController.text.isEmpty) {
//                   scaffoldMessenger.showSnackBar(const SnackBar(content: Text("Enter weight")));
//                 } else {
//                   var url = allapiscreen.petweight.toString();
//                   var header = await allapiscreen.headerFunction();

//                   final response = await http.post(
//                     Uri.parse(url),
//                     headers: header,
//                     body: {
//                       "pet_weight_in_kg": weightController.text.toString(),
//                       "pet_id": pet.petId.toString(),
//                     },
//                   );
//                   print(jsonDecode(response.body).toString());

//                   if (response.statusCode == 200) {
//                     final data = jsonDecode(response.body);
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Weight updated successfully"),
//                         backgroundColor: AppColors.successGreen,
//                       ),
//                     );
//                     await Future.delayed(const Duration(seconds: 2));
//                     navigatorKey.currentState?.pushNamed('/home1');
//                   } else {
//                     // Handle error (e.g., show a snackbar)
//                     print('Login failed: ${response.body}');
//                   }

//                   // var url = allapiscreen.petweight.toString();
//                   // var header = await allapiscreen.headerFunction();

//                   // print(weightController.text.toString() + " " + pet.petId.toString());

//                   // Dio dio = Dio();
//                   // FormData formData = FormData.fromMap({
//                   //   "pet_weight_in_kg": weightController.text.toString(),
//                   //   "pet_id": pet.petId.toString(),
//                   // });

//                   // await dio.post(
//                   //   url,
//                   //   data: formData,
//                   //   options: Options(headers: header),
//                   // );

//                   // ScaffoldMessenger.of(context).showSnackBar(
//                   //   const SnackBar(
//                   //     content: Text("Weight updated successfully"),
//                   //     backgroundColor: AppColors.successGreen,
//                   //   ),
//                   // );

//                   // // await Future.delayed(const Duration(seconds: 2));
//                   // // navigatorKey.currentState?.pushNamed('/home');
//                 }
//               },
//               child: const Text(
//                 "Update Weight",
//                 style: TextStyle(fontSize: 16, color: AppColors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2);
//   }

//   // ---------------- HISTORY ----------------

//   Widget _weightHistory() {
//     return FutureBuilder<List<Petweighthistorymodel>>(
//       future: PetService.fetchPetsWeightHistory(pet.petId.toString(), pet.petWeightInKg.toString()),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator());
//         }

//         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Padding(padding: EdgeInsets.all(20), child: Text("No weight history found"));
//         }

//         final history = snapshot.data!;

//         return ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: history.length,
//           itemBuilder: (context, index) {
//             final item = history[index];
//             final date = DateTime.parse(item.weightUpdateOn.toString());
//             final formatted = DateFormat('dd MMM yyyy').format(date);

//             return Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)],
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 10,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: AppColors.successGreen,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "${item.weightCurrent} KG",
//                         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                       Text(formatted, style: const TextStyle(color: Colors.grey)),
//                     ],
//                   ),
//                 ],
//               ),
//             ).animate().fadeIn(delay: (index * 120).ms).slideX(begin: 0.2);
//           },
//         );
//       },
//     );
//   }

//   // ---------------- API ----------------

//   void PetRegistration(BuildContext context) async {
//     var url = allapiscreen.petweight.toString();
//     var header = await allapiscreen.headerFunction();
//     print(weightController.text);
//     Dio dio = Dio();
//     FormData formData = FormData.fromMap({
//       "pet_weight_in_kg": weightController.text,
//       "pet_id": pet.petId.toString(),
//     });

//     await dio.post(
//       url,
//       data: formData,
//       options: Options(headers: header),
//     );

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text("Weight updated successfully"),
//         backgroundColor: AppColors.successGreen,
//       ),
//     );

//     navigatorKey.currentState?.pushNamed('/home1');
//   }
// }

import 'dart:convert';

import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Header.dart';
import 'package:bb/PetInfo/PetListController.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/PetInfo/petWeightHistoryModel.dart';
import 'package:bb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../utils/app_colors.dart';
import 'package:http/http.dart' as http;

class Weightupdate extends StatefulWidget {
  const Weightupdate({super.key});

  @override
  State<Weightupdate> createState() => _WeightupdateState();
}

class _WeightupdateState extends State<Weightupdate> {
  TextEditingController weightController = TextEditingController();

  late Petlistmodel pet;
  late Future<List<Petweighthistorymodel>> historyFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Get data only once
    pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

    // ✅ Store future (avoid multiple API calls)
    historyFuture = PetService.fetchPetsWeightHistory(
      pet.petId.toString(),
      pet.petWeightInKg.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: const CommonAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _petHeaderCard(),
            const SizedBox(height: 20),
            _weightForm(scaffoldMessenger),
            const SizedBox(height: 30),

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
        gradient: const LinearGradient(colors: [AppColors.AddButtonColor, AppColors.CatSilhouter]),
        borderRadius: BorderRadius.circular(20),
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
              Text("${pet.petWeightInKg} KG", style: const TextStyle(color: Colors.white70)),
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Current Weight (KG)", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon:  Icon(Icons.monitor_weight,color: AppColors.CatSilhouter,),
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                // borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.AddButtonColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () async {
                if (weightController.text.isEmpty) {
                  scaffoldMessenger.showSnackBar(const SnackBar(content: Text("Enter weight")));
                  return;
                }

                // 🔹 Show Loader
                _showLoader();

                var url = allapiscreen.petweight.toString();
                var header = await allapiscreen.headerFunction();

                final response = await http.post(
                  Uri.parse(url),
                  headers: header,
                  body: {"pet_weight_in_kg": weightController.text, "pet_id": pet.petId.toString()},
                );

                Navigator.pop(context); // hide loader

                if (response.statusCode == 200) {
                  // ✅ Update local value
                  setState(() {
                    pet.petWeightInKg = weightController.text;

                    // 🔁 Refresh history
                    historyFuture = PetService.fetchPetsWeightHistory(
                      pet.petId.toString(),
                      pet.petWeightInKg.toString(),
                    );
                  });

                  weightController.clear();

                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text("Weight updated successfully"),
                      backgroundColor: AppColors.successGreen,
                    ),
                  );
                } else {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text("Failed to update weight")),
                  );
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
    );
  }

  // ---------------- HISTORY ----------------

  Widget _weightHistory() {
    return FutureBuilder<List<Petweighthistorymodel>>(
      future: historyFuture,
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
              ),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.CatSilhouter,
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

  // ---------------- LOADER ----------------

  void _showLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
