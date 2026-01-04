import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/main.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'package:intl/intl.dart';

class PetDetailScreen extends StatelessWidget {
  const PetDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      // appBar: AppBar(title: Text(pet.petName.toString()), backgroundColor: AppColors.darkRed),

      /// ⬇️ ACTION BUTTONS
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Expanded(
            //   child: _actionButton(
            //     text: "Update Cat Details",
            //     icon: Icons.edit,
            //     onTap: () {
            //       // TODO: Navigate to update screen
            //       print("Update ${pet.petId}");
            //     },
            //   ),
            // ),
            // const SizedBox(width: 12),
            Expanded(
              child: _actionButton(
                text: "Mircrochip Details",
                icon: Icons.comment,
                onTap: () {
                  navigatorKey.currentState?.pushNamed('/petmicrochip', arguments: pet);

                  // _showCommentSheet(context);
                },
              ),
            ),
            // Expanded(
            //   child: _actionButton(
            //     text: "Add Comment",
            //     icon: Icons.comment,
            //     onTap: () {
            //       _showCommentSheet(context);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🔴 HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
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
                  const SizedBox(height: 50),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage: pet.petImage!.isNotEmpty
                        ? NetworkImage("https://pashuraktkosh.lyferp.com/${pet.petImage}")
                        : const AssetImage("assets/pet.png") as ImageProvider,
                  ),
                  const SizedBox(height: 12),
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
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.dividerGrey,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: AppColors.secondrycolor, blurRadius: 8, offset: Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    _detailRow(
                      "Pet ID",
                      pet.petBirthDate.toString().replaceAll("-", "") + pet.petId.toString(),
                    ),
                    _detailRow("Gender", pet.petGender.toString() == "1" ? "Male" : "Female"),
                    _detailRow("Date of Birth", 
                    
                    DateFormat(
                                      'dd-MMMM-yyyy',
                                    ).format(DateTime.parse(pet.petBirthDate.toString()!)).toString(),
                                    ),
                    _detailRow("Country", pet.countryBredIn.toString()),
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
            child: Text(title, style: const TextStyle(color: AppColors.fontGrey)),
          ),
          Text(
            value.isNotEmpty ? value : "-",
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primarycolor),
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
