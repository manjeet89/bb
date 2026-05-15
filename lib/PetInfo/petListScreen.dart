import 'package:bb/Header.dart';
import 'package:bb/PetInfo/PetListController.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  bool _loginCheck = false;
  bool sessionset = true;

  @override
  void initState() {
    super.initState();
    // _fetchProfile();
    LoginCheck();
  }

  // Future<void> _fetchProfile() async {
  //   var url = allapiscreen.userprofile.toString();
  //   var header = await allapiscreen.headerFunction();

  //   final response = await http.post(Uri.parse(url), headers: header);

  //   if (response.statusCode == 200) {
  //     final decoded = json.decode(response.body);
  //     setState(() async {
  //       SharedPreferences FontEmpTypeName = await SharedPreferences.getInstance();
  //       await FontEmpTypeName.setString("FirstName", decoded['data']['user_first_name'] ?? "");
  //     });
  //   }
  // }

  Future<void> LoginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String isName = prefs.getString("DateOfBirth") ?? "";
    if (isName == "") {
      setState(() {
        sessionset = true;
      });
    } else {
      setState(() {
        sessionset = false;
      });
    }
    if (!isLoggedIn) {
      setState(() {
        _loginCheck = true;
      });
    }
  }

  Map<String, dynamic> getDonationStatus(String date) {
    if (date == null || date.isEmpty) {
      return {
        "text": "Never Donated, Can Donate Today",
        "color": AppColors.AddButtonColor, // or Colors.red
      };
    } else {
      final parts = date.split('-');

      DateTime petDate = DateTime(
        int.parse(parts[0]), // year
        int.parse(parts[1]), // month
        int.parse(parts[2]), // day
      );

      DateTime nextDonationDate = petDate.add(const Duration(days: 90));
      DateTime today = DateTime.now();

      if (today.isAfter(nextDonationDate) || today.isAtSameMomentAs(nextDonationDate)) {
        return {"text": "Can donate today", "color": Colors.green};
      } else {
        int remainingDays = nextDonationDate.difference(today).inDays;

        return {
          "text": "Can donate in $remainingDays days",
          "color": AppColors.CatSilhouter, // or Colors.red
        };
      }
    }
  }

  /// ✅ Donation Logic
  // Map<String, dynamic> getDonationStatus(String date) {
  //   final parts = date.split('-');

  //   DateTime petDate = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));

  //   DateTime nextDonationDate = petDate.add(const Duration(days: 90));
  //   DateTime today = DateTime.now();

  //   if (today.isAfter(nextDonationDate) || today.isAtSameMomentAs(nextDonationDate)) {
  //     return {"text": "Now you can donate today", "color": Colors.green};
  //   } else {
  //     int remainingDays = nextDonationDate.difference(today).inDays;

  //     return {"text": "$remainingDays days left", "color": Colors.orange};
  //   }
  // }

  /// ✅ Check Dead Pet
  bool isPetDead(String? deathDate) {
    return deathDate != null && deathDate.isNotEmpty && deathDate != "null";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      // appBar: AppBar(
      //   backgroundColor: AppColors.primarycolor,
      //   title: const Text(
      //     "My Pets 🐾",
      //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // )
      appBar: const CommonAppBar(),
      floatingActionButton: _loginCheck
          ? null
          : sessionset
          ? null
          : FloatingActionButton(
              backgroundColor: AppColors.AddButtonColor,
              onPressed: () {
                navigatorKey.currentState?.pushNamed('/petCategoryScreen');
              },
              child: const Icon(Icons.add, color: AppColors.white),
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
                    return const Center(child: Text("Complete your profile to add your first pet"));
                  }

                  final pets = snapshot.data!;

                  /// ✅ Split Lists
                  final alivePets = pets
                      .where(
                        (pet) =>
                            pet.petExpireDate == null ||
                            pet.petExpireDate.toString().isEmpty ||
                            pet.petExpireDate.toString() == "null",
                      )
                      .toList();

                  CallSpeciesCountFuncation(alivePets);

                  final deadPets = pets
                      .where(
                        (pet) =>
                            pet.petExpireDate != null &&
                            pet.petExpireDate.toString().isNotEmpty &&
                            pet.petExpireDate.toString() != "null",
                      )
                      .toList();

                  return ListView(
                    padding: const EdgeInsets.all(12),
                    children: [
                      /// 🐾 ALIVE PETS
                      ...alivePets.map((pet) {
                        String image = pet.petImage.toString();
                        List dateSplit = pet.petBirthDate.toString().split(" ");
                        String petId = "${dateSplit[0].replaceAll("-", "")}${pet.petId}";

                        return petCard(pet, petId, image);
                      }),

                      /// 💔 REST IN PEACE SECTION
                      if (deadPets.isNotEmpty) ...[
                        const SizedBox(height: 20),

                        Row(
                          children: [
                            const Icon(Icons.favorite, color: Colors.red),
                            const SizedBox(width: 6),
                            Text(
                              "Rest in Peace (${deadPets.length})",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        ...deadPets.map((pet) {
                          String image = pet.petImage.toString();
                          List dateSplit = pet.petBirthDate.toString().split(" ");
                          String petId = "${dateSplit[0].replaceAll("-", "")}${pet.petId}";

                          return petCard(pet, petId, image);
                        }),
                      ],
                    ],
                  );
                },
              ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: const Color(0xffF4F6FA),

  //     appBar: AppBar(
  //       backgroundColor: AppColors.primarycolor,
  //       title: const Text(
  //         "My Pets 🐾",
  //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //       ),
  //       centerTitle: true,
  //     ),

  //     floatingActionButton: _loginCheck
  //         ? null
  //         : sessionset
  //         ? null
  //         : FloatingActionButton(
  //             backgroundColor: AppColors.primarycolor,
  //             onPressed: () {
  //               navigatorKey.currentState?.pushNamed('/petCategoryScreen');
  //             },
  //             child: const Icon(Icons.add, color: Colors.white),
  //           ),

  //     body: RefreshIndicator(
  //       onRefresh: () async {
  //         await PetService.fetchPets();
  //         setState(() {});
  //       },
  //       child: _loginCheck
  //           ? Center(
  //               child: ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: AppColors.primarycolor,
  //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //                 ),
  //                 onPressed: () {
  //                   navigatorKey.currentState?.pushNamed('/login');
  //                 },
  //                 child: const Text("Go to Login", style: TextStyle(color: Colors.white)),
  //               ),
  //             )
  //           : FutureBuilder<List<Petlistmodel>>(
  //               future: PetService.fetchPets(),
  //               builder: (context, snapshot) {
  //                 if (snapshot.connectionState == ConnectionState.waiting) {
  //                   return const Center(child: CircularProgressIndicator());
  //                 }

  //                 if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //                   return const Center(child: Text("No pets found"));
  //                 }

  //                 // final pets = snapshot.data!;

  //                 final pets = snapshot.data!;

  //                 /// ✅ Split Lists
  //                 final alivePets = pets
  //                     .where(
  //                       (pet) =>
  //                           pet.petExpireDate == null ||
  //                           pet.petExpireDate.toString().isEmpty ||
  //                           pet.petExpireDate.toString() == "null",
  //                     )
  //                     .toList();

  //                 final deadPets = pets
  //                     .where(
  //                       (pet) =>
  //                           pet.petExpireDate != null &&
  //                           pet.petExpireDate.toString().isNotEmpty &&
  //                           pet.petExpireDate.toString() != "null",
  //                     )
  //                     .toList();

  //                 return AnimatedList(
  //                   key: _listKey,
  //                   padding: const EdgeInsets.all(12),
  //                   initialItemCount: pets.length,
  //                   itemBuilder: (context, index, animation) {
  //                     final pet = pets[index];

  //                     String image = pet.petImage.toString();
  //                     List dateSplit = pet.petBirthDate.toString().split(" ");
  //                     String petId = "${dateSplit[0].replaceAll("-", "")}${pet.petId}";

  //                     return SizeTransition(
  //                       sizeFactor: animation,
  //                       child: petCard(pet, petId, image)
  //                           .animate()
  //                           .fadeIn(duration: 400.ms)
  //                           .slideY(begin: 0.2)
  //                           .scale(begin: const Offset(0.95, 0.95)),
  //                     );
  //                   },
  //                 );
  //               },
  //             ),
  //     ),
  //   );
  // }

  /// 🐶 PET CARD UI
  Widget petCard(Petlistmodel pet, String petId, String image) {
    bool isDead = isPetDead(pet.petExpireDate);

    Map<String, dynamic>? donationStatus;
    if (!isDead) {
      donationStatus = getDonationStatus(pet.lastDonateDate.toString());
    }
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
            // Container(
            //   padding: const EdgeInsets.all(4),
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     gradient: LinearGradient(colors: [AppColors.primarycolor, AppColors.secondrycolor]),
            //   ),
            //   child: CircleAvatar(
            //     radius: 34,
            //     backgroundColor: Colors.white,
            //     backgroundImage: image == "null" || image.isEmpty
            //         ? const AssetImage("assest/bblogo.png") as ImageProvider
            //         : NetworkImage("https://pashuraktkosh.lyferp.com/$image"),
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(colors: [AppColors.primarycolor, AppColors.secondrycolor]),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 68,
                  height: 68,
                  color: Colors.white,
                  child: Image(
                    fit: BoxFit.cover,
                    image: image == "null" || image.isEmpty
                        ? const AssetImage("assest/catdog.jpeg")
                        : NetworkImage("https://pashuraktkosh.lyferp.com/$image") as ImageProvider,
                  ),
                ),
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
                          color: AppColors.AddButtonColor,
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

                  Row(
                    children: [
                      Text(
                        pet.petCategoryId.toString() == "1" ? "Dog" : "Cat",
                        style: const TextStyle(
                          color: AppColors.fontGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),

                      // Text(
                      //   "Donate: ",
                      //   style: TextStyle(
                      //     fontSize: 13,
                      //     fontWeight: FontWeight.w600,
                      //     color: donationStatus != null ? donationStatus["color"] : Colors.grey,
                      //   ),
                      // ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "ID: $petId",
                    style: const TextStyle(fontSize: 12, color: AppColors.fontGrey),
                  ),

                  Text(
                    donationStatus != null ? donationStatus["text"] : "No donation info",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: donationStatus != null ? donationStatus["color"] : Colors.grey,
                    ),
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
                  // ❤️ RIP INSIDE CARD
                  if (isDead) ...[
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        "Rest in peace 🕊️",
                        style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
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
              : [AppColors.AddButtonColor, AppColors.CatSilhouter],
          // [AppColors.darkRed, AppColors.mediumRed],
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

void CallSpeciesCountFuncation(List<Petlistmodel> alivePets) async {
  int dogCount = 0;
  int catCount = 0;

  for (var pet in alivePets) {
    if (pet.petCategoryId.toString() == "1") {
      dogCount++;
    } else if (pet.petCategoryId.toString() == "2") {
      catCount++;
    }
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('Total_Dog', dogCount.toString());
  await prefs.setString('Total_Cat', catCount.toString());

  print("Dogs: $dogCount");
  print("Cats: $catCount");
  // pet.petCategoryId.toString() == "1" ? "Dog" : "Cat",
}

// import 'package:bb/PetInfo/PetListController.dart';
// import 'package:bb/PetInfo/petListModel.dart';
// import 'package:bb/main.dart';
// import 'package:bb/utils/app_colors.dart';
// import 'package:flutter/material.dart';

// class PetListScreen extends StatefulWidget {
//   const PetListScreen({super.key});

//   @override
//   State<PetListScreen> createState() => _PetListScreenState();
// }

// class _PetListScreenState extends State<PetListScreen> {
//   /// ✅ Donation Logic
//   Map<String, dynamic> getDonationStatus(String date) {
//     final parts = date.split('-');

//     DateTime petDate = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));

//     DateTime nextDonationDate = petDate.add(const Duration(days: 90));
//     DateTime today = DateTime.now();

//     if (today.isAfter(nextDonationDate) || today.isAtSameMomentAs(nextDonationDate)) {
//       return {"text": "Now you can donate today", "color": Colors.green};
//     } else {
//       int remainingDays = nextDonationDate.difference(today).inDays;

//       return {"text": "$remainingDays days left", "color": Colors.orange};
//     }
//   }

//   /// ✅ Check Dead Pet
//   bool isPetDead(String? deathDate) {
//     return deathDate != null && deathDate.isNotEmpty && deathDate != "null";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF4F6FA),

//       appBar: AppBar(
//         backgroundColor: AppColors.primarycolor,
//         title: const Text(
//           "My Pets 🐾",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),

//       body: FutureBuilder<List<Petlistmodel>>(
//         future: PetService.fetchPets(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final pets = snapshot.data!;

//           /// ✅ Split Lists
//           final alivePets = pets
//               .where(
//                 (pet) =>
//                     pet.petExpireDate == null ||
//                     pet.petExpireDate.toString().isEmpty ||
//                     pet.petExpireDate.toString() == "null",
//               )
//               .toList();

//           final deadPets = pets
//               .where(
//                 (pet) =>
//                     pet.petExpireDate != null &&
//                     pet.petExpireDate.toString().isNotEmpty &&
//                     pet.petExpireDate.toString() != "null",
//               )
//               .toList();

//           return ListView(
//             padding: const EdgeInsets.all(12),
//             children: [
//               /// 🐾 ALIVE PETS
//               ...alivePets.map((pet) {
//                 String image = pet.petImage.toString();
//                 List dateSplit = pet.petBirthDate.toString().split(" ");
//                 String petId = "${dateSplit[0].replaceAll("-", "")}${pet.petId}";

//                 return petCard(pet, petId, image);
//               }),

//               /// 💔 REST IN PEACE SECTION
//               if (deadPets.isNotEmpty) ...[
//                 const SizedBox(height: 20),

//                 Row(
//                   children: [
//                     const Icon(Icons.favorite, color: Colors.red),
//                     const SizedBox(width: 6),
//                     Text(
//                       "Rest in Peace (${deadPets.length})",
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 10),

//                 ...deadPets.map((pet) {
//                   String image = pet.petImage.toString();
//                   List dateSplit = pet.petBirthDate.toString().split(" ");
//                   String petId = "${dateSplit[0].replaceAll("-", "")}${pet.petId}";

//                   return petCard(pet, petId, image);
//                 }),
//               ],
//             ],
//           );
//         },
//       ),
//     );
//   }

//   /// 🐶 PET CARD
//   Widget petCard(Petlistmodel pet, String petId, String image) {
//     bool isDead = isPetDead(pet.petExpireDate);

//     Map<String, dynamic>? donationStatus;
//     if (!isDead) {
//       donationStatus = getDonationStatus(pet.petBirthDate.toString());
//     }

//     return GestureDetector(
//       onTap: () {
//         navigatorKey.currentState?.pushNamed('/petDetails', arguments: pet);
//       },
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 10),
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: isDead ? Colors.grey.shade100 : Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 12,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             /// IMAGE
//             CircleAvatar(
//               radius: 34,
//               backgroundColor: Colors.white,
//               backgroundImage: image == "null" || image.isEmpty
//                   ? const AssetImage("assest/bblogo.png")
//                   : NetworkImage("https://pashuraktkosh.lyferp.com/$image"),
//             ),

//             const SizedBox(width: 14),

//             /// DETAILS
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   /// NAME
//                   Text(
//                     pet.petName.toString(),
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: isDead ? Colors.grey : AppColors.primarycolor,
//                     ),
//                   ),

//                   const SizedBox(height: 4),

//                   /// CATEGORY + DONATION
//                   Row(
//                     children: [
//                       Text(
//                         pet.petCategoryId.toString() == "1" ? "Dog" : "Cat",
//                         style: const TextStyle(
//                           color: AppColors.fontGrey,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),

//                       if (!isDead) ...[
//                         const SizedBox(width: 8),
//                         Text(
//                           donationStatus!["text"],
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                             color: donationStatus["color"],
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),

//                   const SizedBox(height: 4),

//                   Text(
//                     "ID: $petId",
//                     style: const TextStyle(fontSize: 12, color: AppColors.fontGrey),
//                   ),

//                   const SizedBox(height: 10),

//                   /// STATUS CHIPS
//                   Wrap(
//                     spacing: 6,
//                     runSpacing: 6,
//                     children: [
//                       statusChip("Micro", pet.microchipNumber),
//                       statusChip("Health", pet.healthinfo),
//                       statusChip("Vaccine", pet.vaccinationinfo),
//                       statusChip("Medicine", pet.medicationinfo),
//                       statusChip("Vet", pet.veterinarian),
//                     ],
//                   ),

//                   /// ❤️ RIP INSIDE CARD
//                   if (isDead) ...[
//                     const SizedBox(height: 10),
//                     Center(
//                       child: Text(
//                         "Rest in peace 🕊️",
//                         style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// STATUS CHIP
//   Widget statusChip(String title, dynamic value) {
//     bool done = value.toString() != "null";

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: done ? Colors.green : Colors.red,
//       ),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
