import 'package:bb/PetInfo/PetListController.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetListScreen extends StatefulWidget {
  const PetListScreen({super.key});

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoginCheck();
  }

  bool _loginCheck = false;

  LoginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print(isLoggedIn.toString());
    if (isLoggedIn.toString() == "false") {
      setState(() {
        _loginCheck = true;
      });
    }
    // setState(() {

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 247),
      appBar: AppBar(
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          "My Pets 🐾",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _loginCheck == true
          ? Text("")
          : FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: AppColors.primarycolor,
              foregroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  // navigatorKey.currentState?.pushNamed('/petRegistration');
                  navigatorKey.currentState?.pushNamed('/petCategoryScreen');
                });
              },
            ),

      body: RefreshIndicator(
        onRefresh: () async {
          await PetService.fetchPets(); // Reload data when user performs swipe gesture
          setState(() {});
        },
        child: _loginCheck == true
            ? Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarycolor,
                    // Primary red
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () async {
                    final result = await navigatorKey.currentState?.pushNamed('/login');

                    // navigatorKey.currentState?.pushNamed('/userRegistration');
                  },
                  child: const Text('Go to Login', style: TextStyle(color: Colors.white)),
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

                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: pets.length,
                    itemBuilder: (context, index) {
                      final pet = pets[index];
                      List reqnumber = pet.petBirthDate.toString().split(" ");
                      String req = reqnumber[0];
                      String image = pet.petImage.toString();
                      if (image == "null") {
                        image = "null";
                      }

                      return GestureDetector(
                        onTap: () {
                          navigatorKey.currentState?.pushNamed('/petDetails', arguments: pet);
                        },
                        child: Container(
                          // color: AppColors.backgrounLightGrey,
                          margin: const EdgeInsets.symmetric(vertical: 5),

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
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.secondrycolor.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(1, 2),
                              ),
                            ],
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 255, 255),
                                Color.fromARGB(255, 255, 255, 255),
                              ],
                            ),
                          ),

                          // decoration: BoxDecoration(
                          //   color: AppColors.border,

                          //   // gradient: const LinearGradient(
                          //   //   colors: [
                          //   //     Color(0xff7A0000), // Dark blood red (LEFT)
                          //   //     Color(0xffC62828), // Medium red
                          //   //     Color(0xffFF6F6F), // Light red (RIGHT)
                          //   //   ],
                          //   //   begin: Alignment.centerLeft,
                          //   //   end: Alignment.centerRight,
                          //   // ),
                          //   borderRadius: BorderRadius.circular(20),
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color: AppColors.secondrycolor.withOpacity(0.4),

                          //       // color: Colors.redAccent.withOpacity(0.4),
                          //       blurRadius: 10,
                          //       offset: const Offset(0, 6),
                          //     ),
                          //   ],
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                // 🐶 Pet Image
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: image == "null" || image == ""
                                        ? AssetImage("assest/bblogo.png") as ImageProvider
                                        : NetworkImage(
                                            "https://pashuraktkosh.lyferp.com/${pet.petImage}",
                                          ),
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
                                            color: AppColors.successGreen,
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
                                        "${req.replaceAll("-", "")}${pet.petId}",
                                        style: const TextStyle(
                                          color: AppColors.fontGrey,

                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${pet.petGender.toString() == "1" ? "Male" : "Female"}",
                                        style: const TextStyle(
                                          color: AppColors.fontGrey,

                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (pet.countryBredIn.toString() != "null")
                                        Text(
                                          "${pet.countryBredIn}",
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
                                    navigatorKey.currentState?.pushNamed(
                                      '/petDetails',
                                      arguments: pet,
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
                                      color: AppColors.successGreen,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
