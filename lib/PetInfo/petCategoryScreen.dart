import 'package:bb/PetInfo/petCategoryModel.dart';
import 'package:bb/PetInfo/petCategoryController.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Petcategoryscreen extends StatefulWidget {
  const Petcategoryscreen({super.key});

  @override
  State<Petcategoryscreen> createState() => _PetcategoryscreenState();
}

class _PetcategoryscreenState extends State<Petcategoryscreen> {
  String getCategoryImage(String name) {
    final cleanName = name.replaceAll(RegExp(r'\s+'), ' ').trim().toLowerCase();

    switch (cleanName) {
      case 'cat':
        return 'assest/petcat.png';
      case 'dog':
        return 'assest/petdog.png';
      case 'horse':
        return 'assest/pethorse.png';
      case 'hamster':
        return 'assest/pethamster.png';
      case 'bird':
        return 'assest/petbird.png';
      case 'pony':
        return 'assest/petpony.png';
      case 'guinea pig':
        return 'assest/petguinee.png';
      case 'cattle':
        return 'assest/petcattle.png';
      default:
        return 'assest/petdefault.png'; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.border,
      appBar: AppBar(
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          "Select Species 🐾",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          await Petcategorycontroller.fetchPetsCategory(); // Reload data when user performs swipe gesture
          setState(() {});
        },
        child: FutureBuilder<List<Petcategorymodel>>(
          future: Petcategorycontroller.fetchPetsCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Categorys not found"));
            }

            final pets = snapshot.data!;

            return GridView.builder(
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              padding: const EdgeInsets.all(12),
              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];
                final categoryName = pet.categoryName;

                return GestureDetector(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed(
                      '/petRegistration',
                      arguments: pet.categoryId,
                    );
                  },
                  child: Container(
                    // color: AppColors.backgrounLightGrey,
                    margin: const EdgeInsets.symmetric(vertical: 5),

                    decoration: BoxDecoration(
                      color: AppColors.cardBackgroundWhite,

                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondrycolor,

                          // color: Colors.redAccent.withOpacity(0.4),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.cardBackgroundWhite,
                            radius: 52,
                            backgroundImage: AssetImage(getCategoryImage(categoryName.toString())),
                          ),
                          Text(
                            categoryName.toString().replaceAll(RegExp(r'\s+'), ' ').trim(),
                            style: const TextStyle(
                              color: AppColors.primarycolor,

                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      // ListTile(
                      //   leading: CircleAvatar(
                      //     radius: 22,
                      //     backgroundImage: AssetImage(getCategoryImage(categoryName.toString())),
                      //   ),
                      //   title: Text(categoryName.toString().replaceAll(RegExp(r'\s+'), ' ').trim()),
                      // ),
                      //  Row(
                      //   children: [
                      //     // 🐶 Pet Image
                      //     // const SizedBox(width: 10),

                      //     // 📄 Pet Info
                      //     Expanded(
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Row(
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               const Icon(
                      //                 Icons.bloodtype,
                      //                 color: AppColors.secondrycolor,
                      //                 size: 18,
                      //               ),
                      //               const SizedBox(width: 6),
                      //               Text(
                      //                 pet.categoryName
                      //                     .toString()
                      //                     .replaceAll(RegExp(r'\s+'), ' ')
                      //                     .trim(),
                      //                 style: const TextStyle(
                      //                   color: AppColors.primarycolor,

                      //                   fontSize: 15,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),

                      //           const SizedBox(height: 6),
                      //         ],
                      //       ),
                      //     ),

                      //     // ➡️ Action Icon
                      //     // GestureDetector(
                      //     //   onTap: () {
                      //     //     navigatorKey.currentState?.pushNamed('/petDetails', arguments: pet);
                      //     //   },
                      //     //   child: Container(
                      //     //     padding: const EdgeInsets.all(8),
                      //     //     decoration: BoxDecoration(
                      //     //       color: Colors.white.withOpacity(0.15),
                      //     //       shape: BoxShape.circle,
                      //     //     ),
                      //     //     child: const Icon(
                      //     //       Icons.arrow_forward_ios,
                      //     //       color: AppColors.primarycolor,
                      //     //       size: 16,
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
