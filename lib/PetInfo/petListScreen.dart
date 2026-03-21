// import 'package:bb/PetInfo/PetListController.dart';
// import 'package:bb/PetInfo/petListModel.dart';
// import 'package:bb/main.dart';
// import 'package:bb/utils/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PetListScreen extends StatefulWidget {
//   const PetListScreen({super.key});

//   @override
//   State<PetListScreen> createState() => _PetListScreenState();
// }

// class _PetListScreenState extends State<PetListScreen> {
//   final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     LoginCheck();
//   }

//   bool _loginCheck = false;

//   Future<void> LoginCheck() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//     print(isLoggedIn.toString());
//     if (isLoggedIn.toString() == "false") {
//       setState(() {
//         _loginCheck = true;
//       });
//     }
//     // setState(() {

//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 245, 245, 247),
//       appBar: AppBar(
//         backgroundColor: AppColors.primarycolor,
//         title: const Text(
//           "My Pets 🐾",
//           style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),

//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       floatingActionButton: _loginCheck == true
//           ? Text("")
//           : FloatingActionButton(
//               backgroundColor: AppColors.primarycolor,
//               foregroundColor: Colors.white,
//               onPressed: () {
//                 setState(() {
//                   // navigatorKey.currentState?.pushNamed('/petRegistration');
//                   navigatorKey.currentState?.pushNamed('/petCategoryScreen');
//                 });
//               },
//               child: Icon(Icons.add),
//             ),

//       body: RefreshIndicator(
//         onRefresh: () async {
//           await PetService.fetchPets(); // Reload data when user performs swipe gesture
//           setState(() {});
//         },
//         child: _loginCheck == true
//             ? Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primarycolor,
//                     // Primary red
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   onPressed: () async {
//                     await navigatorKey.currentState?.pushNamed('/login');
//                   },
//                   child: const Text('Go to Login', style: TextStyle(color: Colors.white)),
//                 ),
//               )
//             : FutureBuilder<List<Petlistmodel>>(
//                 future: PetService.fetchPets(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Center(child: Text("No pets found"));
//                   }

//                   final pets = snapshot.data!;

//                   return AnimatedList(
//                     key: _listKey,
//                     padding: const EdgeInsets.all(8),
//                     initialItemCount: pets.length,
//                     itemBuilder: (context, index, animation) {
//                       final pet = pets[index];
//                       List reqnumber = pet.petBirthDate.toString().split(" ");
//                       String req = reqnumber[0];
//                       String image = pet.petImage.toString();
//                       if (image == "null") {
//                         image = "null";
//                       }

//                       return SizeTransition(
//                         sizeFactor: animation,
//                         child: GestureDetector(
//                           onTap: () {
//                             navigatorKey.currentState?.pushNamed('/petDetails', arguments: pet);
//                           },
//                           child: Container(
//                             // color: AppColors.backgrounLightGrey,
//                             margin: const EdgeInsets.symmetric(vertical: 5),

//                             // decoration: BoxDecoration(
//                             //   gradient: const LinearGradient(
//                             //     colors: [
//                             //       Color(0xff8B0000), // Dark Red
//                             //       Color(0xffB11226), // Blood Red
//                             //     ],
//                             //     begin: Alignment.topLeft,
//                             //     end: Alignment.bottomRight,
//                             //   ),
//                             //   borderRadius: BorderRadius.circular(20),
//                             //   boxShadow: [
//                             //     BoxShadow(
//                             //       color: Colors.red.withOpacity(0.4),
//                             //       blurRadius: 10,
//                             //       offset: const Offset(0, 6),
//                             //     ),
//                             //   ],
//                             // ),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: AppColors.secondrycolor.withOpacity(0.2),
//                                   blurRadius: 2,
//                                   offset: const Offset(1, 2),
//                                 ),
//                               ],
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(255, 255, 255, 255),
//                                   Color.fromARGB(255, 255, 255, 255),
//                                 ],
//                               ),
//                             ),
                            

//                             // decoration: BoxDecoration(
//                             //   color: AppColors.border,

//                             //   // gradient: const LinearGradient(
//                             //   //   colors: [
//                             //   //     Color(0xff7A0000), // Dark blood red (LEFT)
//                             //   //     Color(0xffC62828), // Medium red
//                             //   //     Color(0xffFF6F6F), // Light red (RIGHT)
//                             //   //   ],
//                             //   //   begin: Alignment.centerLeft,
//                             //   //   end: Alignment.centerRight,
//                             //   // ),
//                             //   borderRadius: BorderRadius.circular(20),
//                             //   boxShadow: [
//                             //     BoxShadow(
//                             //       color: AppColors.secondrycolor.withOpacity(0.4),

//                             //       // color: Colors.redAccent.withOpacity(0.4),
//                             //       blurRadius: 10,
//                             //       offset: const Offset(0, 6),
//                             //     ),
//                             //   ],
//                             // ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(14),
//                               child: Row(
//                                 children:
//                                     [
//                                           // 🐶 Pet Image
//                                           Container(
//                                             padding: const EdgeInsets.all(3),
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               shape: BoxShape.circle,
//                                             ),
//                                             child: CircleAvatar(
//                                               radius: 25,
//                                               backgroundImage: image == "null" || image == ""
//                                                   ? AssetImage("assest/bblogo.png") as ImageProvider
//                                                   : NetworkImage(
//                                                       "https://pashuraktkosh.lyferp.com/${pet.petImage}",
//                                                     ),
//                                             ),
//                                           ),

//                                           const SizedBox(width: 14),

//                                           // 📄 Pet Info
//                                           Expanded(
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     const Icon(
//                                                       Icons.bloodtype,
//                                                       color: AppColors.successGreen,
//                                                       size: 18,
//                                                     ),
//                                                     const SizedBox(width: 6),
//                                                     Text(
//                                                       pet.petName.toString(),
//                                                       style: const TextStyle(
//                                                         color: AppColors.primarycolor,

//                                                         fontSize: 18,
//                                                         fontWeight: FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),

//                                                 const SizedBox(height: 6),

//                                                 Text(
//                                                   "${req.replaceAll("-", "")}${pet.petId}",
//                                                   style: const TextStyle(
//                                                     color: AppColors.fontGrey,

//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   pet.petGender.toString() == "1"
//                                                       ? "Male"
//                                                       : "Female",
//                                                   style: const TextStyle(
//                                                     color: AppColors.fontGrey,

//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   pet.petCategoryName.toString(),
//                                                   style: const TextStyle(
//                                                     color: AppColors.fontGrey,

//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                                 SizedBox(height: 10),
//                                                 // if (pet.microchipNumber.toString() != "null")
//                                                 Checkvaluecompletedornot(pet),
//                                               ],
//                                             ),
//                                           ),

//                                           // ➡️ Action Icon
//                                           GestureDetector(
//                                             onTap: () {
//                                               navigatorKey.currentState?.pushNamed(
//                                                 '/petDetails',
//                                                 arguments: pet,
//                                               );
//                                             },
//                                             child: Container(
//                                               padding: const EdgeInsets.all(8),
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white.withOpacity(0.15),
//                                                 shape: BoxShape.circle,
//                                               ),
//                                               child: const Icon(
//                                                 Icons.arrow_forward_ios,
//                                                 color: AppColors.successGreen,
//                                                 size: 16,
//                                               ),
//                                             ),
//                                           ),
//                                         ]
//                                         .animate().fadeIn(delay: 200.ms).slideX(),
//                                 // .animate().fade().scale()
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//       ),
//     );
//   }

//   Row Checkvaluecompletedornot(Petlistmodel pet) {
//     return Row(
//       children: [
//         Container(
//           width: 30,
//           height: 30,
//           decoration: pet.microchipNumber.toString() != "null"
//               ? BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.secondrycolor.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: const Offset(1, 2),
//                     ),
//                   ],
//                   gradient: const LinearGradient(
//                     colors: [AppColors.secondrycolor, AppColors.successGreen],
//                   ),
//                 )
//               : BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.secondrycolor.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: const Offset(1, 2),
//                     ),
//                   ],
//                   gradient: const LinearGradient(colors: [AppColors.darkRed, AppColors.mediumRed]),
//                 ),
//           child: Center(
//             child: Text(
//               "Mic",
//               style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(left: 8),
//           width: 30,
//           height: 30,
//           decoration: pet.healthinfo.toString() != "null"
//               ? BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.secondrycolor.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: const Offset(1, 2),
//                     ),
//                   ],
//                   gradient: const LinearGradient(
//                     colors: [AppColors.secondrycolor, AppColors.successGreen],
//                   ),
//                 )
//               : BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.secondrycolor.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: const Offset(1, 2),
//                     ),
//                   ],
//                   gradient: const LinearGradient(colors: [AppColors.darkRed, AppColors.mediumRed]),
//                 ),
//           child: Center(
//             child: Text(
//               "Hea",
//               style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(left: 8),
//           width: 30,
//           height: 30,
//           decoration: pet.vaccinationinfo.toString() != "null"
//               ? BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.secondrycolor.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: const Offset(1, 2),
//                     ),
//                   ],
//                   gradient: const LinearGradient(
//                     colors: [AppColors.secondrycolor, AppColors.successGreen],
//                   ),
//                 )
//               : BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.secondrycolor.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: const Offset(1, 2),
//                     ),
//                   ],
//                   gradient: const LinearGradient(colors: [AppColors.darkRed, AppColors.mediumRed]),
//                 ),
//           child: Center(
//             child: Text(
//               "Vac",
//               style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(left: 8),
//           width: 30,
//           height: 30,
//           decoration: pet.medicationinfo.toString() != "null"
//               ? BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.secondrycolor.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: const Offset(1, 2),
//                     ),
//                   ],
//                   gradient: const LinearGradient(
//                     colors: [AppColors.secondrycolor, AppColors.successGreen],
//                   ),
//                 )
//               : BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.secondrycolor.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: const Offset(1, 2),
//                     ),
//                   ],
//                   gradient: const LinearGradient(colors: [AppColors.darkRed, AppColors.mediumRed]),
//                 ),
//           child: Center(
//             child: Text(
//               "Med",
//               style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(left: 8),
//           width: 30,
//           height: 30,
//           decoration: pet.veterinarian.toString() != "null"
//               ? BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.secondrycolor.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: const Offset(1, 2),
//                     ),
//                   ],
//                   gradient: const LinearGradient(
//                     colors: [AppColors.secondrycolor, AppColors.successGreen],
//                   ),
//                 )
//               : BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.secondrycolor.withOpacity(0.2),
//                       blurRadius: 10,
//                       offset: const Offset(1, 2),
//                     ),
//                   ],
//                   gradient: const LinearGradient(colors: [AppColors.darkRed, AppColors.mediumRed]),
//                 ),
//           child: Center(
//             child: Text(
//               "Vet",
//               style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:bb/PetInfo/PetListController.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  bool _loginCheck = false;

  @override
  void initState() {
    super.initState();
    LoginCheck();
  }

  Future<void> LoginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (!isLoggedIn) {
      setState(() {
        _loginCheck = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      appBar: AppBar(
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          "My Pets 🐾",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      floatingActionButton: _loginCheck
          ? null
          : FloatingActionButton(
              backgroundColor: AppColors.primarycolor,
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/petCategoryScreen');
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),

      body: RefreshIndicator(
        onRefresh: () async {
          await PetService.fetchPets();
          setState(() {});
        },
        child: _loginCheck
            ? Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarycolor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    navigatorKey.currentState?.pushNamed('/login');
                  },
                  child: const Text("Go to Login", style: TextStyle(color: Colors.white)),
                ),
              )
            : FutureBuilder<List<Petlistmodel>>(
                future: PetService.fetchPets(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No pets found"));
                  }

                  final pets = snapshot.data!;

                  return AnimatedList(
                    key: _listKey,
                    padding: const EdgeInsets.all(12),
                    initialItemCount: pets.length,
                    itemBuilder: (context, index, animation) {
                      final pet = pets[index];

                      String image = pet.petImage.toString();
                      List dateSplit = pet.petBirthDate.toString().split(" ");
                      String petId = "${dateSplit[0].replaceAll("-", "")}${pet.petId}";

                      return SizeTransition(
                        sizeFactor: animation,
                        child: petCard(pet, petId, image)
                            .animate()
                            .fadeIn(duration: 400.ms)
                            .slideY(begin: 0.2)
                            .scale(begin: const Offset(0.95, 0.95)),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }

  /// 🐶 PET CARD UI
  Widget petCard(Petlistmodel pet, String petId, String image) {
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState?.pushNamed('/petDetails', arguments: pet);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            /// IMAGE
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [AppColors.primarycolor, AppColors.secondrycolor]),
              ), 
              child: CircleAvatar(
                radius: 34,
                backgroundColor: Colors.white,
                backgroundImage: image == "null" || image.isEmpty
                    ? const AssetImage("assest/bblogo.png") as ImageProvider
                    : NetworkImage("https://pashuraktkosh.lyferp.com/$image"),
              ),
            ),

            const SizedBox(width: 14),

            /// DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// NAME + GENDER
                  Row(
                    children: [
                      Text(
                        pet.petName.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primarycolor,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        pet.petGender == "1" ? Icons.male : Icons.female,
                        size: 18,
                        color: AppColors.secondrycolor,
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    pet.petCategoryName.toString(),
                    style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "ID: $petId",
                    style: const TextStyle(fontSize: 12, color: AppColors.fontGrey),
                  ),

                  const SizedBox(height: 10),

                  /// STATUS CHIPS
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      statusChip("Micro", pet.microchipNumber),
                      statusChip("Health", pet.healthinfo),
                      statusChip("Vaccine", pet.vaccinationinfo),
                      statusChip("Medicine", pet.medicationinfo),
                      statusChip("Vet", pet.veterinarian),
                    ],
                  ),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.secondrycolor),
          ],
        ),
      ),
    );
  }

  /// 🏷 STATUS CHIP
  Widget statusChip(String title, dynamic value) {
    bool done = value.toString() != "null";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: done
              ? [AppColors.secondrycolor, AppColors.successGreen]
              : [AppColors.darkRed, AppColors.mediumRed],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(done ? Icons.check_circle : Icons.error, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
