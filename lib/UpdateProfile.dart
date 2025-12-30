import 'dart:convert';

import 'package:bb/AddressModule/Country/CountryModel.dart';
import 'package:bb/AddressModule/Country/CountryWidget.dart';
import 'package:bb/AddressModule/District/DistricModel.dart';
import 'package:bb/AddressModule/District/DistrictWidget.dart';
import 'package:bb/AddressModule/State/StateModel.dart';
import 'package:bb/AddressModule/State/StateWidget.dart';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/BloodGroup/BloodGropDropDownModel.dart';
import 'package:bb/BloodGroup/BloodGroupWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Updateprofile extends StatefulWidget {
  const Updateprofile({super.key});

  @override
  State<Updateprofile> createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchData();
  }

  File? _croppedImage;

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

  FetchData() async {
    var url = allapiscreen.userprofile.toString();
    var Header = await allapiscreen.headerFunction();

    print(Header.toString());
    final response = await http.post(Uri.parse(url), headers: Header);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      // print(decoded['data']["user_first_name"]);

      setState(() {
        //Auto fill name
        FirstName = decoded['data']["user_first_name"] ?? "null";
        if (FirstName != "null") {
          firstnameController.value = TextEditingValue(text: FirstName);
        }
        //Auto fill last name
        LastName = decoded['data']['user_last_name'] ?? "null";
        if (LastName != "null") {
          lastnameController.value = TextEditingValue(text: LastName);
        }

        //Auto fill email
        Email = decoded['data']['user_email_id'] ?? "null";
        if (Email != "null") {
          emailController.value = TextEditingValue(text: Email);
        }
        //static values
        Gender = decoded['data']['user_gender'] ?? "null";
        if (Gender != "null") {
          selectedGender = Gender != "1" ? "Female" : "Male";
        }
        Number = decoded['data']['user_mobile_number'] ?? "null";

        //Auto fill dob
        Dateofbirth = decoded['data']['user_date_of_birth'] ?? "null";
        if (Dateofbirth != "null") {
          dobController.value = TextEditingValue(text: Dateofbirth);
        }

        //Auto fill blood name and id
        Bloodname = decoded['data']['blood_name'] ?? "null";
        var BloodId = decoded['data']['user_blood_group'] ?? "null";
        selectBloodGroupId = BloodId;
        selecteBloodGroup = BloodGroupModel(
          bloodId: BloodId,
          bloodName: Bloodname,
          bloodCreatedOn: "",
          bloodStatus: "",
        );
        //Auto fill user address
        UserAddress = decoded['data']['user_address'] ?? "null";
        if (UserAddress != "null") {
          addressController.value = TextEditingValue(text: UserAddress);
        }

        //Auto fill country name and id
        Country = decoded['data']['country_name'] ?? "null";
        var Countryid = decoded['data']['user_country'] ?? "null";
        selectCountryId = Countryid;
        selecteCountry = CountryDropDownModel(
          capital: "",
          countryId: Countryid,
          countryName: Country,
          currency: "",
          currencyName: "",
          currencySymbol: "",
          emoji: "",
          emojiU: "",
          iso2: "",
          iso3: '',
          latitude: "",
          longitude: "",
          nationality: "",
          native: "",
          numericCode: "",
          phoneCode: "",
          region: "",
          regionId: "",
          subregion: "",
          subregionId: "",
          timezones: "",
          tld: "",
        );

        //Auto fill country name and id
        State = decoded['data']['state_name'] ?? "null";
        var Stateid = decoded['data']['user_state'] ?? "null";
        selectStateId = Stateid;
        selecteState = StateModel(
          countryCode: "",
          countryId: "",
          countryName: "",
          latitude: "",
          longitude: "",
          stateCode: Stateid,
          stateId: Stateid,
          stateName: State,
          type: "",
        );

        //Auto fill country name and id
        District = decoded['data']['district_name'] ?? "null";
        var Districtid = decoded['data']['user_district'] ?? "null";
        selectDistrictId = Districtid;
        selecteDistrict = DistrictModelDropDown(
          districtCreatedOn: "",
          districtId: Districtid,
          districtName: District,
          districtStatus: "",
          districtUpdatedOn: "",
          stateId: "",
        );

        //Auto fill country name and id
        City = decoded['data']['user_city'] ?? "null";
        if (City != "null") {
          cityController.value = TextEditingValue(text: City);
        }

        //Auto fill country name and id
        Pincode = decoded['data']['user_pin_code'] ?? "null";
        if (Pincode != "null") {
          pincodeController.value = TextEditingValue(text: Pincode);
        }

        //Auto fill image
        ImageGet = decoded['data']['user_profile_image'] ?? "null";
      });
    } else {
      throw Exception("Failed to load pets");
    }
  }

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

  BloodGroupModel? selecteBloodGroup;
  String? selectBloodGroupId;

  UploadValue() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    var url = allapiscreen.userupdate.toString();
    var Header = await allapiscreen.headerFunction();

    Dio dio = Dio();
    DateTime now = DateTime.now();
    print(_croppedImage.toString());

    FormData formData = FormData.fromMap({
      if (_croppedImage.toString() != "null")
        'user_profile_image': await MultipartFile.fromFile(
          _croppedImage!.path,
          filename: "${now.second}.jpg",
        ),
      "user_first_name": firstnameController.text,
      "user_last_name": lastnameController.text,
      "user_email_id": emailController.text,
      "user_gender": selectedGender == "Male" ? "1" : "0",
      "user_date_of_birth": dobController.text,
      "user_blood_group": selectBloodGroupId,
      "user_country": selectCountryId,
      "user_state": selectStateId,
      "user_district": selectDistrictId,
      "user_city": cityController.text,
      "user_address": addressController.text,
      "user_pin_code": pincodeController.text,
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

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // const Color darkRed = Color(0xff7A0000);
    // const Color lightRed = Color(0xffFF6F6F);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text(
          "Update User Profile",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primarycolor,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          // color: AppColors.cardBackgroundWhite,
          decoration: BoxDecoration(
            color: AppColors.border,
            // gradient: const LinearGradient(
            //   // colors:AppColors.cardBackgroundWhite,
            //   // [AppColors.darkRed, AppColors.mediumRed, AppColors.lightRed],
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
                    onTap: () {
                      ShowImage(context, allapiscreen.imageapi.toString() + ImageGet);
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ImageGet == "null"
                            ? CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey.shade300,
                                backgroundImage: _croppedImage != null
                                    ? FileImage(_croppedImage!)
                                    : null,
                                child: _croppedImage == null
                                    ? const Icon(Icons.person, size: 50, color: Colors.white)
                                    : null,
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey.shade300,
                                backgroundImage: NetworkImage(
                                  allapiscreen.imageapi.toString() + ImageGet,
                                ),
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
                _label("First Name"),
                _inputField(
                  controller: firstnameController,
                  hint: "Enter first name",
                  icon: Icons.person,
                ),

                const SizedBox(height: 18),

                /// 🐾 PET NAME
                _label("Last Name"),
                _inputField(
                  controller: lastnameController,
                  hint: "Enter last name",
                  icon: Icons.person_3_outlined,
                ),

                const SizedBox(height: 18),

                /// 🐾 PET NAME
                _label("Email Address"),
                _inputField(controller: emailController, hint: "Enter email id", icon: Icons.email),

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
                _label("Blood Group"),
                Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Bloodgroupwidget(
                    selectedLocation: selecteBloodGroup,
                    onChanged: (value) {
                      setState(() {
                        selecteBloodGroup = value;
                        selectBloodGroupId = value!.bloodId.toString();
                      });

                      // You can access both ID and name here
                      if (value != null) {
                        print("Location ID: ${value.bloodId}");
                        print("Location Name: ${value.bloodName}");
                      }
                    },
                  ),
                ),

                const SizedBox(height: 30),

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

                        // 👇 reset dependent dropdown

                        selecteDistrict = null;
                        selectDistrictId = null;
                        selecteState = null;
                        selectStateId = null;
                      });

                      // You can access both ID and name here
                      if (value != null) {
                        print("Location ID: ${value.countryId}");
                        print("Location Name: ${value.countryName}");
                      }
                    },
                  ),
                ),

                const SizedBox(height: 18),
                _label("State"),
                Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Statewidget(
                    selectedLocation: selecteState,
                    categoryId: selectCountryId.toString(),
                    onChanged: (value) {
                      setState(() {
                        selecteState = value;
                        selectStateId = value!.stateId.toString();

                        // 👇 reset dependent dropdown
                        selecteDistrict = null;
                        selectDistrictId = null;
                      });

                      // You can access both ID and name here
                      if (value != null) {
                        print("Location ID: ${value.stateId}");
                        print("Location Name: ${value.stateName}");
                      }
                    },
                  ),
                ),
                const SizedBox(height: 18),
                _label("District"),
                Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Districtwidget(
                    selectedLocation: selecteDistrict,
                    categoryId: selectStateId.toString(),
                    onChanged: (value) {
                      setState(() {
                        selecteDistrict = value;
                        selectDistrictId = value!.districtId.toString();
                      });

                      // You can access both ID and name here
                      if (value != null) {
                        print("Location ID: ${value.districtId}");
                        print("Location Name: ${value.districtName}");
                      }
                    },
                  ),
                ),
                const SizedBox(height: 18),

                /// 🐾 PET NAME
                _label("City"),
                _inputField(
                  controller: cityController,
                  hint: "Enter city",
                  icon: Icons.location_city_outlined,
                ),

                const SizedBox(height: 18),

                /// 🐾 PET NAME
                _label("Address"),
                _inputField(
                  controller: addressController,
                  hint: "Enter address",
                  icon: Icons.email,
                ),

                const SizedBox(height: 18),

                /// 🐾 PET NAME
                _label("Pincode"),
                _inputField(
                  controller: pincodeController,
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
                      backgroundColor: AppColors.primarycolor,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      print("Pet Name: ${emailController.text}");
                      print("Gender: $selectedGender");
                      print("DOB: ${dobController.text}");
                      print("Country: $selectedCountry");

                      if (firstnameController.text.isEmpty) {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('First name enter'),
                            backgroundColor: Colors.redAccent, // Red for errors
                            behavior: SnackBarBehavior.floating, // Modern floating look
                            duration: Duration(seconds: 3),
                            action: SnackBarAction(
                              label: 'RETRY',
                              textColor: Colors.white,
                              onPressed: () => firstnameController.clear(),
                            ),
                          ),
                        );
                      } else if (lastnameController.text.isEmpty) {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('Last name enter'),
                            backgroundColor: Colors.redAccent, // Red for errors
                            behavior: SnackBarBehavior.floating, // Modern floating look
                            duration: Duration(seconds: 3),
                            action: SnackBarAction(
                              label: 'RETRY',
                              textColor: Colors.white,
                              onPressed: () => lastnameController.clear(),
                            ),
                          ),
                        );
                      } else if (emailController.text.isEmpty) {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('Email id enter'),
                            backgroundColor: Colors.redAccent, // Red for errors
                            behavior: SnackBarBehavior.floating, // Modern floating look
                            duration: Duration(seconds: 3),
                            action: SnackBarAction(
                              label: 'RETRY',
                              textColor: Colors.white,
                              onPressed: () => emailController.clear(),
                            ),
                          ),
                        );
                      } else if (dobController.text.isEmpty) {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('Select dob'),
                            backgroundColor: Colors.redAccent, // Red for errors
                            behavior: SnackBarBehavior.floating, // Modern floating look
                            duration: Duration(seconds: 3),
                            action: SnackBarAction(
                              label: 'RETRY',
                              textColor: Colors.white,
                              onPressed: () => emailController.clear(),
                            ),
                          ),
                        );
                      } else if (selectBloodGroupId.toString() == "null") {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('Select blood group'),
                            backgroundColor: Colors.redAccent, // Red for errors
                            behavior: SnackBarBehavior.floating, // Modern floating look
                            duration: Duration(seconds: 3),
                            // action: SnackBarAction(
                            //   label: 'RETRY',
                            //   textColor: Colors.white,
                            //   onPressed: () => firstnameController.clear(),
                            // ),
                          ),
                        );
                      } else if (selectCountryId.toString() == "null") {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('Select country'),
                            backgroundColor: Colors.redAccent, // Red for errors
                            behavior: SnackBarBehavior.floating, // Modern floating look
                            duration: Duration(seconds: 3),
                            // action: SnackBarAction(
                            //   label: 'RETRY',
                            //   textColor: Colors.white,
                            //   onPressed: () => firstnameController.clear(),
                            // ),
                          ),
                        );
                      } else if (selectStateId.toString() == "null") {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('Select state'),
                            backgroundColor: Colors.redAccent, // Red for errors
                            behavior: SnackBarBehavior.floating, // Modern floating look
                            duration: Duration(seconds: 3),
                            // action: SnackBarAction(
                            //   label: 'RETRY',
                            //   textColor: Colors.white,
                            //   onPressed: () => firstnameController.clear(),
                            // ),
                          ),
                        );
                      } else if (cityController.text.isEmpty) {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('City name enter'),
                            backgroundColor: Colors.redAccent, // Red for errors
                            behavior: SnackBarBehavior.floating, // Modern floating look
                            duration: Duration(seconds: 3),
                            action: SnackBarAction(
                              label: 'RETRY',
                              textColor: Colors.white,
                              onPressed: () => cityController.clear(),
                            ),
                          ),
                        );
                      } else if (pincodeController.text.isEmpty) {
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('Enter pincode'),
                            backgroundColor: Colors.redAccent, // Red for errors
                            behavior: SnackBarBehavior.floating, // Modern floating look
                            duration: Duration(seconds: 3),
                            action: SnackBarAction(
                              label: 'RETRY',
                              textColor: Colors.white,
                              onPressed: () => pincodeController.clear(),
                            ),
                          ),
                        );
                      } else {
                        UploadValue();
                      }
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
            color: isSelected ? AppColors.primarycolor : AppColors.white.withOpacity(0.8),

            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.white : AppColors.secondrycolor.withOpacity(0.8),
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
}

void ShowImage(BuildContext context, String s) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(0),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
                child: InteractiveViewer(child: Image.network(s, fit: BoxFit.contain)),
              ),
            ),
            Positioned(
              top: 30,
              right: 30,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 32),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      );
    },
  );
}
