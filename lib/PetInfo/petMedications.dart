import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class Petmedications extends StatefulWidget {
  const Petmedications({super.key});

  @override
  State<Petmedications> createState() => _PetmedicationsState();
}

class _PetmedicationsState extends State<Petmedications> {
  final TextEditingController RevolutionPlusdobController = TextEditingController();

  final TextEditingController BravectoSpotOndobController = TextEditingController();

  final TextEditingController AdvantagedobController = TextEditingController();

  final TextEditingController DrontalCatdobController = TextEditingController();

  final TextEditingController CanwormCatdobController = TextEditingController();

  bool isCheckboxCheckedRevolutionPlus = false;
  bool isCheckboxCheckedBravectoSpotOn = false;
  bool isCheckboxCheckedAdvantage = false;
  bool isCheckboxCheckedDrontalCat = false;
  bool isCheckboxCheckedCanwormCat = false;

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // const Color darkRed = Color(0xff7A0000);
    // const Color lightRed = Color(0xffFF6F6F);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "Medications",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primarycolor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.border,

            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(color: AppColors.secondrycolor, blurRadius: 8, offset: Offset(0, 4)),
            ],
          ),

          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ⚧ Health History
                _Headerlabel("Mandatory Parasite Control"),
                CheckboxListTile(
                  value: isCheckboxCheckedRevolutionPlus,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxCheckedRevolutionPlus = value ?? false;
                    });
                  },
                  title: const Text(
                    "Revolution Plus",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),

                _label("Medication Date"),
                _inputField(
                  controller: RevolutionPlusdobController,
                  hint: "Select date",
                  icon: Icons.calendar_month,
                  readOnly: true,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      RevolutionPlusdobController.text =
                          "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                    }
                  },
                ),
                const SizedBox(height: 18),

                /// ⚧ Health History
                CheckboxListTile(
                  value: isCheckboxCheckedBravectoSpotOn,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxCheckedBravectoSpotOn = value ?? false;
                    });
                  },
                  title: const Text(
                    " Bravecto Spot On",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),

                /// ⚧ Health History
                _label("Medication Date"),

                _inputField(
                  controller: BravectoSpotOndobController,
                  hint: "Select date",
                  icon: Icons.calendar_month,
                  readOnly: true,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      BravectoSpotOndobController.text =
                          "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                    }
                  },
                ),
                const SizedBox(height: 18),

                /// ⚧ Health History
                CheckboxListTile(
                  value: isCheckboxCheckedAdvantage,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxCheckedAdvantage = value ?? false;
                    });
                  },
                  title: const Text(
                    "Advantage",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),

                /// ⚧ Health History
                _label("Medication Date"),

                _inputField(
                  controller: AdvantagedobController,
                  hint: "Select date",
                  icon: Icons.calendar_month,
                  readOnly: true,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      AdvantagedobController.text = "${picked.day}-${picked.month}-${picked.year}";
                    }
                  },
                ),

                const SizedBox(height: 18),

                /// ⚧ Health History
                _Headerlabel("Deworming"),
                CheckboxListTile(
                  value: isCheckboxCheckedDrontalCat,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxCheckedDrontalCat = value ?? false;
                    });
                  },
                  title: const Text(
                    "Drontal Cat",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),

                _label("Medication Date"),
                _inputField(
                  controller: DrontalCatdobController,
                  hint: "Select date",
                  icon: Icons.calendar_month,
                  readOnly: true,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      DrontalCatdobController.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                    }
                  },
                ),
                const SizedBox(height: 18),

                /// ⚧ Health History
                CheckboxListTile(
                  value: isCheckboxCheckedCanwormCat,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxCheckedCanwormCat = value ?? false;
                    });
                  },
                  title: const Text(
                    "Canworm Cat",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),

                _label("Medication Date"),
                _inputField(
                  controller: CanwormCatdobController,
                  hint: "Select date",
                  icon: Icons.calendar_month,
                  readOnly: true,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      CanwormCatdobController.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                    }
                  },
                ),

                const SizedBox(height: 18),

                 /// 🩸 SUBMIT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primarycolor,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ---------- Widgets ----------
  ///
  ///
  ///
  ///

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.secondrycolor),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.dividerGrey),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _Headerlabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.secondrycolor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  void PetRegistration(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final Object? petId = ModalRoute.of(context)!.settings.arguments;
    print(petId);

    var url = allapiscreen.petadd.toString();
    var Header = await allapiscreen.headerFunction();

    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      // "pet_gender": diabetes == "Male" ? "1" : "0",
      // "country_bred_in": diabetes,
      "pet_category_id": petId,
    });

    Response response = await dio.post(
      url,
      data: formData,
      options: Options(headers: Header),
    );

    if (response.statusCode == 200) {
      print("done");
      print(response);

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text("Uploaded"),
          backgroundColor: Colors.redAccent, // Red for errors
          behavior: SnackBarBehavior.floating, // Modern floating look
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    }
  }
}
