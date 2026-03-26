import 'dart:io';

import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Header.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class BloodDonatePetInfo extends StatefulWidget {
  const BloodDonatePetInfo({super.key});

  @override
  State<BloodDonatePetInfo> createState() => _BloodDonatePetInfoState();
}

class _BloodDonatePetInfoState extends State<BloodDonatePetInfo> {
  final _formKey = GlobalKey<FormState>();

  final dateCtrl = TextEditingController();

  String? implementedBy;
  File? certificateFile;

  bool agree1 = false;
  bool agree2 = false;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

    //   microchipNumberCtrl.text = pet.microchipNumber ?? "";
    //   implementerNameCtrl.text = pet.microchipImplementorName ?? "";
    //   mobileCtrl.text = pet.microchipImplementorMobileNumber ?? "";
    //   dateCtrl.text = pet.microchipImplementedDate ?? "";
    //   implementedBy = pet.microchipImplementedBy;
    //   setState(() {});
    // });
  }

  // ================= DATE =================
  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      dateCtrl.text = "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  // ================= FILE =================
  Future<void> pickCertificate() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf', 'doc', 'docx'],
    );
    if (result != null) {
      certificateFile = File(result.files.single.path!);
      setState(() {});
    }
  }

  // ================= SUBMIT =================
  Future<void> submitForm() async {
    final pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;
    final header = await allapiscreen.headerFunction();
    final url = allapiscreen.last_blood_donate_date.toString();

    FormData data = FormData.fromMap({
      "pet_id": pet.petId.toString(),

      "donate_date": dateCtrl.text,
      if (certificateFile != null)
        "donate_proof": await MultipartFile.fromFile(certificateFile!.path),
    });

    await Dio().post(
      url,
      data: data,
      options: Options(headers: header),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Blood donate details saved")));
    Navigator.pushNamed(context, '/home1');
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),

      // appBar: AppBar(
      //   title: const Text(
      //     "Blood Donate Details",
      //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      //   ),
      //   backgroundColor: AppColors.primarycolor,
      // ),
      appBar: const CommonAppBar(),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.white, AppColors.secondrycolor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _card(
                title: "Donare Details",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label("Donate Date"),
                    _dateField(),

                    _label("Donate Certificate"),
                    _filePicker(),
                  ],
                ),
              ),

              _card(
                title: "Declaration",
                child: Column(
                  children: [
                    CheckboxListTile(
                      value: agree1,
                      onChanged: (v) => setState(() => agree1 = v!),
                      title: const Text(
                        "I agree to indemnify and hold the organization harmless.",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    CheckboxListTile(
                      value: agree2,
                      onChanged: (v) => setState(() => agree2 = v!),
                      title: const Text(
                        "I certify that the information provided is true.",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: agree1 && agree2 && _formKey.currentState!.validate()
                      ? submitForm
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarycolor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    "SUBMIT",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= REUSABLE =================

  Widget _card({String? title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondrycolor,
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }

  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      t,
      style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.fontGrey),
    ),
  );

  Widget _dateField() => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextFormField(
      controller: dateCtrl,
      readOnly: true,
      validator: (v) => v!.isEmpty ? "Required" : null,
      onTap: pickDate,
      decoration: _decoration(suffix: const Icon(Icons.calendar_today)),
    ),
  );

  Widget _filePicker() => InkWell(
    onTap: pickCertificate,
    child: InputDecorator(
      decoration: _decoration(),
      child: Row(
        children: [
          const Icon(Icons.attach_file),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              certificateFile == null ? "Select file" : certificateFile!.path.split('/').last,
            ),
          ),
        ],
      ),
    ),
  );

  InputDecoration _decoration({Widget? suffix}) => InputDecoration(
    filled: true,
    fillColor: Colors.grey.shade50,
    suffixIcon: suffix,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: AppColors.border),
    ),
  );
}
