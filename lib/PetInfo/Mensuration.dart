import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Header.dart';
import 'package:bb/PetInfo/PetListController.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/PetInfo/MenstrulModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../utils/app_colors.dart';
import 'package:http/http.dart' as http;

class Mensuration extends StatefulWidget {
  const Mensuration({super.key});

  @override
  State<Mensuration> createState() => _MensurationState();
}

class _MensurationState extends State<Mensuration> {
  TextEditingController weightController = TextEditingController();

  late Petlistmodel pet;
  late Future<List<MenstrulModel>> historyFuture;
  final dateCtrl = TextEditingController();

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Get data only once
    pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

    // ✅ Store future (avoid multiple API calls)
    historyFuture = PetService.fetchPetsMenstrulHistory(
      pet.petId.toString(),
      pet.menstrualDate.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: const CommonAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _petHeaderCard(),
            const SizedBox(height: 20),
            _weightForm(scaffoldMessenger),
            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Menstrual History",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primarycolor,
                ),
              ),
            ),

            const SizedBox(height: 12),
            _weightHistory(),
          ],
        ),
      ),
    );
  }

  // ---------------- PET HEADER ----------------

  Widget _petHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primarycolor, AppColors.secondrycolor]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            backgroundImage: pet.petImage.toString() != "null"
                ? NetworkImage("https://pashuraktkosh.lyferp.com/${pet.petImage}")
                : const AssetImage("assest/bblogo.png") as ImageProvider,
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pet.petName.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Text("${pet.petWeightInKg} KG", style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.2);
  }

  // ---------------- FORM ----------------

  Widget _weightForm(ScaffoldMessengerState scaffoldMessenger) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Menstrual Date", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          _dateField(),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.AddButtonColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () async {
                if (dateCtrl.text.isEmpty) {
                  scaffoldMessenger.showSnackBar(const SnackBar(content: Text("Enter weight")));
                  return;
                }

                // 🔹 Show Loader
                _showLoader();

                var url = allapiscreen.petmenstrul.toString();
                var header = await allapiscreen.headerFunction();

                final response = await http.post(
                  Uri.parse(url),
                  headers: header,
                  body: {"mc_date": dateCtrl.text, "mc_pet_id": pet.petId.toString()},
                );

                Navigator.pop(context); // hide loader

                if (response.statusCode == 200) {
                  // ✅ Update local value
                  setState(() {
                    pet.petWeightInKg = weightController.text;

                    // 🔁 Refresh history
                    historyFuture = PetService.fetchPetsMenstrulHistory(
                      pet.petId.toString(),
                      pet.menstrualDate.toString(),
                    );
                  });

                  weightController.clear();

                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text("Menstrl updated successfully"),
                      backgroundColor: AppColors.successGreen,
                    ),
                  );
                } else {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(content: Text("Failed to update weight")),
                  );
                }
              },
              child: const Text(
                "Menstrual Cycle Update",
                style: TextStyle(fontSize: 16, color: AppColors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- HISTORY ----------------

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
  Widget _weightHistory() {
    return FutureBuilder<List<MenstrulModel>>(
      future: historyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Text("No Menstrual history found"),
          );
        }

        final history = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          itemBuilder: (context, index) {
            final item = history[index];
            final date = DateTime.parse(item.mcDate.toString());
            final formatted = DateFormat('dd MMM yyyy').format(date);

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.successGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatted,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      // Text(formatted, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: (index * 120).ms).slideX(begin: 0.2);
          },
        );
      },
    );
  }

  // ---------------- LOADER ----------------

  void _showLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
