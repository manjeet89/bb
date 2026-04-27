import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Header.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Expiredate extends StatefulWidget {
  const Expiredate({super.key});

  @override
  State<Expiredate> createState() => _ExpiredateState();
}

class _ExpiredateState extends State<Expiredate> {
  final dateCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

    //   dateCtrl.text = pet.microchipImplementedDate ?? "";
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

  // ================= SUBMIT =================
  Future<void> submitForm() async {
    final pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;
    print("hihad9ufboa");
    final header = await allapiscreen.headerFunction();
    final url = allapiscreen.expiredate.toString();

    FormData data = FormData.fromMap({
      "pet_id": pet.petId.toString(),
      "pet_expire_date": dateCtrl.text,
    });

    await Dio().post(
      url,
      data: data,
      options: Options(headers: header),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Expire details saved")));
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
      //     "Pet is Alive",
      //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      //   ),
      //   backgroundColor: AppColors.primarycolor,
      // ),
      appBar: const CommonAppBar(),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.AddButtonColor, AppColors.CatSilhouter],
            //[AppColors.white, AppColors.secondrycolor],
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
                title: "Expire date",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_label("Date of Passing Away"), _dateField()],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    submitForm();
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.AddButtonColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
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

  Widget _input({
    required TextEditingController controller,
    TextInputType keyboard = TextInputType.text,
    Widget? suffix,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: (v) => v!.isEmpty ? "Required" : null,
      decoration: _decoration(suffix: suffix),
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
