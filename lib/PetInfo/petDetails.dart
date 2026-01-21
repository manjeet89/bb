import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/main.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'package:intl/intl.dart';

class PetDetailScreen extends StatefulWidget {
  const PetDetailScreen({super.key});

  @override
  State<PetDetailScreen> createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  bool showOptions = false;
  String petinfo = "Pet Info";

  void toggleOptions() {
    setState(() {
      showOptions = !showOptions; // Toggling the visibility of additional options
    });
  }

  @override
  Widget build(BuildContext context) {
    final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

    final inputFormat = DateFormat('yyyy-MM-d');
    final outputFormat = DateFormat('dd-MMMM-yyyy');

    DateTime date = inputFormat.parse(pet.petBirthDate.toString());
    String formattedDate = outputFormat.format(date);

    print(formattedDate); // 05-October-2021

    return Scaffold(
      backgroundColor: AppColors.bgGrey,

      // appBar: AppBar(title: Text(pet.petName.toString()), backgroundColor: AppColors.darkRed),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              // When the main FAB is pressed,
              // toggleOptions is called
              toggleOptions();

              showOptions != true ? petinfo = "Pet Info" : petinfo = "Back";
            },
            label: Text(petinfo, style: TextStyle(color: Colors.white)),
            // icon: Icon(Icons.add, color: Colors.white),
            backgroundColor: showOptions != true ? AppColors.successGreen : AppColors.darkRed,
          ),
          SizedBox(height: 16.0),
          Visibility(
            visible: showOptions, // Show the options only if showOptions is true
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.extended(
                      backgroundColor: AppColors.primarycolor,
                      onPressed: () {
                        navigatorKey.currentState?.pushNamed('/petmicrochip', arguments: pet);
                        // Add your action for Option 1
                      },
                      tooltip: 'Mircrochip Details',
                      label: Row(
                        children: [
                          Text("Mircrochip Details", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    FloatingActionButton.extended(
                      backgroundColor: AppColors.primarycolor,
                      onPressed: () {
                        navigatorKey.currentState?.pushNamed('/petHealthinfo', arguments: pet);
                        // Add your action for Option 1
                      },
                      tooltip: 'Health Information',
                      label: Row(
                        children: [
                          Text("Health Information", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.extended(
                      backgroundColor: AppColors.primarycolor,
                      onPressed: () {
                        navigatorKey.currentState?.pushNamed(
                          '/petvaccinationdetails',
                          arguments: pet,
                        );
                        // Add your action for Option 1
                      },
                      tooltip: 'Vaccination Details',
                      label: Row(
                        children: [
                          Text("Vaccination Details", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),

                    SizedBox(width: 16.0),
                    FloatingActionButton.extended(
                      backgroundColor: AppColors.primarycolor,
                      onPressed: () {
                        navigatorKey.currentState?.pushNamed('/petmedications', arguments: pet);
                        // Add your action for Option 1
                      },
                      tooltip: 'Medications',
                      label: Row(
                        children: [Text("Medications", style: TextStyle(color: Colors.white))],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.extended(
                      backgroundColor: AppColors.primarycolor,
                      onPressed: () {
                        navigatorKey.currentState?.pushNamed(
                          '/petveterinarianinfo',
                          arguments: pet,
                        );
                        // Add your action for Option 1
                      },
                      tooltip: 'Veterinarian Details',
                      label: Row(
                        children: [
                          Text("Veterinarian Details", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    FloatingActionButton.extended(
                      backgroundColor: AppColors.white,
                      onPressed: () {
                        navigatorKey.currentState?.pushNamed('/petWeightupdate', arguments: pet);
                        // Add your action for Option 1
                      },
                      tooltip: 'Weight Update',
                      label: Row(
                        children: [
                          Text("Weight Update", style: TextStyle(color: AppColors.successGreen)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),

      /// ⬇️ ACTION BUTTONS
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(14),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: _actionButton(
      //           text: "Health Information",
      //           icon: Icons.edit,
      //           onTap: () {
      //             // TODO: Navigate to update screen
      //             navigatorKey.currentState?.pushNamed('/petHealthinfo', arguments: pet);
      //           },
      //         ),
      //       ),
      //       const SizedBox(width: 12),
      //       Expanded(
      //         child: _actionButton(
      //           text: "Mircrochip Details",
      //           icon: Icons.comment,
      //           onTap: () {
      //             navigatorKey.currentState?.pushNamed('/petmicrochip', arguments: pet);

      //             // _showCommentSheet(context);
      //           },
      //         ),
      //       ),
      //       const SizedBox(width: 12),
      //       Expanded(
      //         child: _actionButton(
      //           text: "Vaccination Details",
      //           icon: Icons.comment,
      //           onTap: () {
      //             navigatorKey.currentState?.pushNamed('/petvaccinationdetails', arguments: pet);

      //             // _showCommentSheet(context);
      //           },
      //         ),
      //       ),
      //       const SizedBox(width: 12),
      //       Expanded(
      //         child: _actionButton(
      //           text: "Medications",
      //           icon: Icons.comment,
      //           onTap: () {
      //             navigatorKey.currentState?.pushNamed('/petmedications', arguments: pet);

      //             // _showCommentSheet(context);
      //           },
      //         ),
      //       ),
      //       const SizedBox(width: 12),
      //       Expanded(
      //         child: _actionButton(
      //           text: "Veterinarian Details",
      //           icon: Icons.comment,
      //           onTap: () {
      //             navigatorKey.currentState?.pushNamed('/petveterinarianinfo', arguments: pet);

      //             // _showCommentSheet(context);
      //           },
      //         ),
      //       ),
      //       // Expanded(
      //       //   child: _actionButton(
      //       //     text: "Add Comment",
      //       //     icon: Icons.comment,
      //       //     onTap: () {
      //       //       _showCommentSheet(context);
      //       //     },
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🔴 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: AppColors.primarycolor,
              // decoration: const BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [AppColors.darkRed, AppColors.mediumRed, AppColors.lightRed],
              //     begin: Alignment.centerLeft,
              //     end: Alignment.centerRight,
              //   ),
              // ),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: pet.petImage.toString() != "null"
                        ? NetworkImage("https://pashuraktkosh.lyferp.com/${pet.petImage}")
                        : const AssetImage("assets/pet.png") as ImageProvider,
                  ),
                  const SizedBox(height: 12),
                  // Divider(),
                  Text(
                    pet.petName.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            /// 📄 DETAILS CARD
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(color: AppColors.secondrycolor, blurRadius: 8, offset: Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    _detailRow(
                      "Pet ID :",
                      pet.petBirthDate.toString().replaceAll("-", "") + pet.petId.toString(),
                    ),
                    Divider(),
                    _detailRow("Gender :", pet.petGender.toString() == "1" ? "Male" : "Female"),
                    Divider(),

                    if (pet.petWeightInKg.toString() != "null")
                      _detailRow("Weight :", pet.petWeightInKg.toString() + " KG"),
                    Divider(),

                    _detailRow(
                      "Date of Birth :",
                      formattedDate,

                      // days + "-" + month + "-" + year
                      // DateFormat(
                      //   'dd-MMMM-yyyy',
                      // ).format(DateTime.parse(pet.petBirthDate.toString())).toString(),
                    ),
                    Divider(),

                    if (pet.countryBredIn.toString() != "null")
                      _detailRow("Country :", pet.countryBredIn.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
              style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            value.isNotEmpty ? value : "-",
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondrycolor),
          ),
        ],
      ),
    );
  }
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
