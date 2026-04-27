import 'dart:convert';

import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Header.dart';
import 'package:bb/PetInfo/petListModel.dart';
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

  String formatDate(String date) {
    if (date.isEmpty) return "";
    final parts = date.split("-");
    return "${parts[2]}-${parts[1]}-${parts[0]}";
  }

  @override
  void initState() {
    super.initState();
    // Removed autoFillVaccination from here
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    autoFillVaccination(context); // Moved here to ensure context is fully initialized
  }

  String formatDateUI(String? apiDate) {
    if (apiDate == null || apiDate.isEmpty) return "";
    final parts = apiDate.split("-");
    return "${parts[2]}-${parts[1]}-${parts[0]}";
  }

  void autoFillVaccination(BuildContext context) async {
    final pet = ModalRoute.of(context)?.settings.arguments as Petlistmodel?;
    if (pet == null) return;

    final Map<String, dynamic> data = jsonDecode(pet.vaccinationinfo.toString());

    /// -------- Mandatory vaccinations --------
    List vaccinations = data["vaccinations"] ?? [];

    if (vaccinations.contains("FVRCP (3 in 1)")) {
      setState(() {
        isCheckboxCheckedFVRCP = true;
      });
    }

    if (FVRCPfirstnameController.text.isEmpty) {
      setState(() {
        FVRCPfirstnameController.text = data["vaccinations_company_fvrcp"] ?? "";
      });
    }

    if (FVRCPdobController.text.isEmpty) {
      setState(() {
        FVRCPdobController.text = formatDateUI(data["vaccinations_company_fvrcp_date"]);
      });
    }

    if (vaccinations.contains("Rabies")) {
      setState(() {
        isCheckboxCheckedRabies = true;
      });
    }

    if (RabiesfirstnameController.text.isEmpty) {
      setState(() {
        RabiesfirstnameController.text = data["vaccinations_company_rabies"] ?? "";
      });
    }

    if (RabiesdobController.text.isEmpty) {
      setState(() {
        RabiesdobController.text = formatDateUI(data["vaccinations_company_rabies_date"]);
      });
    }

    if (vaccinations.contains("Not sure")) {
      setState(() {
        isCheckboxCheckedNotSure = true;
      });
    }

    /// -------- Optional vaccinations --------
    List optionalVaccinations = data["optional_vaccinations"] ?? [];

    if (optionalVaccinations.contains("FeLV")) {
      setState(() {
        isCheckboxCheckedFeLV = true;
      });
    }

    if (FeLVfirstnameController.text.isEmpty) {
      setState(() {
        FeLVfirstnameController.text = data["vaccinations_company_felv"] ?? "";
      });
    }

    if (FeLVdobController.text.isEmpty) {
      setState(() {
        FeLVdobController.text = formatDateUI(data["vaccinations_company_flev_date"]);
      });
    }

    if (optionalVaccinations.contains("Chlamydia")) {
      setState(() {
        isCheckboxCheckedChlamydia = true;
      });
    }

    if (ChlamydiafirstnameController.text.isEmpty) {
      setState(() {
        ChlamydiafirstnameController.text = data["vaccinations_company_chlamydia"] ?? "";
      });
    }

    if (ChlamydiadobController.text.isEmpty) {
      setState(() {
        ChlamydiadobController.text = formatDateUI(data["vaccinations_company_chlamydia_date"]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // const Color darkRed = Color(0xff7A0000);
    // const Color lightRed = Color(0xffFF6F6F);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      // appBar: AppBar(
      //   title: Text(
      //     "Vaccination Details",
      //     style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,

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

                  // CheckboxListTile(
                  //   value: isCheckboxCheckedFVRCP,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       isCheckboxCheckedFVRCP = value ?? false;
                  //     });
                  //   },
                  //   title: const Text(
                  //     "FVRCP (3 in 1)",
                  //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  _medicineTile(
                    "FVRCP (3 in 1)",
                    isCheckboxCheckedFVRCP,
                    (v) => setState(() => isCheckboxCheckedFVRCP = v),
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
                        FVRCPdobController.text =
                            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                      }
                    },
                  ),
                  const SizedBox(height: 18),

                  /// ⚧ Health History
                  // CheckboxListTile(
                  //   value: isCheckboxCheckedRabies,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       isCheckboxCheckedRabies = value ?? false;
                  //     });
                  //   },
                  //   title: const Text(
                  //     " Rabies",
                  //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  _medicineTile(
                    "Rabies",
                    isCheckboxCheckedRabies,
                    (v) => setState(() => isCheckboxCheckedRabies = v),
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
                        RabiesdobController.text =
                            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                      }
                    },
                  ),
                  const SizedBox(height: 18),

                  /// ⚧ Health History
                  // CheckboxListTile(
                  //   value: isCheckboxCheckedNotSure,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       isCheckboxCheckedNotSure = value ?? false;
                  //     });
                  //   },
                  //   title: const Text(
                  //     " Not Sure ",
                  //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  _medicineTile(
                    "Not Sure",
                    isCheckboxCheckedNotSure,
                    (v) => setState(() => isCheckboxCheckedNotSure = v),
                  ),

                  const SizedBox(height: 18),

                  /// ⚧ Health History
                  _Headerlabel("Optional  Vaccinations"),
                  // CheckboxListTile(
                  //   value: isCheckboxCheckedFeLV,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       isCheckboxCheckedFeLV = value ?? false;
                  //     });
                  //   },
                  //   title: const Text(
                  //     " FeLV",
                  //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  _medicineTile(
                    "FeLV",
                    isCheckboxCheckedFeLV,
                    (v) => setState(() => isCheckboxCheckedFeLV = v),
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
                        FeLVdobController.text =
                            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                      }
                    },
                  ),
                  const SizedBox(height: 18),

                  /// ⚧ Health History
                  // CheckboxListTile(
                  //   value: isCheckboxCheckedChlamydia,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       isCheckboxCheckedChlamydia = value ?? false;
                  //     });
                  //   },
                  //   title: const Text(
                  //     " Chlamydia",
                  //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  _medicineTile(
                    "Chlamydia",
                    isCheckboxCheckedChlamydia,
                    (v) => setState(() => isCheckboxCheckedChlamydia = v),
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
                        ChlamydiadobController.text =
                            "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
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
                        backgroundColor: AppColors.AddButtonColor,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        onSaveVaccination();
                      },
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
      ),
    );
  }

  /// ---------- Widgets ----------
  ///

  void onSaveVaccination() {
    List<String> vaccinations = [];
    List<String> optionalVaccinations = [];

    Map<String, dynamic> data = {};
    Map<String, dynamic> optionalData = {};

    /// -------- Mandatory Vaccinations --------
    if (isCheckboxCheckedFVRCP) {
      vaccinations.add("FVRCP (3 in 1)");
    }
    data["vaccinations_company_fvrcp"] = FVRCPfirstnameController.text;
    data["vaccinations_company_fvrcp_date"] = formatDate(FVRCPdobController.text);

    if (isCheckboxCheckedRabies) {
      vaccinations.add("Rabies");
    }
    data["vaccinations_company_rabies"] = RabiesfirstnameController.text;
    data["vaccinations_company_rabies_date"] = formatDate(RabiesdobController.text);

    if (isCheckboxCheckedNotSure) {
      vaccinations.add("Not sure");
    }

    //--------------optinal vaccination-----------
    if (isCheckboxCheckedFeLV) {
      optionalVaccinations.add("FeLV");
    }
    optionalData["vaccinations_company_felv"] = FeLVfirstnameController.text;
    optionalData["vaccinations_company_flev_date"] = formatDate(FeLVdobController.text);

    if (isCheckboxCheckedChlamydia) {
      optionalVaccinations.add("Chlamydia");
    }
    optionalData["vaccinations_company_chlamydia"] = ChlamydiafirstnameController.text;
    optionalData["vaccinations_company_chlamydia_date"] = formatDate(ChlamydiadobController.text);

    /// -------- Optional Vaccinations (if needed later) --------
    // if (isCheckboxCheckedFeLV) {
    //   vaccinations.add("FeLV");
    // }

    // if (isCheckboxCheckedChlamydia) {
    //   vaccinations.add("Chlamydia");
    // }

    /// Final payload
    Map<String, dynamic> payload = {
      "vaccinations": vaccinations,
      ...data,
      "optional_vaccinations": optionalVaccinations,
      ...optionalData,
      "btn_save_continue": "",
    };

    String encodedBody = jsonEncode(payload);

    debugPrint("ENCODED JSON =====>");
    debugPrint(encodedBody);

    // 🔥 Call API here
    submitVaccination(encodedBody);
  }

  Future<void> submitVaccination(String body) async {
    final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

    try {
      var url = allapiscreen.vaccination.toString();
      var header = await allapiscreen.headerFunction();

      Dio dio = Dio();

      FormData formData = FormData.fromMap({
        "vaccination_info": body,

        "pet_id": pet.petId.toString(),
      });

      Response response = await dio.post(
        url,
        data: formData,
        options: Options(headers: header),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Vaccination saved successfully")));
        // Navigator.pop(context);
        Navigator.pushNamed(context, '/home1');
      }
    } catch (e) {
      debugPrint("API ERROR: $e");
    }
  }

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
        prefixIcon: Icon(icon, color: AppColors.CatSilhouter),
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
          color: AppColors.fontGrey,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _medicineTile(String name, bool value, ValueChanged<bool> onChanged) {
    return Column(
      children: [
        SwitchListTile(
          value: value,
          onChanged: onChanged,
          title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          activeColor: AppColors.AddButtonColor,
        ),
      ],
    );
  }
}
