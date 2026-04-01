import 'dart:io';
import 'package:bb/AddressModule/Country/CountryModel.dart';
import 'package:bb/AddressModule/Country/CountryWidget.dart';
import 'package:bb/AddressModule/District/DistricModel.dart';
import 'package:bb/AddressModule/District/DistrictWidget.dart';
import 'package:bb/AddressModule/State/StateModel.dart';
import 'package:bb/AddressModule/State/StateWidget.dart';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Breed/BreedModel.dart';
import 'package:bb/Breed/Breedwidget.dart';
import 'package:bb/Header.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_colors.dart';

class Updatepetdetails extends StatefulWidget {
  const Updatepetdetails({super.key});

  @override
  State<Updatepetdetails> createState() => _UpdatepetdetailsState();
}

class _UpdatepetdetailsState extends State<Updatepetdetails> {
  // address
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController organizationNameController =
      TextEditingController(); // Controller for organization name

  var FirstName = "";
  var LastName = "";
  var Email = "";
  var Number = "";
  var Gender = "";
  var Dateofbirth = "";
  var Bloodname = "";
  var UserAddress = "";
  var Country = "";
  var State = "";
  var District = "";
  var City = "";
  var Pincode = "";
  var ImageGet = "";
  String selectedGender = "Male";
  String selectedUserType = "Individual"; // State for user type

  String selectedCountry = "India";
  String selectedblood = "A+";

  List<String> countries = ["India", "USA", "UK", "Canada", "Australia"];
  List<String> bloodgroup = ["A+", "A_", "B+", "B-", "0+", "0-", "AB+", "AB-"];

  CountryDropDownModel? selecteCountry;
  String? selectCountryId;

  StateModel? selecteState;
  String? selectStateId;

  DistrictModelDropDown? selecteDistrict;
  String? selectDistrictId;

  //================
  //End addres
  //================
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;
      setState(() {
        _petName.text = pet.petName ?? "";
        _dob.text = pet.petBirthDate ?? "";
        _weight.text = pet.petWeightInKg ?? "";
        _FirstName.text = pet.userFirstName ?? "";
        _LastName.text = pet.userLastName ?? "";
        _mobilenumb.text = pet.userMobileNumber ?? "";
        gender = pet.petGender == "1" ? "Male" : "Female";
        sterilization = pet.sterilizationStatus == "1" ? "Intact" : "Neutrered/Spayed";

        cityController.text = pet.petCity != "null" ? pet.petCity.toString() : "";
        addressController.text = pet.petAddress != "null" ? pet.petAddress.toString() : "";
        pincodeController.text = pet.petPinCode != "null" ? pet.petPinCode.toString() : "";
        breedId = pet.petBreedId;
        print("brredid${pet.petBreedId}");

        // selectedBreed = BreedModel();
        yesno = pet.isSecondaryGardianAvailable == "1" ? "Yes" : "No";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final petCategoryId = ModalRoute.of(context)!.settings.arguments;
    final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

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
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text("Pet Name", style: _labelStyle()),
                    // ),
                    // const SizedBox(height: 8),
                    // _field("Pet Name", _petName, Icons.pets),
                    // const SizedBox(height: 16),

                    // /// GENDER
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text("Gender", style: _labelStyle()),
                    // ),
                    // const SizedBox(height: 8),
                    // Row(
                    //   children: [
                    //     _genderChip("Male", Icons.male),
                    //     const SizedBox(width: 12),
                    //     _genderChip("Female", Icons.female),
                    //   ],
                    // ),
                    // const SizedBox(height: 16),

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
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text("Date of Birth", style: _labelStyle()),
                    // ),
                    // const SizedBox(height: 8),
                    // _dateField("Date of Birth", _dob),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// 📋 DETAILS CARD
              // _card(
              //   title: "Pet Details",
              //   child: Column(
              //     children: [
              //       Align(
              //         alignment: Alignment.centerLeft,
              //         child: Text("Breed", style: _labelStyle()),
              //       ),
              //       const SizedBox(height: 8),
              //       Breedwidget(
              //         selectedLocation: selectedBreed,
              //         spidiesId: pet.petCategoryId.toString(),
              //         breedId: pet.petBreedId.toString(),
              //         onChanged: (value) {
              //           setState(() {
              //             selectedBreed = value;
              //             breedId = value!.breedId.toString();
              //           });
              //         },
              //       ),

              //       const SizedBox(height: 16),
              //       Align(
              //         alignment: Alignment.centerLeft,
              //         child: Text("Weight (kg)", style: _labelStyle()),
              //       ),
              //       const SizedBox(height: 8),
              //       _field("Weight (kg)", _weight, Icons.monitor_weight),
              //     ],
              //   ),
              // ),

              // const SizedBox(height: 20),
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
              _sectionCard(
                title: "Address Information",
                children: [
                  _label("Country"),
                  Countrywidget(
                    selectedLocation: selecteCountry,
                    countryid: pet.petCountry.toString(),
                    onChanged: (value) {
                      setState(() {
                        selecteCountry = value;
                        selectCountryId = value?.countryId;
                        selecteState = null;
                        selecteDistrict = null;
                      });
                    },
                  ),
                  _gap(),
                  _label("State"),
                  Statewidget(
                    selectedLocation: selecteState,
                    categoryId: selectCountryId.toString(),
                    stateid: pet.petState.toString(),
                    onChanged: (value) {
                      setState(() {
                        selecteState = value;
                        selectStateId = value?.stateId;
                        selecteDistrict = null;
                      });
                    },
                  ),
                  _gap(),
                  _label("District"),
                  Districtwidget(
                    selectedLocation: selecteDistrict,
                    categoryId: selectStateId.toString(),
                    districtId: pet.petDistrict.toString(),
                    onChanged: (value) {
                      setState(() {
                        selecteDistrict = value;
                        selectDistrictId = value?.districtId;
                      });
                    },
                  ),
                  _gap(),
                  _label("City"),
                  _inputField(controller: cityController, hint: "City", icon: Icons.location_city),
                  _gap(),
                  _label("Address"),
                  _inputField(controller: addressController, hint: "Address", icon: Icons.home),
                  _gap(),
                  _label("Pincode"),
                  _inputField(controller: pincodeController, hint: "Pincode", icon: Icons.pin_drop),
                ],
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
                  onPressed: consent1 && consent2
                      ? () => submit(context, petCategoryId, pet)
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
    );
  }

  /// ---------------- UI HELPERS ----------------
  ///

  Widget _sectionCard({required String title, required List<Widget> children}) {
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
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 14);

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
    // Make first name, last name, and email fields read-only if already filled
    // bool isReadOnly =
    //     readOnly ||
    //     (controller == firstnameController && firstnameController.text.isNotEmpty) ||
    //     (controller == lastnameController && lastnameController.text.isNotEmpty);
    // ||(controller == emailController && emailController.text.isNotEmpty);

    return TextField(
      controller: controller,
      // readOnly: isReadOnly,
      onTap: onTap,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.secondrycolor),
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.dividerGrey)),
      ),
    );
  }

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

  Future<void> submit(BuildContext context, petCategoryId, Petlistmodel pet) async {
    // if (_petName.text.toString().isEmpty) {
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(const SnackBar(content: Text("pet name is required")));
    // } else if (_dob.text.toString().isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("dob is required")));
    // } else if (breedId.toString() == "null") {
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(const SnackBar(content: Text("breed is required")));
    // } else if (_weight.text.toString().isEmpty) {
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(const SnackBar(content: Text("Weight is required")));
    // } else if (_petName.text.toString().isEmpty) {
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(const SnackBar(content: Text("pet name is required")));
    // }
    // else

    print(
      "details with me  ${pet.petId} $sterilization  $yesno  ${_FirstName.text},  ${_LastName.text},  ${_mobilenumb.text}, ${selectCountryId},  ${selectStateId},  ${selectDistrictId},  ${cityController.text},  ${addressController.text}, ${pincodeController.text},",
    );
    if (yesno == "Yes") {
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

        final formData = FormData.fromMap({
          if (petImage != null) "pet_image": await MultipartFile.fromFile(petImage!.path),
          "sterilization_status": sterilization.toString() == "Intact" ? "1" : "0",
          "is_secondary_gardian_available": yesno.toString() == "Yes" ? "1" : "0",
          "user_first_name": _FirstName.text.toString(),
          "user_last_name": _LastName.text.toString(),
          "user_mobile_number": _mobilenumb.text.toString(),
          "pet_id": pet.petId.toString(),
          "pet_country": selectCountryId.toString(),
          "pet_state": selectStateId.toString(),
          "pet_district": selectDistrictId.toString(),
          "pet_city": cityController.text.toString(),
          "pet_address": addressController.text.toString(),
          "pet_pin_code": pincodeController.text.toString(),
        });

        final response = await dio.post(
          allapiscreen.petupdate,
          data: formData,
          options: Options(headers: headers),
        );

        // Log the response
        print("API Response: ${response.data}");

        // Show the result in a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated")));

        Navigator.pushNamed(context, '/home1');
      }
    } else {
      print("wich is wrorking");
      final dio = Dio();
      final headers = await allapiscreen.headerFunction();

      final formData = FormData.fromMap({
        if (petImage != null) "pet_image": await MultipartFile.fromFile(petImage!.path),
        "sterilization_status": sterilization.toString() == "Intact" ? "1" : "0",
        "is_secondary_gardian_available": yesno.toString() == "Yes" ? "1" : "0",
        "user_first_name": _FirstName.text.toString(),
        "user_last_name": _LastName.text.toString(),
        "user_mobile_number": _mobilenumb.text.toString(),
        "pet_id": pet.petId.toString(),
        "pet_country": selectCountryId.toString(),
        "pet_state": selectStateId.toString(),
        "pet_district": selectDistrictId.toString(),
        "pet_city": cityController.text.toString(),
        "pet_address": addressController.text.toString(),
        "pet_pin_code": pincodeController.text.toString(),
      });

      final response = await dio.post(
        allapiscreen.petupdate,
        data: formData,
        options: Options(headers: headers),
      );

      // Log the response
      print("API Response: ${response.data}");

      // Show the result in a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(" Updated")));

      Navigator.pushNamed(context, '/home1');
    }
  }
}
