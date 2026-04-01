import 'dart:io';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Breed/BreedModel.dart';
import 'package:bb/Breed/Breedwidget.dart';
import 'package:bb/Header.dart';
import 'package:bb/PetInfo/petCategoryDropDownwidget.dart';
import 'package:bb/PetInfo/petCategoryModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_colors.dart';

class Donatenow extends StatefulWidget {
  const Donatenow({super.key});

  @override
  State<Donatenow> createState() => _DonatenowState();
}

class _DonatenowState extends State<Donatenow> {
  final _FirstName = TextEditingController();
  final _LastName = TextEditingController();
  final _mobilenumb = TextEditingController();
  final _petName = TextEditingController();

  Petcategorymodel? species;
  String? speciesId;

  bool consent1 = false;
  bool consent2 = false;

  @override
  Widget build(BuildContext context) {
    final petCategoryId = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      // appBar: AppBar(
      //   title: const Text(
      //     "Donate now",
      //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      //   ),
      //   backgroundColor: AppColors.primarycolor,
      //   centerTitle: true,
      // ),
      appBar: const CommonAppBar(),

     
      body: Container(
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [AppColors.primarycolor, AppColors.secondrycolor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
  child: SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [

        /// 🐾 TOP BANNER
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.15),
          ),
          child: const Column(
            children: [
              Icon(Icons.favorite, color: Colors.white, size: 40),
              SizedBox(height: 8),
              Text(
                "Save Lives ❤️",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Your pet can be a hero today 🐾",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        /// 🧾 FORM CARD
        _card(
          title: "Donate Now",
          child: Column(
            children: [
              _niceField("First Name", _FirstName, Icons.person),
              _niceField("Last Name", _LastName, Icons.person_2),
              _niceField("Mobile Number", _mobilenumb, Icons.call),
              _niceField("Pet Name", _petName, Icons.pets),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.centerLeft,
                child: Text("Species", style: _labelStyle()),
              ),
              const SizedBox(height: 6),

              Petcategorydropdownwidget(
                spidiesId: petCategoryId.toString(),
                onChanged: (value) {
                  setState(() {
                    species = value;
                    speciesId = value!.categoryId.toString();
                  });
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        /// ✅ CONSENT CARD
        _card(
          title: "Consent",
          child: Column(
            children: [
              _niceCheckbox(
                value: consent1,
                onChanged: (v) => setState(() => consent1 = v!),
                text:
                    "I confirm that I am the owner or authorized caretaker...",
              ),
              _niceCheckbox(
                value: consent2,
                onChanged: (v) => setState(() => consent2 = v!),
                text:
                    "I certify that the information provided is true...",
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        /// 🚀 DONATE BUTTON
        GestureDetector(
          onTap: consent1 && consent2
              ? () => submit(context, petCategoryId)
              : null,
          child: Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              gradient: consent1 && consent2
                  ? const LinearGradient(
                      colors: [Colors.orange, Colors.red],
                    )
                  : const LinearGradient(
                      colors: [Colors.grey, Colors.grey],
                    ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.4),
                  blurRadius: 12,
                )
              ],
            ),
            child: const Center(
              child: Text(
                "Donate Now ❤️",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),
      //  Container(
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [AppColors.primarycolor, AppColors.secondrycolor],
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //     ),
      //   ),
      //   child: SingleChildScrollView(
      //     padding: const EdgeInsets.all(16),
      //     child: Column(
      //       children: [
      //         /// 🧾 BASIC INFO CARD
      //         _card(
      //           title: "Donate Now",
      //           child: Column(
      //             children: [
      //               const SizedBox(height: 16),

      //               Align(
      //                 alignment: Alignment.centerLeft,
      //                 child: Text("First Name", style: _labelStyle()),
      //               ),
      //               const SizedBox(height: 8),
      //               _field("First Name", _FirstName, Icons.person),
      //               const SizedBox(height: 16),

      //               Align(
      //                 alignment: Alignment.centerLeft,
      //                 child: Text("Last Name", style: _labelStyle()),
      //               ),
      //               const SizedBox(height: 8),
      //               _field("Last Name", _LastName, Icons.person_2),
      //               const SizedBox(height: 16),

      //               Align(
      //                 alignment: Alignment.centerLeft,
      //                 child: Text("Mobile Number", style: _labelStyle()),
      //               ),
      //               const SizedBox(height: 8),
      //               _field("Mobile Number", _mobilenumb, Icons.call),
      //               const SizedBox(height: 16),

      //               Align(
      //                 alignment: Alignment.centerLeft,
      //                 child: Text("Pet Name", style: _labelStyle()),
      //               ),
      //               const SizedBox(height: 8),
      //               _field("Pet Name", _petName, Icons.pets),
      //               const SizedBox(height: 16),

      //               Align(
      //                 alignment: Alignment.centerLeft,
      //                 child: Text("Species", style: _labelStyle()),
      //               ),
      //               const SizedBox(height: 8),
      //               Petcategorydropdownwidget(
      //                 spidiesId: petCategoryId.toString(),
      //                 onChanged: (value) {
      //                   setState(() {
      //                     species = value;
      //                     speciesId = value!.categoryId.toString();
      //                   });
      //                 },
      //               ),
      //             ],
      //           ),
      //         ),

      //         const SizedBox(height: 20),

      //         /// ✅ CONSENTS
      //         _card(
      //           title: "Consent",
      //           child: Column(
      //             children: [
      //               CheckboxListTile(
      //                 value: consent1,
      //                 onChanged: (v) => setState(() => consent1 = v!),
      //                 title: const Text(
      //                   "I confirm that I am the owner or authorized caretaker of this pet and voluntarily consent to the collection, testing, storage, and use of my pet’s blood for donation related purposes, and to the collection and use of my personal information and my pet’s health information in accordance with the privacy policy and applicable veterinary and regulatory guidelines.",
      //                   style: TextStyle(fontSize: 10),
      //                 ),
      //               ),
      //               CheckboxListTile(
      //                 value: consent2,
      //                 onChanged: (v) => setState(() => consent2 = v!),
      //                 title: const Text(
      //                   "I certify that the information provided in this form is true, accurate, and complete to the best of my knowledge. I understand that providing false or misleading information may result in the rejection of this application or termination of membership.",
      //                   style: TextStyle(fontSize: 10),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),

      //         const SizedBox(height: 30),

      //         /// 🚀 SUBMIT
      //         SizedBox(
      //           width: double.infinity,
      //           height: 52,
      //           child: ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //               backgroundColor: AppColors.primarycolor,
      //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      //             ),
      //             onPressed: consent1 && consent2 ? () => submit(context, petCategoryId) : null,
      //             child: const Text(
      //               "Donate",
      //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
   
    );
  }

  /// ---------------- UI HELPERS ----------------

  Widget _card({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black.withOpacity(.05))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _niceField(String hint, TextEditingController c, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xffF3F4F6),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
      ),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: AppColors.primarycolor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(14),
        ),
      ),
    );
  }

  Widget _niceCheckbox({
    required bool value,
    required Function(bool?) onChanged,
    required String text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Checkbox(value: value, activeColor: AppColors.primarycolor, onChanged: onChanged),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 11))),
        ],
      ),
    );
  }

  Widget _dateField(String label, TextEditingController c) {
    return TextField(
      controller: c,
      readOnly: true,
      decoration: InputDecoration(
        // labelText: label,
        prefixIcon: const Icon(Icons.calendar_today),
        filled: true,
        fillColor: const Color(0xffF3F4F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      onTap: () async {
        final d = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          initialDate: DateTime.now(),
        );
        if (d != null) {
          c.text = "${d.day}-${d.month}-${d.year}";
        }
      },
    );
  }

  TextStyle _labelStyle() => const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey);

  /// ---------------- API SUBMIT ----------------

  Future<void> submit(BuildContext context, petCategoryId) async {
    if (_petName.text.toString().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("pet name is required")));
    } else if (_FirstName.text.toString().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("first name is required")));
    } else if (_LastName.text.toString().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("last name is required")));
    } else if (_mobilenumb.text.toString().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("mobile is required")));
    } else if (speciesId == "null") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select Species")));
    } else {
      final dio = Dio();
      final headers = await allapiscreen.headerFunction();

      final formData = FormData.fromMap({
        "pet_name": _petName.text,
        "user_first_name": _FirstName.text,
        "user_last_name": _LastName.text,
        "user_mobile_number": _mobilenumb.text,
        "pet_species_id": speciesId,
      });

      await dio.post(
        allapiscreen.donatenow,
        data: formData,
        options: Options(headers: headers),
      );

      Navigator.pushNamed(context, '/home');
    }
  }
}
