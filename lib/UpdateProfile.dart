import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class Updateprofile extends StatefulWidget {
  const Updateprofile({super.key});

  @override
  State<Updateprofile> createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  String selectedGender = "Male";
  String selectedCountry = "India";
  String selectedblood = "A+";

  List<String> countries = ["India", "USA", "UK", "Canada", "Australia"];
  List<String> bloodgroup = ["A+", "A_", "B+", "B-", "0+", "0-", "AB+", "AB-"];

  @override
  Widget build(BuildContext context) {
    // const Color darkRed = Color(0xff7A0000);
    // const Color lightRed = Color(0xffFF6F6F);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text("Update User Profile", style: TextStyle(color: AppColors.white)),
        centerTitle: true,
        backgroundColor: AppColors.darkRed,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.darkRed, AppColors.mediumRed, AppColors.lightRed],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),

          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🐾 PET NAME
                _label("Email Address"),
                _inputField(
                  controller: petNameController,
                  hint: "Enter email id",
                  icon: Icons.email,
                ),

                const SizedBox(height: 18),

                /// 🌍 COUNTRY DROPDOWN
                _label("Blood Group"),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedblood,
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      items: bloodgroup.map((country) {
                        return DropdownMenuItem(value: country, child: Text(country));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedblood = value!;
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// 🌍 COUNTRY DROPDOWN
                _label("Country"),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCountry,
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      items: countries.map((country) {
                        return DropdownMenuItem(value: country, child: Text(country));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCountry = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                /// 🐾 PET NAME
                _label("City"),
                _inputField(
                  controller: petNameController,
                  hint: "Enter city",
                  icon: Icons.location_city_outlined,
                ),

                const SizedBox(height: 18),

                /// 🐾 PET NAME
                _label("Address"),
                _inputField(
                  controller: petNameController,
                  hint: "Enter address",
                  icon: Icons.email,
                ),

                const SizedBox(height: 18),

                /// 🐾 PET NAME
                _label("Pincode"),
                _inputField(
                  controller: petNameController,
                  hint: "Enter pincode",
                  icon: Icons.pinch_outlined,
                ),

                const SizedBox(height: 30),

                /// 🩸 SUBMIT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.darkRed,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      print("Pet Name: ${petNameController.text}");
                      print("Gender: $selectedGender");
                      print("DOB: ${dobController.text}");
                      print("Country: $selectedCountry");
                    },
                    child: const Text(
                      "Update",
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

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
      ),
    );
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
        prefixIcon: Icon(icon),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _genderButton(String gender, IconData icon) {
    final bool isSelected = selectedGender == gender;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedGender = gender;
          });
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : AppColors.white.withOpacity(0.3),

            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? AppColors.white : AppColors.white.withOpacity(0.3)),
              const SizedBox(width: 6),
              Text(
                gender,
                style: TextStyle(
                  color: isSelected ? AppColors.darkRed : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
