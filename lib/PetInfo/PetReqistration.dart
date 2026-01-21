import 'dart:io';

import 'package:bb/AddressModule/Country/CountryModel.dart';
import 'package:bb/AddressModule/Country/CountryWidget.dart';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Breed/BreedModel.dart';
import 'package:bb/Breed/Breedwidget.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_colors.dart';

class PetFormScreen extends StatefulWidget {
  const PetFormScreen({super.key});

  @override
  State<PetFormScreen> createState() => _PetFormScreenState();
}

class _PetFormScreenState extends State<PetFormScreen> {
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String selectedGender = "Male";
  String selectedCountry = "India";

  List<String> countries = ["India", "USA", "UK", "Canada", "Australia"];

  CountryDropDownModel? selecteCountry;
  String? selectCountryId;

  BreedModel? selectebreed;
  String? selectbreedId;

  File? _croppedImage;

  bool isCheckboxChecked = false; // Track checkbox state
  bool isCheckboxCheckedsecond = false; // Track checkbox state

  Future<void> _pickAndCropcamera(ImageSource source) async {
    final _picker = ImagePicker();
    final picked = await _picker.pickImage(source: source);
    if (picked == null) return;

    // Crop image first
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: picked.path,
      aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
      uiSettings: [
        AndroidUiSettings(toolbarTitle: 'Crop Image', lockAspectRatio: true),
        IOSUiSettings(aspectRatioLockEnabled: true),
      ],
    );

    if (croppedFile == null) return;

    // ✅ Smart compression: good quality & smaller size
    final compressed = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path,
      '${croppedFile.path}_compressed.jpg',
      quality: 90, // High-quality but still compressed
      minWidth: 1080, // Resized width
      minHeight: 810, // Keeps 4:3 ratio
      format: CompressFormat.jpeg,
    );

    if (compressed != null) {
      final file = File(compressed.path);
      // final fileSizeKB = file.lengthSync() / 1024;

      final sizeKB = file.lengthSync() / 1024;
      print("✅ Final image size: ${sizeKB.toStringAsFixed(1)} KB");

      setState(() {
        _croppedImage = File(compressed.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final Object? petIds = ModalRoute.of(context)!.settings.arguments;

    // const Color darkRed = Color(0xff7A0000);
    // const Color lightRed = Color(0xffFF6F6F);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          "Pet Blood Registration",
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
            // gradient: const LinearGradient(
            //   colors: [AppColors.darkRed, AppColors.mediumRed, AppColors.lightRed],
            //   begin: Alignment.centerLeft,
            //   end: Alignment.centerRight,
            // ),
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
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primarycolor,
                          backgroundImage: _croppedImage != null ? FileImage(_croppedImage!) : null,
                          child: _croppedImage == null
                              ? const Icon(Icons.person, size: 50, color: Colors.white)
                              : null,
                        ),

                        // Edit icon
                        GestureDetector(
                          onTap: () {
                            _pickAndCropcamera(ImageSource.gallery);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

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
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      dobController.text =
                          "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                    }
                  },
                ),

                const SizedBox(height: 18),

                /// 🌍 COUNTRY DROPDOWN
                _label("Country"),
                Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Countrywidget(
                    selectedLocation: selecteCountry,
                    onChanged: (value) {
                      setState(() {
                        selecteCountry = value;
                        selectCountryId = value!.countryId.toString();
                      });

                      // You can access both ID and name here
                      if (value != null) {
                        print("Location ID: ${value.countryId}");
                        print("Location Name: ${value.countryName}");
                      }
                    },
                  ),
                  // DropdownButtonHideUnderline(
                  //   child: DropdownButton<String>(
                  //     value: selectedCountry,
                  //     icon: const Icon(Icons.arrow_drop_down),
                  //     isExpanded: true,
                  //     items: countries.map((country) {
                  //       return DropdownMenuItem(value: country, child: Text(country));
                  //     }).toList(),
                  //     onChanged: (value) {
                  //       setState(() {
                  //         selectedCountry = value!;
                  //       });
                  //     },
                  //   ),
                  // ),
                ),
                const SizedBox(height: 18),

                /// 🌍 COUNTRY DROPDOWN
                _label("Breed"),
                Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Breedwidget(
                    selectedLocation: selectebreed,
                    spidiesId: petIds.toString(),
                    onChanged: (value) {
                      setState(() {
                        selectebreed = value;
                        selectbreedId = value!.breedId.toString();
                      });

                      // You can access both ID and name here
                      if (value != null) {
                        print("Location ID: ${value.breedId}");
                        print("Location Name: ${value.breedName}");
                      }
                    },
                  ),
                  // DropdownButtonHideUnderline(
                  //   child: DropdownButton<String>(
                  //     value: selectedCountry,
                  //     icon: const Icon(Icons.arrow_drop_down),
                  //     isExpanded: true,
                  //     items: countries.map((country) {
                  //       return DropdownMenuItem(value: country, child: Text(country));
                  //     }).toList(),
                  //     onChanged: (value) {
                  //       setState(() {
                  //         selectedCountry = value!;
                  //       });
                  //     },
                  //   ),
                  // ),
                ),

                const SizedBox(height: 18),

                /// 🐾 PET NAME
                _label("Pet Weight"),
                _inputField(
                  controller: weightController,
                  hint: "Enter weight",
                  icon: Icons.monitor_weight,
                ),
                const SizedBox(height: 18),

                /// Checkbox with text
                CheckboxListTile(
                  value: isCheckboxChecked,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxChecked = value ?? false;
                    });
                  },
                  title: const Text(
                    "By submitting this form, you agree to indemnify and hold harmless PashuRaktkosh, its officers, directors, employees, and agents from and against any and all claims, liabilities, damages, losses, and expenses, including but not limited to legal fees, arising out of or in connection with your participation in the activities of the Absolute Feline Fanciers.",
                    style: TextStyle(fontSize: 12),
                  ),
                ),

                const SizedBox(height: 20),

                /// Checkbox with text
                CheckboxListTile(
                  value: isCheckboxCheckedsecond,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxCheckedsecond = value ?? false;
                    });
                  },
                  title: const Text(
                    "I certify that the information provided in this form is true, accurate, and complete to the best of my knowledge. I understand that providing false or misleading information may result in the rejection of this application or termination of membership.",
                    style: TextStyle(fontSize: 12),
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
                    onPressed: isCheckboxChecked && isCheckboxCheckedsecond
                        ? () {
                            print("Pet Name: ${petNameController.text}");
                            print("Gender: $selectedGender");
                            print("DOB: ${dobController.text}");
                            print("Country: $selectedCountry");

                            if (petNameController.text.isEmpty) {
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text('pet name enter'),
                                  backgroundColor: Colors.redAccent, // Red for errors
                                  behavior: SnackBarBehavior.floating, // Modern floating look
                                  duration: Duration(seconds: 3),
                                  action: SnackBarAction(
                                    label: 'RETRY',
                                    textColor: Colors.white,
                                    onPressed: () => petNameController.clear(),
                                  ),
                                ),
                              );
                            } else if (dobController.text.isEmpty) {
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text('Selecty dob'),
                                  backgroundColor: Colors.redAccent, // Red for errors
                                  behavior: SnackBarBehavior.floating, // Modern floating look
                                  duration: Duration(seconds: 3),
                                  action: SnackBarAction(
                                    label: 'RETRY',
                                    textColor: Colors.white,
                                    onPressed: () => petNameController.clear(),
                                  ),
                                ),
                              );
                            }
                            else if (selectCountryId.toString() == "null") {
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text('Select country'),
                                  backgroundColor: Colors.redAccent, // Red for errors
                                  behavior: SnackBarBehavior.floating, // Modern floating look
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                            else if (selectbreedId.toString() == "null") {
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text('Select breed'),
                                  backgroundColor: Colors.redAccent, // Red for errors
                                  behavior: SnackBarBehavior.floating, // Modern floating look
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            } else if (weightController.text.isEmpty) {
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  content: Text('Pet weight'),
                                  backgroundColor: Colors.redAccent, // Red for errors
                                  behavior: SnackBarBehavior.floating, // Modern floating look
                                  duration: Duration(seconds: 3),
                                  action: SnackBarAction(
                                    label: 'RETRY',
                                    textColor: Colors.white,
                                    onPressed: () => petNameController.clear(),
                                  ),
                                ),
                              );
                            } else {
                              PetRegistration(context);
                            }
                          }
                        : null,
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
        style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.bold),
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

    List dateof = dobController.text.toString().split("-");
    String day = dateof[0];
    String month = dateof[1];
    String year = dateof[2];

    Dio dio = Dio();
    DateTime now = DateTime.now();
    print(_croppedImage.toString());

    FormData formData = FormData.fromMap({
      if (_croppedImage.toString() != "null")
        'pet_image': await MultipartFile.fromFile(
          _croppedImage!.path,
          filename: "${now.second}.jpg",
        ),
      "pet_name": petNameController.text,
      "pet_gender": selectedGender == "Male" ? "1" : "0",
      "pet_birth_date": year + "-" + month + "-" + day,
      "country_bred_in": selectedCountry,
      "pet_breed_id": selectbreedId,

      "pet_category_id": petId,
      "pet_weight_in_kg": weightController.text.toString(),
    });

    Response response = await dio.post(
      url,
      data: formData,
      options: Options(headers: Header),
    );

    if (response.statusCode == 200) {
      print("done");
      print(response);
      // String body = response.body;

      // // Remove anything after the last closing brace
      // int jsonEndIndex = body.lastIndexOf('}');
      // if (jsonEndIndex != -1) {
      //   body = body.substring(0, jsonEndIndex + 1);
      // }

      // final data = json.decode(body);

      // print(data['data']);
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text("Uploaded"),
          backgroundColor: Colors.redAccent, // Red for errors
          behavior: SnackBarBehavior.floating, // Modern floating look
          duration: Duration(seconds: 2),
          // action: SnackBarAction(
          //   label: 'RETRY',
          //   textColor: Colors.white,
          //   onPressed: () => firstnameController.clear(),
          // ),
        ),
      );
      Navigator.pop(context);
    }
  }
}
