// import 'dart:io';

// import 'package:bb/AddressModule/Country/CountryModel.dart';
// import 'package:bb/AddressModule/Country/CountryWidget.dart';
// import 'package:bb/ApiFolder/AllapiScreen.dart';
// import 'package:bb/Breed/BreedModel.dart';
// import 'package:bb/Breed/Breedwidget.dart';
// import 'package:bb/PetInfo/petListModel.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import '../utils/app_colors.dart';

// class PetFormScreen extends StatefulWidget {
//   const PetFormScreen({super.key});

//   @override
//   State<PetFormScreen> createState() => _PetFormScreenState();
// }

// class _PetFormScreenState extends State<PetFormScreen> {
//   final TextEditingController petNameController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController weightController = TextEditingController();

//   String selectedGender = "Male";
//   String selectedCountry = "India";

//   List<String> countries = ["India", "USA", "UK", "Canada", "Australia"];

//   CountryDropDownModel? selecteCountry;
//   String? selectCountryId = "101";

//   BreedModel? selectebreed;
//   String? selectbreedId;

//   File? _croppedImage;

//   bool isCheckboxChecked = false; // Track checkbox state
//   bool isCheckboxCheckedsecond = false; // Track checkbox state

//   Future<void> _pickAndCropcamera(ImageSource source) async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: source);
//     if (picked == null) return;

//     // Crop image first
//     final croppedFile = await ImageCropper().cropImage(
//       sourcePath: picked.path,
//       aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
//       uiSettings: [
//         AndroidUiSettings(toolbarTitle: 'Crop Image', lockAspectRatio: true),
//         IOSUiSettings(aspectRatioLockEnabled: true),
//       ],
//     );

//     if (croppedFile == null) return;

//     // ✅ Smart compression: good quality & smaller size
//     final compressed = await FlutterImageCompress.compressAndGetFile(
//       croppedFile.path,
//       '${croppedFile.path}_compressed.jpg',
//       quality: 90, // High-quality but still compressed
//       minWidth: 1080, // Resized width
//       minHeight: 810, // Keeps 4:3 ratio
//       format: CompressFormat.jpeg,
//     );

//     if (compressed != null) {
//       final file = File(compressed.path);
//       // final fileSizeKB = file.lengthSync() / 1024;

//       final sizeKB = file.lengthSync() / 1024;
//       print("✅ Final image size: ${sizeKB.toStringAsFixed(1)} KB");

//       setState(() {
//         _croppedImage = File(compressed.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     final Object? petIds = ModalRoute.of(context)!.settings.arguments;

//     // const Color darkRed = Color(0xff7A0000);
//     // const Color lightRed = Color(0xffFF6F6F);

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//       appBar: AppBar(
//         title: Text(
//           "Pet Blood Registration",
//           style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.primarycolor,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColors.border,
//             // gradient: const LinearGradient(
//             //   colors: [AppColors.darkRed, AppColors.mediumRed, AppColors.lightRed],
//             //   begin: Alignment.centerLeft,
//             //   end: Alignment.centerRight,
//             // ),
//             borderRadius: BorderRadius.circular(24),
//             boxShadow: const [
//               BoxShadow(color: AppColors.secondrycolor, blurRadius: 8, offset: Offset(0, 4)),
//             ],
//           ),

//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Stack(
//                       alignment: Alignment.bottomRight,
//                       children: [
//                         CircleAvatar(
//                           radius: 50,
//                           backgroundColor: AppColors.primarycolor,
//                           backgroundImage: _croppedImage != null ? FileImage(_croppedImage!) : null,
//                           child: _croppedImage == null
//                               ? const Icon(Icons.person, size: 50, color: Colors.white)
//                               : null,
//                         ),

//                         // Edit icon
//                         GestureDetector(
//                           onTap: () {
//                             _pickAndCropcamera(ImageSource.gallery);
//                           },
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               color: Colors.blue,
//                               shape: BoxShape.circle,
//                             ),
//                             padding: const EdgeInsets.all(6),
//                             child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 /// 🐾 PET NAME
//                 _label("Pet Name"),
//                 _inputField(
//                   controller: petNameController,
//                   hint: "Enter pet name",
//                   icon: Icons.pets,
//                 ),

//                 const SizedBox(height: 18),

//                 /// ⚧ GENDER
//                 _label("Gender"),
//                 Row(
//                   children: [
//                     _genderButton("Male", Icons.male),
//                     const SizedBox(width: 10),
//                     _genderButton("Female", Icons.female),
//                   ],
//                 ),

//                 const SizedBox(height: 18),

//                 /// 📅 DATE OF BIRTH
//                 _label("Date of Birth"),
//                 _inputField(
//                   controller: dobController,
//                   hint: "Select date",
//                   icon: Icons.calendar_month,
//                   readOnly: true,
//                   onTap: () async {
//                     DateTime? picked = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime.now(),
//                     );

//                     if (picked != null) {
//                       dobController.text =
//                           "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
//                     }
//                   },
//                 ),

//                 const SizedBox(height: 18),

//                 /// 🌍 COUNTRY DROPDOWN
//                 // _label("Country"),
//                 // Container(
//                 //   // padding: const EdgeInsets.symmetric(horizontal: 12),
//                 //   decoration: BoxDecoration(
//                 //     color: Colors.white,
//                 //     borderRadius: BorderRadius.circular(14),
//                 //   ),
//                 //   child: Countrywidget(
//                 //     selectedLocation: selecteCountry,

//                 //     onChanged: (value) {
//                 //       setState(() {
//                 //         selecteCountry = value;
//                 //         selectCountryId = value!.countryId.toString();
//                 //       });

//                 //       // You can access both ID and name here
//                 //       if (value != null) {
//                 //         print("Location ID: ${value.countryId}");
//                 //         print("Location Name: ${value.countryName}");
//                 //       }
//                 //     },
//                 //   ),
//                 // DropdownButtonHideUnderline(
//                 //   child: DropdownButton<String>(
//                 //     value: selectedCountry,
//                 //     icon: const Icon(Icons.arrow_drop_down),
//                 //     isExpanded: true,
//                 //     items: countries.map((country) {
//                 //       return DropdownMenuItem(value: country, child: Text(country));
//                 //     }).toList(),
//                 //     onChanged: (value) {
//                 //       setState(() {
//                 //         selectedCountry = value!;
//                 //       });
//                 //     },
//                 //   ),
//                 // ),
//                 // ),
//                 // const SizedBox(height: 18),

//                 /// 🌍 COUNTRY DROPDOWN
//                 _label("Breed"),
//                 Container(
//                   // padding: const EdgeInsets.symmetric(horizontal: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: Breedwidget(
//                     selectedLocation: selectebreed,
//                     spidiesId: petIds.toString(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectebreed = value;
//                         selectbreedId = value!.breedId.toString();
//                       });

//                       // You can access both ID and name here
//                       if (value != null) {
//                         print("Location ID: ${value.breedId}");
//                         print("Location Name: ${value.breedName}");
//                       }
//                     },
//                   ),
//                   // DropdownButtonHideUnderline(
//                   //   child: DropdownButton<String>(
//                   //     value: selectedCountry,
//                   //     icon: const Icon(Icons.arrow_drop_down),
//                   //     isExpanded: true,
//                   //     items: countries.map((country) {
//                   //       return DropdownMenuItem(value: country, child: Text(country));
//                   //     }).toList(),
//                   //     onChanged: (value) {
//                   //       setState(() {
//                   //         selectedCountry = value!;
//                   //       });
//                   //     },
//                   //   ),
//                   // ),
//                 ),

//                 const SizedBox(height: 18),

//                 /// 🐾 PET NAME
//                 _label("Pet Weight"),
//                 _inputField(
//                   controller: weightController,
//                   hint: "Enter weight",
//                   icon: Icons.monitor_weight,
//                 ),
//                 const SizedBox(height: 18),

//                 /// Checkbox with text
//                 CheckboxListTile(
//                   value: isCheckboxChecked,
//                   onChanged: (value) {
//                     setState(() {
//                       isCheckboxChecked = value ?? false;
//                     });
//                   },
//                   title: const Text(
//                     "I confirm that I am the owner or authorized caretaker of this pet and voluntarily consent to the collection, testing, storage, and use of my pet’s blood for donation related purposes, and to the collection and use of my personal information and my pet’s health information in accordance with the privacy policy and applicable veterinary and regulatory guidelines.",
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 /// Checkbox with text
//                 CheckboxListTile(
//                   value: isCheckboxCheckedsecond,
//                   onChanged: (value) {
//                     setState(() {
//                       isCheckboxCheckedsecond = value ?? false;
//                     });
//                   },
//                   title: const Text(
//                     "I certify that the information provided in this form is true, accurate, and complete to the best of my knowledge. I understand that providing false or misleading information may result in the rejection of this application or termination of membership.",
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 /// 🩸 SUBMIT BUTTON
//                 SizedBox(
//                   width: double.infinity,
//                   height: 52,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.white,
//                       foregroundColor: AppColors.darkRed,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                     ),
//                     onPressed: isCheckboxChecked && isCheckboxCheckedsecond
//                         ? () {
//                             print("Pet Name: ${petNameController.text}");
//                             print("Gender: $selectedGender");
//                             print("DOB: ${dobController.text}");
//                             print("Country: $selectedCountry");

//                             if (petNameController.text.isEmpty) {
//                               scaffoldMessenger.showSnackBar(
//                                 SnackBar(
//                                   content: Text('pet name enter'),
//                                   backgroundColor: Colors.redAccent, // Red for errors
//                                   behavior: SnackBarBehavior.floating, // Modern floating look
//                                   duration: Duration(seconds: 3),
//                                   action: SnackBarAction(
//                                     label: 'RETRY',
//                                     textColor: Colors.white,
//                                     onPressed: () => petNameController.clear(),
//                                   ),
//                                 ),
//                               );
//                             } else if (dobController.text.isEmpty) {
//                               scaffoldMessenger.showSnackBar(
//                                 SnackBar(
//                                   content: Text('Selecty dob'),
//                                   backgroundColor: Colors.redAccent, // Red for errors
//                                   behavior: SnackBarBehavior.floating, // Modern floating look
//                                   duration: Duration(seconds: 3),
//                                   action: SnackBarAction(
//                                     label: 'RETRY',
//                                     textColor: Colors.white,
//                                     onPressed: () => petNameController.clear(),
//                                   ),
//                                 ),
//                               );
//                             }
//                             // else if (selectCountryId.toString() == "null") {
//                             //   scaffoldMessenger.showSnackBar(
//                             //     SnackBar(
//                             //       content: Text('Select country'),
//                             //       backgroundColor: Colors.redAccent, // Red for errors
//                             //       behavior: SnackBarBehavior.floating, // Modern floating look
//                             //       duration: Duration(seconds: 3),
//                             //     ),
//                             //   );
//                             // }
//                             else if (selectbreedId.toString() == "null") {
//                               scaffoldMessenger.showSnackBar(
//                                 SnackBar(
//                                   content: Text('Select breed'),
//                                   backgroundColor: Colors.redAccent, // Red for errors
//                                   behavior: SnackBarBehavior.floating, // Modern floating look
//                                   duration: Duration(seconds: 3),
//                                 ),
//                               );
//                             } else if (weightController.text.isEmpty) {
//                               scaffoldMessenger.showSnackBar(
//                                 SnackBar(
//                                   content: Text('Pet weight'),
//                                   backgroundColor: Colors.redAccent, // Red for errors
//                                   behavior: SnackBarBehavior.floating, // Modern floating look
//                                   duration: Duration(seconds: 3),
//                                   action: SnackBarAction(
//                                     label: 'RETRY',
//                                     textColor: Colors.white,
//                                     onPressed: () => petNameController.clear(),
//                                   ),
//                                 ),
//                               );
//                             } else {
//                               PetRegistration(context);
//                             }
//                           }
//                         : null,
//                     child: const Text(
//                       "Register Pet",
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// ---------- Widgets ----------

//   Widget _label(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Text(
//         text,
//         style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _inputField({
//     required TextEditingController controller,
//     required String hint,
//     required IconData icon,
//     bool readOnly = false,
//     VoidCallback? onTap,
//   }) {
//     return TextField(
//       controller: controller,
//       readOnly: readOnly,
//       onTap: onTap,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon),
//         hintText: hint,
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }

//   Widget _genderButton(String gender, IconData icon) {
//     final bool isSelected = selectedGender == gender;

//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             selectedGender = gender;
//           });
//           //8084974200 salab ji
//         },
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: isSelected ? AppColors.primarycolor : AppColors.white.withOpacity(0.7),

//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 color: isSelected ? AppColors.white : AppColors.primarycolor.withOpacity(0.3),
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 gender,
//                 style: TextStyle(
//                   color: isSelected ? AppColors.white : AppColors.primarycolor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void PetRegistration(BuildContext context) async {
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     final Object? petId = ModalRoute.of(context)!.settings.arguments;
//     print(petId);

//     var url = allapiscreen.petadd.toString();
//     var Header = await allapiscreen.headerFunction();

//     List dateof = dobController.text.toString().split("-");
//     String day = dateof[0];
//     String month = dateof[1];
//     String year = dateof[2];

//     Dio dio = Dio();
//     DateTime now = DateTime.now();
//     print(_croppedImage.toString());

//     FormData formData = FormData.fromMap({
//       if (_croppedImage.toString() != "null")
//         'pet_image': await MultipartFile.fromFile(
//           _croppedImage!.path,
//           filename: "${now.second}.jpg",
//         ),
//       "pet_name": petNameController.text,
//       "pet_gender": selectedGender == "Male" ? "1" : "0",
//       "pet_birth_date": "$year-$month-$day",
//       // "country_bred_in": selectedCountry,
//       "pet_breed_id": selectbreedId,

//       "pet_category_id": petId,
//       "pet_weight_in_kg": weightController.text.toString(),
//     });

//     Response response = await dio.post(
//       url,
//       data: formData,
//       options: Options(headers: Header),
//     );

//     if (response.statusCode == 200) {
//       print("done");
//       print(response);
//       // String body = response.body;

//       // // Remove anything after the last closing brace
//       // int jsonEndIndex = body.lastIndexOf('}');
//       // if (jsonEndIndex != -1) {
//       //   body = body.substring(0, jsonEndIndex + 1);
//       // }

//       // final data = json.decode(body);

//       // print(data['data']);
//       scaffoldMessenger.showSnackBar(
//         SnackBar(
//           content: Text("Uploaded"),
//           backgroundColor: Colors.redAccent, // Red for errors
//           behavior: SnackBarBehavior.floating, // Modern floating look
//           duration: Duration(seconds: 2),
//           // action: SnackBarAction(
//           //   label: 'RETRY',
//           //   textColor: Colors.white,
//           //   onPressed: () => firstnameController.clear(),
//           // ),
//         ),
//       );
//       Navigator.pop(context);
//     }
//   }
// }

import 'dart:io';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Breed/BreedModel.dart';
import 'package:bb/Breed/Breedwidget.dart';
import 'package:bb/Header.dart';
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
  final _FirstName = TextEditingController();
  final _LastName = TextEditingController();
  final _mobilenumb = TextEditingController();

  final _petName = TextEditingController();
  final _dob = TextEditingController();
  final _weight = TextEditingController();

  String gender = "Male";
  String sterilization = "Intact";
  String yesno = "No";
  BreedModel? selectedBreed;
  String? breedId;

  File? petImage;
  bool consent1 = false;
  bool consent2 = false;

  /// IMAGE PICK
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );

    if (cropped == null) return;

    final compressed = await FlutterImageCompress.compressAndGetFile(
      cropped.path,
      "${cropped.path}_compressed.jpg",
      quality: 85,
    );

    setState(() => petImage = File(compressed!.path));
  }

  @override
  Widget build(BuildContext context) {
    final petCategoryId = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      // appBar: AppBar(
      //   title: const Text(
      //     "Pet Registration",
      //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      //   ),
      //   backgroundColor: AppColors.primarycolor,
      //   centerTitle: true,
      // ),
            appBar: const CommonAppBar(),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primarycolor, AppColors.secondrycolor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// 🐾 PROFILE IMAGE
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: AppColors.white.withOpacity(.2),
                      backgroundImage: petImage != null ? FileImage(petImage!) : null,
                      child: petImage == null ? const Icon(Icons.pets, size: 50) : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: pickImage,
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.primarycolor,
                          child: Icon(Icons.camera_alt, size: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// 🧾 BASIC INFO CARD
              _card(
                title: "Basic Information",
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Pet Name", style: _labelStyle()),
                    ),
                    const SizedBox(height: 8),
                    _field("Pet Name", _petName, Icons.pets),
                    const SizedBox(height: 16),

                    /// GENDER
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Gender", style: _labelStyle()),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _genderChip("Male", Icons.male),
                        const SizedBox(width: 12),
                        _genderChip("Female", Icons.female),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// Sterilization Status
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Sterilization Status", style: _labelStyle()),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _Sterilization("Intact", Icons.import_contacts_rounded),
                        const SizedBox(width: 8),
                        _Sterilization("Neutrered/Spayed", Icons.nearby_error_outlined),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Date of Birth", style: _labelStyle()),
                    ),
                    const SizedBox(height: 8),
                    _dateField("Date of Birth", _dob),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// 📋 DETAILS CARD
              _card(
                title: "Pet Details",
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Breed", style: _labelStyle()),
                    ),
                    const SizedBox(height: 8),
                    Breedwidget(
                      selectedLocation: selectedBreed,
                      spidiesId: petCategoryId.toString(),
                      onChanged: (value) {
                        setState(() {
                          selectedBreed = value;
                          breedId = value!.breedId.toString();
                        });
                      },
                    ),

                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Weight (kg)", style: _labelStyle()),
                    ),
                    const SizedBox(height: 8),
                    _field("Weight (kg)", _weight, Icons.monitor_weight),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              _card(
                title: "Secondary Guardian",
                child: Column(
                  children: [
                    /// Sterilization Status
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Does Your Pet Have Secondary Guardian", style: _labelStyle()),
                    ),

                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _yes_no("No", Icons.cancel),
                        const SizedBox(width: 8),
                        _yes_no("Yes", Icons.check),
                      ],
                    ),
                    if (yesno == "Yes") const SizedBox(height: 16),
                    if (yesno == "Yes")
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("First Name", style: _labelStyle()),
                      ),
                    if (yesno == "Yes") const SizedBox(height: 8),
                    if (yesno == "Yes") _field("First Name", _FirstName, Icons.person),
                    const SizedBox(height: 16),
                    if (yesno == "Yes")
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Last Name", style: _labelStyle()),
                      ),
                    if (yesno == "Yes") const SizedBox(height: 8),
                    if (yesno == "Yes") _field("Last Name", _LastName, Icons.person_2),
                    const SizedBox(height: 16),
                    if (yesno == "Yes")
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Mobile Number", style: _labelStyle()),
                      ),
                    if (yesno == "Yes") const SizedBox(height: 8),
                    if (yesno == "Yes") _field("Mobile Number", _mobilenumb, Icons.numbers),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ✅ CONSENTS
              _card(
                title: "Consent",
                child: Column(
                  children: [
                    CheckboxListTile(
                      value: consent1,
                      onChanged: (v) => setState(() => consent1 = v!),
                      title: const Text(
                        "I confirm that I am the owner or authorized caretaker of this pet and voluntarily consent to the collection, testing, storage, and use of my pet’s blood for donation related purposes, and to the collection and use of my personal information and my pet’s health information in accordance with the privacy policy and applicable veterinary and regulatory guidelines.",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    CheckboxListTile(
                      value: consent2,
                      onChanged: (v) => setState(() => consent2 = v!),
                      title: const Text(
                        "I certify that the information provided in this form is true, accurate, and complete to the best of my knowledge. I understand that providing false or misleading information may result in the rejection of this application or termination of membership.",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// 🚀 SUBMIT
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarycolor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: consent1 && consent2 ? () => submit(context, petCategoryId) : null,
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
    );
  }

  /// ---------------- UI HELPERS ----------------

  Widget _card({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black.withOpacity(.05))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController c, IconData icon) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        // labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: const Color(0xffF3F4F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _dateField(String label, TextEditingController c) {
    return TextField(
      controller: c,
      readOnly: true,
      decoration: InputDecoration(
        // labelText: label,
        prefixIcon: const Icon(Icons.calendar_today),
        filled: true,
        fillColor: const Color(0xffF3F4F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      onTap: () async {
        final d = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          initialDate: DateTime.now(),
        );
        if (d != null) {
          c.text = "${d.day}-${d.month}-${d.year}";
        }
      },
    );
  }

  Widget _genderChip(String value, IconData icon) {
    final selected = gender == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => gender = value),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: selected ? AppColors.primarycolor : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.primarycolor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: selected ? Colors.white : AppColors.primarycolor),
              const SizedBox(width: 6),
              Text(
                value,
                style: TextStyle(
                  color: selected ? Colors.white : AppColors.primarycolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Sterilization(String value, IconData icon) {
    final selected = sterilization == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => sterilization = value),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: selected ? AppColors.primarycolor : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.primarycolor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: selected ? Colors.white : AppColors.primarycolor),
              const SizedBox(width: 6),
              Text(
                value,
                style: TextStyle(
                  color: selected ? Colors.white : AppColors.primarycolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _yes_no(String value, IconData icon) {
    final selected = yesno == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => yesno = value),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: selected ? AppColors.primarycolor : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.primarycolor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: selected ? Colors.white : AppColors.primarycolor),
              const SizedBox(width: 6),
              Text(
                value,
                style: TextStyle(
                  color: selected ? Colors.white : AppColors.primarycolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _labelStyle() => const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey);

  /// ---------------- API SUBMIT ----------------

  Future<void> submit(BuildContext context, petCategoryId) async {
    if (_petName.text.toString().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("pet name is required")));
    } else if (_dob.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("dob is required")));
    } else if (breedId.toString() == "null") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("breed is required")));
    } else if (_weight.text.toString().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Weight is required")));
    } else if (_petName.text.toString().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("pet name is required")));
    } else if (yesno == "Yes") {
      if (_FirstName.text.toString().isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("first name is required")));
      } else if (_LastName.text.toString().isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("last name is required")));
      } else if (_mobilenumb.text.toString().isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("mobile is required")));
      } else {
        final dio = Dio();
        final headers = await allapiscreen.headerFunction();

        final date = _dob.text.split("-");
        final formData = FormData.fromMap({
          if (petImage != null) "pet_image": await MultipartFile.fromFile(petImage!.path),
          "pet_name": _petName.text,
          "pet_gender": gender == "Male" ? "1" : "0",
          // "pet_gender": sterilization == "Intact" ? "1" : "0",
          "pet_birth_date": "${date[2]}-${date[1]}-${date[0]}",
          "pet_breed_id": breedId,
          "pet_category_id": petCategoryId,
          "pet_weight_in_kg": _weight.text,

          "is_secondary_gardian_available": yesno == "Yes" ? "1" : "0",
          "user_first_name": _FirstName.text,
          "user_last_name": _LastName.text,
          "user_mobile_number": _mobilenumb.text,
        });

        await dio.post(
          allapiscreen.petadd,
          data: formData,
          options: Options(headers: headers),
        );

        Navigator.pushNamed(context, '/home1');
      }
    } else {
      final dio = Dio();
      final headers = await allapiscreen.headerFunction();

      final date = _dob.text.split("-");
      final formData = FormData.fromMap({
        if (petImage != null) "pet_image": await MultipartFile.fromFile(petImage!.path),
        "pet_name": _petName.text,
        "pet_gender": gender == "Male" ? "1" : "0",
        // "pet_gender": sterilization == "Intact" ? "1" : "0",
        "pet_birth_date": "${date[2]}-${date[1]}-${date[0]}",
        "pet_breed_id": breedId,
        "pet_category_id": petCategoryId,
        "pet_weight_in_kg": _weight.text,

        "is_secondary_gardian_available": yesno == "Yes" ? "1" : "0",
        "user_first_name": _FirstName.text,
        "user_last_name": _LastName.text,
        "user_mobile_number": _mobilenumb.text,
      });

      await dio.post(
        allapiscreen.petadd,
        data: formData,
        options: Options(headers: headers),
      );
      Navigator.pushNamed(context, '/home1');
    }
  }
}
