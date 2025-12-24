import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class PetFormScreen extends StatefulWidget {
  const PetFormScreen({super.key});

  @override
  State<PetFormScreen> createState() => _PetFormScreenState();
}

class _PetFormScreenState extends State<PetFormScreen> {
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  String selectedGender = "Male";
  String selectedCountry = "India";

  List<String> countries = ["India", "USA", "UK", "Canada", "Australia"];

  @override
  Widget build(BuildContext context) {
    // const Color darkRed = Color(0xff7A0000);
    // const Color lightRed = Color(0xffFF6F6F);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text("Pet Blood Registration", style: TextStyle(color: AppColors.white)),
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
                _label("Pet Name"),
                _inputField(
                  controller: petNameController,
                  hint: "Enter pet name",
                  icon: Icons.pets,
                ),

                const SizedBox(height: 18),

                /// ⚧ GENDER
                _label("Gender"),
                Row(
                  children: [
                    _genderButton("Male", Icons.male),
                    const SizedBox(width: 10),
                    _genderButton("Female", Icons.female),
                  ],
                ),

                const SizedBox(height: 18),

                /// 📅 DATE OF BIRTH
                _label("Date of Birth"),
                _inputField(
                  controller: dobController,
                  hint: "Select date",
                  icon: Icons.calendar_month,
                  readOnly: true,
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      dobController.text = "${picked.year}-${picked.month}-${picked.day}";
                    }
                  },
                ),

                const SizedBox(height: 18),

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
                      "Register Pet",
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
