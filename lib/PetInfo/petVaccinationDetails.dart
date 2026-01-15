import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class Petvaccinationdetails extends StatefulWidget {
  const Petvaccinationdetails({super.key});

  @override
  State<Petvaccinationdetails> createState() => _PetvaccinationdetailsState();
}

class _PetvaccinationdetailsState extends State<Petvaccinationdetails> {
  final TextEditingController FVRCPfirstnameController = TextEditingController();
  final TextEditingController FVRCPdobController = TextEditingController();

  final TextEditingController RabiesfirstnameController = TextEditingController();
  final TextEditingController RabiesdobController = TextEditingController();

  final TextEditingController NotSurefirstnameController = TextEditingController();
  final TextEditingController NotSuredobController = TextEditingController();

  final TextEditingController FeLVfirstnameController = TextEditingController();
  final TextEditingController FeLVdobController = TextEditingController();

  final TextEditingController ChlamydiafirstnameController = TextEditingController();
  final TextEditingController ChlamydiadobController = TextEditingController();

  bool isCheckboxCheckedFVRCP = false;
  bool isCheckboxCheckedRabies = false;
  bool isCheckboxCheckedNotSure = false;
  bool isCheckboxCheckedFeLV = false;
  bool isCheckboxCheckedChlamydia = false;

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // const Color darkRed = Color(0xff7A0000);
    // const Color lightRed = Color(0xffFF6F6F);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "Vaccination Details",
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
                _Headerlabel("Mandatory Vaccinations"),
                CheckboxListTile(
                  value: isCheckboxCheckedFVRCP,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxCheckedFVRCP = value ?? false;
                    });
                  },
                  title: const Text(
                    " FVRCP (3 in 1)",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),

                /// ⚧ Health History
                _label("Vaccinations Company Name "),
                _inputField(
                  controller: FVRCPfirstnameController,
                  hint: "Company Name",
                  icon: Icons.business,
                ),
                const SizedBox(height: 18),

                _label("Vaccinations Date"),
                _inputField(
                  controller: FVRCPdobController,
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
                      FVRCPdobController.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                    }
                  },
                ),
                const SizedBox(height: 18),
                /// ⚧ Health History
                CheckboxListTile(
                  value: isCheckboxCheckedRabies,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxCheckedRabies = value ?? false;
                    });
                  },
                  title: const Text(
                    " Rabies",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),

                /// ⚧ Health History
                _label("Vaccinations Company Name "),
                _inputField(
                  controller: RabiesfirstnameController,
                  hint: "Company Name",
                  icon: Icons.business,
                ),
                const SizedBox(height: 18),

                _label("Vaccinations Date"),
                _inputField(
                  controller: RabiesdobController,
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
                      RabiesdobController.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                    }
                  },
                ),
                const SizedBox(height: 18),
                /// ⚧ Health History
                CheckboxListTile(
                  value: isCheckboxCheckedNotSure,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxCheckedNotSure = value ?? false;
                    });
                  },
                  title: const Text(
                    " Not Sure ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 18),
                /// ⚧ Health History
                _Headerlabel("Optional  Vaccinations"),
                CheckboxListTile(
                  value: isCheckboxCheckedFeLV,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxCheckedFeLV = value ?? false;
                    });
                  },
                  title: const Text(
                    " FeLV",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),

                /// ⚧ Health History
                _label("Vaccinations Company Name "),
                _inputField(
                  controller: FeLVfirstnameController,
                  hint: "Company Name",
                  icon: Icons.business,
                ),
                const SizedBox(height: 18),

                _label("Vaccinations Date"),
                _inputField(
                  controller: FeLVdobController,
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
                      FeLVdobController.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                    }
                  },
                ),
                const SizedBox(height: 18),
                /// ⚧ Health History
                CheckboxListTile(
                  value: isCheckboxCheckedChlamydia,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxCheckedChlamydia = value ?? false;
                    });
                  },
                  title: const Text(
                    " Chlamydia",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),

                /// ⚧ Health History
                _label("Vaccinations Company Name "),
                _inputField(
                  controller: ChlamydiafirstnameController,
                  hint: "Company Name",
                  icon: Icons.business,
                ),
                const SizedBox(height: 18),

                _label("Vaccinations Date"),
                _inputField(
                  controller: ChlamydiadobController,
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
                      ChlamydiadobController.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
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
