// import 'package:bb/PetInfo/petListModel.dart';
// import 'package:bb/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import '../utils/app_colors.dart';
// import 'package:intl/intl.dart';

// class PetDetailScreen extends StatefulWidget {
//   const PetDetailScreen({super.key});

//   @override
//   State<PetDetailScreen> createState() => _PetDetailScreenState();
// }

// class _PetDetailScreenState extends State<PetDetailScreen> {
//   bool showOptions = false;
//   String petinfo = "Pet Info";

//   void toggleOptions() {
//     setState(() {
//       showOptions = !showOptions; // Toggling the visibility of additional options
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

//     final inputFormat = DateFormat('yyyy-MM-d');
//     final outputFormat = DateFormat('dd-MMMM-yyyy');

//     DateTime date = inputFormat.parse(pet.petBirthDate.toString());
//     String formattedDate = outputFormat.format(date);

//     print(formattedDate); // 05-October-2021

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 245, 245, 247),
//       // appBar: AppBar(
//       //   backgroundColor: AppColors.primarycolor,
//       //   title: const Text(
//       //     "Pets Profile🐾",
//       //     style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//       //   ),
//       //   centerTitle: true,
//       // ),
//       // backgroundColor: AppColors.bgGrey,

//       // appBar: AppBar(title: Text(pet.petName.toString()), backgroundColor: AppColors.darkRed),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           FloatingActionButton.extended(
//             onPressed: () {
//               // When the main FAB is pressed,
//               // toggleOptions is called
//               toggleOptions();

//               showOptions != true ? petinfo = "Pet Info" : petinfo = "Back";
//             },
//             label: Text(petinfo, style: TextStyle(color: Colors.white)),
//             // icon: Icon(Icons.add, color: Colors.white),
//             backgroundColor: showOptions != true ? AppColors.successGreen : AppColors.darkRed,
//           ),
//           SizedBox(height: 16.0),
//           Visibility(
//             visible: showOptions, // Show the options only if showOptions is true
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children:
//                       [
//                             FloatingActionButton.extended(
//                               backgroundColor: pet.microchipNumber.toString() != "null"
//                                   ? AppColors.successGreen
//                                   : AppColors.primarycolor,
//                               onPressed: () {
//                                 navigatorKey.currentState?.pushNamed(
//                                   '/petmicrochip',
//                                   arguments: pet,
//                                 );
//                                 // Add your action for Option 1
//                               },
//                               tooltip: 'Microchip Details',
//                               label: Row(
//                                 children: [
//                                   Text("Microchip Details", style: TextStyle(color: Colors.white)),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(width: 16.0),
//                             FloatingActionButton.extended(
//                               backgroundColor: pet.healthinfo.toString() != "null"
//                                   ? AppColors.successGreen
//                                   : AppColors.primarycolor,
//                               onPressed: () {
//                                 navigatorKey.currentState?.pushNamed(
//                                   '/petHealthinfo',
//                                   arguments: pet,
//                                 );
//                                 // Add your action for Option 1
//                               },
//                               tooltip: 'Health Information',
//                               label: Row(
//                                 children: [
//                                   Text("Health Information", style: TextStyle(color: Colors.white)),
//                                 ],
//                               ),
//                             ),
//                           ]
//                           .animate(interval: 200.ms) // Staggers the animation for each child
//                           .fade(duration: 100.ms)
//                           .slide(),
//                 ),

//                 SizedBox(height: 16.0),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children:
//                       [
//                             FloatingActionButton.extended(
//                               backgroundColor: pet.vaccinationinfo.toString() != "null"
//                                   ? AppColors.successGreen
//                                   : AppColors.primarycolor,
//                               onPressed: () {
//                                 navigatorKey.currentState?.pushNamed(
//                                   '/petvaccinationdetails',
//                                   arguments: pet,
//                                 );
//                                 // Add your action for Option 1
//                               },
//                               tooltip: 'Vaccination Details',
//                               label: Row(
//                                 children: [
//                                   Text(
//                                     "Vaccination Details",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             SizedBox(width: 16.0),
//                             FloatingActionButton.extended(
//                               backgroundColor: pet.medicationinfo.toString() != "null"
//                                   ? AppColors.successGreen
//                                   : AppColors.primarycolor,
//                               onPressed: () {
//                                 navigatorKey.currentState?.pushNamed(
//                                   '/petmedications',
//                                   arguments: pet,
//                                 );
//                                 // Add your action for Option 1
//                               },
//                               tooltip: 'Medications',
//                               label: Row(
//                                 children: [
//                                   Text("Medications", style: TextStyle(color: Colors.white)),
//                                 ],
//                               ),
//                             ),
//                           ]
//                           .animate(interval: 200.ms) // Staggers the animation for each child
//                           .fade(duration: 100.ms)
//                           .slide(),
//                 ),

//                 SizedBox(height: 16.0),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children:
//                       [
//                             FloatingActionButton.extended(
//                               backgroundColor: pet.veterinarian.toString() != "null"
//                                   ? AppColors.successGreen
//                                   : AppColors.primarycolor,
//                               onPressed: () {
//                                 navigatorKey.currentState?.pushNamed(
//                                   '/petveterinarianinfo',
//                                   arguments: pet,
//                                 );
//                                 // Add your action for Option 1
//                               },
//                               tooltip: 'Veterinarian Details',
//                               label: Row(
//                                 children: [
//                                   Text(
//                                     "Veterinarian Details",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(width: 16.0),
//                             FloatingActionButton.extended(
//                               backgroundColor: AppColors.primarycolor,
//                               onPressed: () {
//                                 navigatorKey.currentState?.pushNamed(
//                                   '/petWeightupdate',
//                                   arguments: pet,
//                                 );
//                                 // Add your action for Option 1
//                               },
//                               tooltip: 'Weight Update',
//                               label: Row(
//                                 children: [
//                                   Text("Weight Update", style: TextStyle(color: AppColors.white)),
//                                 ],
//                               ),
//                             ),
//                           ]
//                           .animate(interval: 200.ms) // Staggers the animation for each child
//                           .fade(duration: 100.ms)
//                           .slide(),
//                 ),
//                 SizedBox(height: 16.0),
//               ],
//             ),
//           ),
//         ],
//       ),

//       /// ⬇️ ACTION BUTTONS
//       // bottomNavigationBar: Padding(
//       //   padding: const EdgeInsets.all(14),
//       //   child: Row(
//       //     children: [
//       //       Expanded(
//       //         child: _actionButton(
//       //           text: "Health Information",
//       //           icon: Icons.edit,
//       //           onTap: () {
//       //             // TODO: Navigate to update screen
//       //             navigatorKey.currentState?.pushNamed('/petHealthinfo', arguments: pet);
//       //           },
//       //         ),
//       //       ),
//       //       const SizedBox(width: 12),
//       //       Expanded(
//       //         child: _actionButton(
//       //           text: "Mircrochip Details",
//       //           icon: Icons.comment,
//       //           onTap: () {
//       //             navigatorKey.currentState?.pushNamed('/petmicrochip', arguments: pet);

//       //             // _showCommentSheet(context);
//       //           },
//       //         ),
//       //       ),
//       //       const SizedBox(width: 12),
//       //       Expanded(
//       //         child: _actionButton(
//       //           text: "Vaccination Details",
//       //           icon: Icons.comment,
//       //           onTap: () {
//       //             navigatorKey.currentState?.pushNamed('/petvaccinationdetails', arguments: pet);

//       //             // _showCommentSheet(context);
//       //           },
//       //         ),
//       //       ),
//       //       const SizedBox(width: 12),
//       //       Expanded(
//       //         child: _actionButton(
//       //           text: "Medications",
//       //           icon: Icons.comment,
//       //           onTap: () {
//       //             navigatorKey.currentState?.pushNamed('/petmedications', arguments: pet);

//       //             // _showCommentSheet(context);
//       //           },
//       //         ),
//       //       ),
//       //       const SizedBox(width: 12),
//       //       Expanded(
//       //         child: _actionButton(
//       //           text: "Veterinarian Details",
//       //           icon: Icons.comment,
//       //           onTap: () {
//       //             navigatorKey.currentState?.pushNamed('/petveterinarianinfo', arguments: pet);

//       //             // _showCommentSheet(context);
//       //           },
//       //         ),
//       //       ),
//       //       // Expanded(
//       //       //   child: _actionButton(
//       //       //     text: "Add Comment",
//       //       //     icon: Icons.comment,
//       //       //     onTap: () {
//       //       //       _showCommentSheet(context);
//       //       //     },
//       //       //   ),
//       //       // ),
//       //     ],
//       //   ),
//       // ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // const SizedBox(height: 5),

//             /// 🔴 HEADER
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               color: AppColors.primarycolor,
//               // decoration: const BoxDecoration(
//               //   gradient: LinearGradient(
//               //     colors: [AppColors.darkRed, AppColors.mediumRed, AppColors.lightRed],
//               //     begin: Alignment.centerLeft,
//               //     end: Alignment.centerRight,
//               //   ),
//               // ),
//               child: Column(
//                 children:
//                     [
//                           const SizedBox(height: 40),
//                           CircleAvatar(
//                             radius: 40,
//                             backgroundColor: Colors.white,
//                             backgroundImage: pet.petImage.toString() != "null"
//                                 ? NetworkImage("https://pashuraktkosh.lyferp.com/${pet.petImage}")
//                                 : const AssetImage("assets/pet.png") as ImageProvider,
//                           ),
//                           const SizedBox(height: 12),
//                           // Divider(),
//                           Text(
//                             pet.petName.toString(),
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ]
//                         .animate(interval: 200.ms) // Staggers the animation for each child
//                         .fade(duration: 100.ms)
//                         .slide(),
//               ),
//             ),

//             /// 📄 DETAILS CARD
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: const [
//                     BoxShadow(color: AppColors.secondrycolor, blurRadius: 8, offset: Offset(0, 4)),
//                   ],
//                 ),
//                 child: Column(
//                   children:
//                       [
//                             _detailRow(
//                               "Pet ID :",
//                               pet.petBirthDate.toString().replaceAll("-", "") +
//                                   pet.petId.toString(),
//                             ),
//                             Divider(),
//                             _detailRow(
//                               "Gender :",
//                               pet.petGender.toString() == "1" ? "Male" : "Female",
//                             ),
//                             Divider(),

//                             if (pet.petWeightInKg.toString() != "null")
//                               _detailRow("Weight :", "${pet.petWeightInKg} KG"),
//                             if (pet.petWeightInKg.toString() != "null") Divider(),

//                             _detailRow(
//                               "Date of Birth :",
//                               formattedDate,

//                               // days + "-" + month + "-" + year
//                               // DateFormat(
//                               //   'dd-MMMM-yyyy',
//                               // ).format(DateTime.parse(pet.petBirthDate.toString())).toString(),
//                             ),
//                             Divider(),

//                             // if (pet.countryBredIn.toString() != "null")
//                             // _detailRow("Country :", pet.countryBredIn.toString()),
//                             _detailRow("Species :", pet.petCategoryName.toString()),
//                           ]
//                           .animate(interval: 200.ms) // Staggers the animation for each child
//                           .fade(duration: 100.ms)
//                           .slide(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _detailRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               title,
//               style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.w600),
//             ),
//           ),
//           Text(
//             value.isNotEmpty ? value : "-",
//             style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondrycolor),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// ---------- Widgets ----------

// Widget _actionButton({required String text, required IconData icon, required VoidCallback onTap}) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       height: 52,
//       decoration: BoxDecoration(
//         color: AppColors.primarycolor,

//         //   gradient: const LinearGradient(
//         //     colors: [AppColors.darkRed, AppColors.mediumRed],
//         //     begin: Alignment.centerLeft,
//         //     end: Alignment.centerRight,
//         //   ),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: Colors.white, size: 20),
//           const SizedBox(width: 8),
//           Text(
//             text,
//             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// /// 💬 COMMENT BOTTOM SHEET
// void _showCommentSheet(BuildContext context) {
//   final TextEditingController commentCtrl = TextEditingController();

//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//     ),
//     builder: (_) {
//       return Padding(
//         padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Add Comment",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkRed),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: commentCtrl,
//               maxLines: 4,
//               decoration: InputDecoration(
//                 hintText: "Write your comment...",
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
//               ),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               width: double.infinity,
//               height: 48,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkRed),
//                 onPressed: () {
//                   print("Comment: ${commentCtrl.text}");
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Submit"),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

// Widget _detailRow(String title, String value) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 10),
//     child: Row(
//       children: [
//         Expanded(
//           child: Text(
//             title,
//             style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark),
//           ),
//         ),
//         Text(value.isNotEmpty ? value : "-", style: const TextStyle(color: Colors.black54)),
//       ],
//     ),
//   );
// }

import 'dart:convert';

import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Header.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class PetDetailScreen extends StatefulWidget {
  const PetDetailScreen({super.key});

  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  String BreeedName = "";
  static String countryName = "";
  String districtName = "";
  String stateName = "";
  bool onetime = true;
  bool countryonetime = true;
  bool districtonetime = true;
  bool stateonetime = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<String> fetchData(String id) async {
    final url = allapiscreen.petdetails.toString();
    final header = await allapiscreen.headerFunction();

    final response = await http.post(Uri.parse(url), headers: header, body: {"pet_id": id});

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      print(data);

      setState(() {
        BreeedName = data['breed_name'] ?? "";
        onetime = false;
      });
    }
    return BreeedName;
  }

  country(String id) async {
    final url = allapiscreen.country.toString();
    final header = await allapiscreen.headerFunction();

    final response = await http.post(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      try {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse is Map && decodedResponse['data'] is List) {
          final dataList = decodedResponse['data'] as List;

          for (var item in dataList) {
            if (item is Map && item['country_id'].toString() == id) {
              setState(() {
                countryName = item['country_name'] ?? "";
                countryonetime = false;
              });
              break;
            }
          }
        } else {
          print("Unexpected response structure: $decodedResponse");
        }
      } catch (e) {
        print("Error decoding response: $e");
      }
    } else {
      print("Failed to fetch country data. Status code: ${response.statusCode}");
    }
    return countryName;
  }

  state(String stateid, String contid) async {
    final url = allapiscreen.state.toString();
    final header = await allapiscreen.headerFunction();

    final response = await http.post(Uri.parse(url), headers: header, body: {"country_id": contid});

    if (response.statusCode == 200) {
      try {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse is Map && decodedResponse['data'] is List) {
          final dataList = decodedResponse['data'] as List;

          for (var item in dataList) {
            if (item is Map && item['state_id'].toString() == stateid) {
              setState(() {
                stateName = item['state_name'] ?? "";
                stateonetime = false;
              });
              break;
            }
          }
        } else {
          print("Unexpected response structure: $decodedResponse");
        }
      } catch (e) {
        print("Error decoding response: $e");
      }
    } else {
      print("Failed to fetch country data. Status code: ${response.statusCode}");
    }
    return stateName;
  }

  district(String state, String dist) async {
    final url = allapiscreen.district.toString();
    final header = await allapiscreen.headerFunction();

    final response = await http.post(Uri.parse(url), headers: header, body: {"state_id": state});

    if (response.statusCode == 200) {
      try {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse is Map && decodedResponse['data'] is List) {
          final dataList = decodedResponse['data'] as List;

          for (var item in dataList) {
            if (item is Map && item['district_id'].toString() == dist) {
              setState(() {
                districtName = item['district_name'] ?? "";
                districtonetime = false;
              });
              break;
            }
          }
        } else {
          print("Unexpected response structure: $decodedResponse");
        }
      } catch (e) {
        print("Error decoding response: $e");
      }
    } else {
      print("Failed to fetch country data. Status code: ${response.statusCode}");
    }
    return districtName;
  }

  // Future<String> district(String state, String dist) async {
  //   final url = allapiscreen.district.toString();
  //   final header = await allapiscreen.headerFunction();

  //   final response = await http.post(Uri.parse(url), headers: header, body: {"state_id": state});

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body)['data'];
  //     print(data);

  //     setState(() {
  //       if (data['district_id'].toString() == dist) {
  //         districtName = data['district_name'] ?? "";
  //         districtonetime = false;
  //       }
  //     });
  //   }
  //   return districtName;
  // }

  @override
  Widget build(BuildContext context) {
    final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

    final inputFormat = DateFormat('yyyy-MM-d');
    final outputFormat = DateFormat('dd-MMMM-yyyy');

    DateTime date = inputFormat.parse(pet.petBirthDate.toString());
    String formattedDate = outputFormat.format(date);
    if (onetime == true) {
      // fetchData updates the state variable BreeedName via setState; call it without assigning the Future here
      fetchData(pet.petId.toString());
    }

    if (countryonetime == true) {
      country(pet.petCountry.toString());
    }

    if (stateonetime == true) {
      state(pet.petState.toString(), pet.petCountry.toString());
    }
    if (districtonetime == true) {
      district(pet.petState.toString(), pet.petDistrict.toString());
    }

    print(formattedDate); // 05-October-2021
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      appBar: const CommonAppBar(),

      /// 🔝 HEADER
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.primarycolor,
            centerTitle: true,

            title: LayoutBuilder(
              builder: (context, constraints) {
                final settings = context
                    .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
                final isCollapsed = settings == null
                    ? false
                    : settings.currentExtent <= kToolbarHeight + 20;

                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isCollapsed ? 1 : 0,
                  child: Text(
                    pet.petName.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),

            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primarycolor, AppColors.secondrycolor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FullScreenImage(imageUrl: pet.petImage.toString()),
                            ),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  pet.petImage.toString() == "null" ||
                                      pet.petImage.toString().isEmpty
                                  ? AssetImage("assest/bblogo.png") as ImageProvider
                                  : NetworkImage(
                                      "https://pashuraktkosh.lyferp.com/${pet.petImage.toString()}",
                                    ),
                            ).animate().fadeIn(duration: 400.ms).scale(),
                            if (pet.petExpireDate.toString() == "null")
                              Positioned(
                                bottom: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () async {
                                    navigatorKey.currentState?.pushNamed(
                                      '/updatepetDetails',
                                      arguments: pet,
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primarycolor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(Icons.edit, color: Colors.white, size: 18),
                                  ),
                                ).animate().fadeIn(delay: 300.ms).scale(),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      /// 👇 Name visible when expanded
                      Text(
                        pet.petName.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        pet.petCategoryId.toString() == "1" ? "Dog" : "Cat",
                        style: const TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// 📄 CONTENT
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// BASIC INFO CARD
                  infoCard(
                    title: "Basic Information",
                    children: [
                      infoRow(
                        "Pet ID",
                        pet.petBirthDate.toString().replaceAll("-", "") + pet.petId.toString(),
                      ),
                      infoRow("Gender", pet.petGender == "1" ? "Male" : "Female"),
                      infoRow("Breeed Name", BreeedName),
                      infoRow("Date of Birth", formattedDate),

                      infoRow(
                        "Is Pet Alive",
                        pet.petExpireDate.toString() == "null" ? "Yes" : "No",
                      ),
                      if (pet.petWeightInKg.toString() != "null")
                        infoRow("Weight", "${pet.petWeightInKg} KG"),
                      infoRow(
                        "Last Donate Date",
                        pet.lastDonateDate.toString().replaceAll("-", "-"),
                      ),
                      if (pet.petAddress.toString() != "null")
                        infoRowforaddress(
                          "Address",
                          pet.petAddress.toString() +
                              " " +
                              pet.petCity.toString() +
                              ", " +
                              districtName +
                              ", " +
                              stateName +
                              ", " +
                              countryName +
                              ", " +
                              pet.petPinCode.toString(),
                        ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// STATUS SECTION
                  infoCard(
                    title: "Medical Status",
                    children: [
                      statusTile(
                        "Microchip",
                        pet.microchipNumber,
                        Icons.memory,
                        () => pet.petExpireDate.toString() == "null"
                            ? navigatorKey.currentState?.pushNamed('/petmicrochip', arguments: pet)
                            : null,
                      ),
                      statusTile(
                        "Health Information",
                        pet.healthinfo,
                        Icons.favorite,
                        () => pet.petExpireDate.toString() == "null"
                            ? navigatorKey.currentState?.pushNamed('/petHealthinfo', arguments: pet)
                            : null,
                      ),
                      statusTile(
                        "Vaccination",
                        pet.vaccinationinfo,
                        Icons.vaccines,
                        () => pet.petExpireDate.toString() == "null"
                            ? navigatorKey.currentState?.pushNamed(
                                '/petvaccinationdetails',
                                arguments: pet,
                              )
                            : null,
                      ),
                      statusTile(
                        "Medications",
                        pet.medicationinfo,
                        Icons.medication,
                        () => pet.petExpireDate.toString() == "null"
                            ? navigatorKey.currentState?.pushNamed(
                                '/petmedications',
                                arguments: pet,
                              )
                            : null,
                      ),
                      statusTile(
                        "Veterinarian",
                        pet.veterinarian,
                        Icons.local_hospital,
                        () => pet.petExpireDate.toString() == "null"
                            ? navigatorKey.currentState?.pushNamed(
                                '/petveterinarianinfo',
                                arguments: pet,
                              )
                            : null,
                      ),
                      petstatusTile(
                        "Is Pet Alive",
                        pet.petExpireDate,
                        Icons.heart_broken_sharp,
                        () => pet.petExpireDate.toString() == "null"
                            ? navigatorKey.currentState?.pushNamed('/Expiredate', arguments: pet)
                            : null,
                      ),
                      statusTile(
                        "Last Blood Donate date",
                        pet.veterinarian,
                        Icons.bloodtype_sharp,
                        () => pet.petExpireDate.toString() == "null"
                            ? navigatorKey.currentState?.pushNamed(
                                '/BloodDonatePetInfo',
                                arguments: pet,
                              )
                            : null,
                      ),
                    ],
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),

      /// 🔘 BOTTOM ACTION
      ///
      ///
      ///
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primarycolor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            minimumSize: const Size(double.infinity, 52),
          ),
          onPressed: () {
            navigatorKey.currentState?.pushNamed('/petWeightupdate', arguments: pet);
          },
          icon: const Icon(Icons.monitor_weight, color: Colors.white),
          label: const Text(
            "Update Weight",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  /// 📦 CARD
  Widget infoCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primarycolor,
            ),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2);
  }

  /// 📄 ROW
  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondrycolor),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoRowforaddress(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondrycolor),
            ),
          ),
        ],
      ),
    );
  }

  /// 🩺 STATUS TILE
  Widget statusTile(String title, dynamic value, IconData icon, VoidCallback onTap) {
    bool done = value.toString() != "null";

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: done ? AppColors.successGreen : AppColors.mediumRed,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(done ? "Completed" : "Pending"),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}

/// 🩺 STATUS TILE
Widget petstatusTile(String title, dynamic value, IconData icon, VoidCallback onTap) {
  bool done = value.toString() == "null";

  return ListTile(
    onTap: onTap,
    leading: CircleAvatar(
      backgroundColor: done ? AppColors.successGreen : AppColors.mediumRed,
      child: Icon(icon, color: Colors.white),
    ),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(done ? "Yes" : "No"),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
  );
}

/// ---------- Widgets ----------

Widget _actionButton({required String text, required IconData icon, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.primarycolor,

        //   gradient: const LinearGradient(
        //     colors: [AppColors.darkRed, AppColors.mediumRed],
        //     begin: Alignment.centerLeft,
        //     end: Alignment.centerRight,
        //   ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

/// 💬 COMMENT BOTTOM SHEET
void _showCommentSheet(BuildContext context) {
  final TextEditingController commentCtrl = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      return Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add Comment",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkRed),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: commentCtrl,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write your comment...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkRed),
                onPressed: () {
                  print("Comment: ${commentCtrl.text}");
                  Navigator.pop(context);
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _detailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark),
          ),
        ),
        Text(value.isNotEmpty ? value : "-", style: const TextStyle(color: Colors.black54)),
      ],
    ),
  );
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: imageUrl == "null" || imageUrl.isEmpty
            ? Image.asset("assest/bblogo.png")
            : Image.network("https://pashuraktkosh.lyferp.com/${imageUrl}"),
      ),
    );
  }
}
