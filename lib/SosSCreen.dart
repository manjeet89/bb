import 'package:bb/PetInfo/PetListController.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Sosscreen extends StatefulWidget {
  const Sosscreen({super.key});

  @override
  State<Sosscreen> createState() => _SosscreenState();
}

class _SosscreenState extends State<Sosscreen> {
  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          "My Pets 🐾",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: FutureBuilder<List<Petlistmodel>>(
        future: PetService.fetchPets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No pets found"));
          }

          final pets = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: pets.length,
            itemBuilder: (context, index) {
              final pet = pets[index];
              List reqnumber = pet.petBirthDate.toString().split(" ");
              String req = reqnumber[0];

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),

                // decoration: BoxDecoration(
                //   gradient: const LinearGradient(
                //     colors: [
                //       Color(0xff8B0000), // Dark Red
                //       Color(0xffB11226), // Blood Red
                //     ],
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //   ),
                //   borderRadius: BorderRadius.circular(20),
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.red.withOpacity(0.4),
                //       blurRadius: 10,
                //       offset: const Offset(0, 6),
                //     ),
                //   ],
                // ),
                decoration: BoxDecoration(
                  color: AppColors.backgrounLightGrey,
                  // gradient: const LinearGradient(
                  //   colors: [
                  //     Color(0xff7A0000), // Dark blood red (LEFT)
                  //     Color(0xffC62828), // Medium red
                  //     Color(0xffFF6F6F), // Light red (RIGHT)
                  //   ],
                  //   begin: Alignment.centerLeft,
                  //   end: Alignment.centerRight,
                  // ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.fontGrey.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      // 🐶 Pet Image
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: CircleAvatar(
                          radius: 34,
                          backgroundImage: pet.petImage!.isNotEmpty
                              ? NetworkImage("https://pashuraktkosh.lyferp.com/${pet.petImage}")
                              : const AssetImage("assest/bblogo.png") as ImageProvider,
                        ),
                      ),

                      const SizedBox(width: 14),

                      // 📄 Pet Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.bloodtype,
                                  color: AppColors.secondrycolor,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  pet.petName.toString(),
                                  style: const TextStyle(
                                    color: AppColors.primarycolor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            Text(
                              "Pet ID    : ${req.replaceAll("-", "")}${pet.petId}",
                              style: const TextStyle(
                                color: AppColors.fontGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Gender  : ${pet.petGender.toString() == "1" ? "Male" : "Female"}",
                              style: const TextStyle(
                                color: AppColors.fontGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Country : ${pet.countryBredIn}",
                              style: const TextStyle(
                                color: AppColors.fontGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ➡️ Action Icon
                      GestureDetector(
                        onTap: () {
                          scaffoldMessenger.showSnackBar(
                            SnackBar(
                              content: Text('Calling for SOS'),
                              backgroundColor: Colors.redAccent, // Red for errors
                              behavior: SnackBarBehavior.floating, // Modern floating look
                              duration: Duration(seconds: 3),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primarycolor,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ); //   margin: const EdgeInsets.only(bottom: 12),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(16),
              //     boxShadow: [
              //       BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
              //     ],
              //   ),
              //   child: ListTile(
              //     contentPadding: const EdgeInsets.all(12),
              //     leading: CircleAvatar(
              //       radius: 30,
              //       backgroundImage: pet.petImage!.isNotEmpty
              //           ? NetworkImage("https://pashuraktkosh.lyferp.com/${pet.petImage}")
              //           : const AssetImage("assets/pet.png") as ImageProvider,
              //     ),
              //     title: Text(
              //       pet.petName!,
              //       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              //     ),
              //     subtitle: Padding(
              //       padding: const EdgeInsets.only(top: 6),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text("Gender: ${pet.petGender}"),
              //           Text("DOB: ${pet.petBirthDate}"),
              //           Text("Country: ${pet.countryBredIn}"),
              //         ],
              //       ),
              //     ),
              //     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}
