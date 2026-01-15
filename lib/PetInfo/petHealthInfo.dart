import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class Pethealthinfo extends StatefulWidget {
  const Pethealthinfo({super.key});

  @override
  State<Pethealthinfo> createState() => _PethealthinfoState();
}

class _PethealthinfoState extends State<Pethealthinfo> {
  String diabetes = "Yes";
  String bloodTrans = "Yes";
  String camvisit = "Yes";

  String? implementedBy = "Indoor and Outdoor";

  final List<String> implementedByList = ['Indoor Only', 'Outdoor Only', 'Indoor and Outdoor'];

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // const Color darkRed = Color(0xff7A0000);
    // const Color lightRed = Color(0xffFF6F6F);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "Health Information",
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
                _Headerlabel("Health History"),

                _label("Any history of kidney disease, heart disease, FIV, FeLV, diabetes?"),
                Row(
                  children: [
                    _diabetes("No", Icons.close),
                    const SizedBox(width: 10),
                    _diabetes("Yes", Icons.check),
                  ],
                ),

                const SizedBox(height: 18),

                /// ⚧ Health History
                _label("Ever received a blood transfusion?"),
                Row(
                  children: [
                    _bloodTransf("No", Icons.close),
                    const SizedBox(width: 10),
                    _bloodTransf("Yes", Icons.check),
                  ],
                ),

                const SizedBox(height: 18),
                _Headerlabel("Lifestyle"),

                _label("Indoor or Outdoor?"),
                _buildDropdown(),

                const SizedBox(height: 18),
                _label("Calm during vet visits?"),
                Row(
                  children: [
                    _calmvisit("No", Icons.close),
                    const SizedBox(width: 10),
                    _calmvisit("Yes", Icons.check),
                  ],
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

  /// 🎨 Input Decoration
  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.border),
      ),
    );
  }

  /// /// 🔹 Dropdown
  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: implementedBy,
        items: implementedByList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) => setState(() => implementedBy = v),
        validator: (v) => v == null ? 'Required' : null,
        decoration: _inputDecoration(),
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

  Widget _diabetes(String gender, IconData icon) {
    final bool isSelected = diabetes == gender;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            diabetes = gender;
          });
          //8084974200 salab ji
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primarycolor : AppColors.white.withOpacity(0.7),

            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.white : AppColors.primarycolor.withOpacity(0.3),
              ),
              const SizedBox(width: 6),
              Text(
                gender,
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.primarycolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bloodTransf(String gender, IconData icon) {
    final bool isSelected = bloodTrans == gender;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            bloodTrans = gender;
          });
          //8084974200 salab ji
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primarycolor : AppColors.white.withOpacity(0.7),

            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.white : AppColors.primarycolor.withOpacity(0.3),
              ),
              const SizedBox(width: 6),
              Text(
                gender,
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.primarycolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _calmvisit(String gender, IconData icon) {
    final bool isSelected = camvisit == gender;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            camvisit = gender;
          });
          //8084974200 salab ji
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primarycolor : AppColors.white.withOpacity(0.7),

            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.white : AppColors.primarycolor.withOpacity(0.3),
              ),
              const SizedBox(width: 6),
              Text(
                gender,
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.primarycolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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
      "pet_gender": diabetes == "Male" ? "1" : "0",
      "country_bred_in": diabetes,

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
