import 'package:bb/AddressModule/Country/CountryModel.dart';
import 'package:bb/AddressModule/Country/CountryWidget.dart';
import 'package:bb/AddressModule/District/DistricModel.dart';
import 'package:bb/AddressModule/District/DistrictWidget.dart';
import 'package:bb/AddressModule/State/StateModel.dart';
import 'package:bb/AddressModule/State/StateWidget.dart';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/PetInfo/PetListController.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:digipin/digipin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sosscreen extends StatefulWidget {
  const Sosscreen({super.key});

  @override
  State<Sosscreen> createState() => _SosscreenState();
}

class _SosscreenState extends State<Sosscreen> {
  String selectedGender = "Manual Address";
  String selectedUserType = "Individual"; // State for user type
  bool isCheckboxCheckedsecond = false; // Track checkbox state
  bool isCheckboxCheckedFVRCP = false;
  bool isCheckboxCheckedRabies = false;
  bool isCheckboxCheckedNotSure = false;
  bool isCheckboxCheckedFeLV = false;
  bool isCheckboxCheckedChlamydia = false;

  final TextEditingController countryCtrl = TextEditingController();
  final TextEditingController stateCtrl = TextEditingController();
  final TextEditingController districtCtrl = TextEditingController();
  final TextEditingController pincodeCtrl = TextEditingController();

  bool progressindication = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoginCheck();
    _loadCheckboxStates(); // Load saved checkbox states
  }

  bool _loginCheck = false;

  LoginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print(isLoggedIn.toString());
    if (isLoggedIn.toString() == "false") {
      setState(() {
        _loginCheck = true;
      });
    }
    // setState(() {

    // });
  }

  void submitForm(
    String petId,
    String digipin,
    String lat,
    String lng,
    String countid,
    String stateId,
    String distid,
    String pincode,
  ) async {
    // if (_formKey.currentState!.validate() && certificateFile != null) {
    //   final data = {
    //     "microchip_number": microchipNumberCtrl.text,
    //     "implemented_by": implementedBy,
    //     "implementer_name": implementerNameCtrl.text,
    //     "implementer_mobile": mobileCtrl.text,
    //     "implemented_date": dateCtrl.text,
    //     "certificate_file": certificateFile!.path,
    //   };

    //   debugPrint("FORM DATA 👉 $data");
    // }

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    var url = allapiscreen.sosblood.toString();
    var Header = await allapiscreen.headerFunction();

    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      "pet_id": petId.toString(),
      "req_digipin": digipin.toString(),
      "req_latitude": lat.toString(),
      "req_longtitude": lng.toString(),
      "user_country_id": countid.toString(),
      "user_state_id": stateId.toString(),
      "user_district_id": distid.toString(),
      "user_pin_code": pincode.toString(),
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
          content: Text("Your request submited successfull. We will get back to you soon."),
          backgroundColor: AppColors.successGreen, // Red for errors
          behavior: SnackBarBehavior.floating, // Modern floating look
          duration: Duration(seconds: 2),
          // action: SnackBarAction(
          //   label: 'RETRY',
          //   textColor: Colors.white,
          //   onPressed: () => firstnameController.clear(),
          // ),
        ),
      );
      // Navigator.pop(context);
    }
  }

  double lastLat = 0.0;
  double lastLng = 0.0;
  bool firstLocation = true;

  var digiPin;

  Future<String> _listenLocation() async {
    await Geolocator.requestPermission();

    try {
      // Get a single current position (awaitable)
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double lat = pos.latitude;
      double lng = pos.longitude;

      // Encode latitude & longitude to DigiPin
      final pin = DigiPin.getDigiPin(lat, lng);
      print('DigiPin for ($lat, $lng): $pin');

      // Decode DigiPin back to approximate latitude & longitude
      final decoded = DigiPin.getLatLngFromDigiPin(pin);
      print('Decoded latitude: ${decoded['latitude']}');
      print('Decoded longitude: ${decoded['longitude']}');

      // setState(() {
      //   digiPin = pin;
      // });

      return pin + "/" + lat.toString() + "/" + lng.toString();
    } catch (e) {
      print('Error getting location: $e');
      return '';
    }
  }

  Future<void> _loadCheckboxStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCheckboxCheckedFVRCP = prefs.getBool('isCheckboxCheckedFVRCP') ?? false;
      isCheckboxCheckedRabies = prefs.getBool('isCheckboxCheckedRabies') ?? false;
      isCheckboxCheckedNotSure = prefs.getBool('isCheckboxCheckedNotSure') ?? false;
      isCheckboxCheckedFeLV = prefs.getBool('isCheckboxCheckedFeLV') ?? false;
      isCheckboxCheckedChlamydia = prefs.getBool('isCheckboxCheckedChlamydia') ?? false;
    });
  }

  Future<void> _saveCheckboxState(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          "SOS Pet Lists 🐾",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          await PetService.fetchPets(); // Reload data when user performs swipe gesture
          setState(() {});
        },
        child: _loginCheck == true
            ? Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarycolor,
                    // Primary red
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () async {
                    final result = await navigatorKey.currentState?.pushNamed('/login');

                    // navigatorKey.currentState?.pushNamed('/userRegistration');
                  },
                  child: const Text('Go to Login', style: TextStyle(color: Colors.white)),
                ),
              )
            : FutureBuilder<List<Petlistmodel>>(
                future: PetService.fetchPets(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No pets found"));
                  }

                  final pets = snapshot.data!;

                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: pets.length,
                    itemBuilder: (context, index) {
                      final pet = pets[index];
                      List reqnumber = pet.petBirthDate.toString().split(" ");
                      String req = reqnumber[0];
                      String image = pet.petImage.toString();
                      if (image == "null") {
                        image = "null";
                      }

                      return InkWell(
                        onTap: () async {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) => Container(
                          //     // color: AppColors.warningOrange,

                          //     child: AlertDialog(
                          //       backgroundColor: AppColors.primarycolor,

                          //       title: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Icon(Icons.warning_amber_outlined, color: AppColors.darkRed),
                          //           Text(
                          //             'Blood Donor Request',
                          //             style: TextStyle(color: AppColors.white),
                          //           ),
                          //         ],
                          //       ),
                          //       content: Text(
                          //         'Do you require blood for Tom?',
                          //         style: TextStyle(color: AppColors.white),
                          //       ),
                          //       actions: [
                          //         TextButton(
                          //           onPressed: () => Navigator.of(context).pop(false),
                          //           child: Text('No', style: TextStyle(color: AppColors.darkRed)),
                          //         ),
                          //         TextButton(
                          //           onPressed: () => Navigator.of(context).pop(true),
                          //           child: Text(
                          //             'Yes',
                          //             style: TextStyle(color: AppColors.successGreen),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // );
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: AppColors.primarycolor,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.warning_amber_outlined, color: AppColors.darkRed),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Please fill these form first.',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              // content: Text(
                              //   'Do you require blood for Tom?',
                              //   style: TextStyle(color: AppColors.white),
                              // ),
                              actions: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.successGreen,
                                  ),
                                  onPressed: () {
                                    navigatorKey.currentState?.pushNamed(
                                      '/petHealthinfo',
                                      arguments: pet,
                                    );
                                    // TODO: Open Digipin picker / API
                                  },
                                  icon: Icon(Icons.health_and_safety, color: AppColors.white),
                                  label: Text(
                                    'Health Information',
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.successGreen,
                                  ),
                                  onPressed: () {
                                    navigatorKey.currentState?.pushNamed(
                                      '/petvaccinationdetails',
                                      arguments: pet,
                                    ); // TODO: Open Digipin picker / API
                                  },
                                  icon: Icon(Icons.vaccines, color: AppColors.white),
                                  label: Text(
                                    'Vaccination Details',
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.successGreen,
                                  ),
                                  onPressed: () {
                                    navigatorKey.currentState?.pushNamed(
                                      '/petmedications',
                                      arguments: pet,
                                    );
                                    // TODO: Open Digipin picker / API
                                  },
                                  icon: Icon(Icons.medication, color: AppColors.white),
                                  label: Text(
                                    'Medications',
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.successGreen,
                                  ),
                                  onPressed: () {
                                    navigatorKey.currentState?.pushNamed(
                                      '/petveterinarianinfo',
                                      arguments: pet,
                                    ); // TODO: Open Digipin picker / API
                                  },
                                  icon: Icon(Icons.volunteer_activism, color: AppColors.white),
                                  label: Text(
                                    'Veterinarian Information',
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('No', style: TextStyle(color: AppColors.darkRed)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // close first dialog

                                        _FirstshowLocationDialog(
                                          context,
                                          pet.petName.toString(),
                                        ); // _showLocationDialog(context); // open second dialog

                                        // _askingcurrentLocationDialog(
                                        //   context,
                                        //   pet.petName.toString(),
                                        // ); // open second dialog
                                      },
                                      child: Text(
                                        'Already form filled',
                                        style: TextStyle(color: AppColors.successGreen),
                                      ),
                                    ),
                                  ],
                                ),
                                // TextButton(
                                //   onPressed: () => Navigator.pop(context),
                                //   child: Text('No', style: TextStyle(color: AppColors.darkRed)),
                                // ),
                                // TextButton(
                                //   onPressed: () {
                                //     Navigator.pop(context); // close first dialog
                                //     _showLocationDialog(
                                //       context,
                                //       pet.petName.toString(),
                                //     ); // open second dialog
                                //   },
                                //   child: Text(
                                //     'Yes',
                                //     style: TextStyle(color: AppColors.successGreen),
                                //   ),
                                // ),
                              ],
                            ),
                          );

                          // String digiPin = await _listenLocation();
                          // List divi = digiPin.split("/");
                          // String digi = divi[0];
                          // String lat = divi[1];
                          // String lng = divi[2];
                          // print("get digipin" + digiPin);
                          // submitForm(pet.petId.toString(), digi, lat, lng);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),

                          // decoration: BoxDecoration(
                          //   gradient: const LinearGradient(
                          //     colors: [
                          //       Color(0xff8B0000), // Dark Red
                          //       Color(0xffB11226), // Blood Red
                          //     ],
                          //     begin: Alignment.topLeft,
                          //     end: Alignment.bottomRight,
                          //   ),
                          //   borderRadius: BorderRadius.circular(20),
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color: Colors.red.withOpacity(0.4),
                          //       blurRadius: 10,
                          //       offset: const Offset(0, 6),
                          //     ),
                          //   ],
                          // ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            // gradient: const LinearGradient(
                            //   colors: [
                            //     Color(0xff7A0000), // Dark blood red (LEFT)
                            //     Color(0xffC62828), // Medium red
                            //     Color(0xffFF6F6F), // Light red (RIGHT)
                            //   ],
                            //   begin: Alignment.centerLeft,
                            //   end: Alignment.centerRight,
                            // ),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.secondrycolor.withOpacity(0.4),
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                // 🐶 Pet Image
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: image == "null"
                                        ? AssetImage("assest/bblogo.png") as ImageProvider
                                        : NetworkImage(
                                            "https://pashuraktkosh.lyferp.com/${pet.petImage}",
                                          ),
                                  ),
                                ),

                                const SizedBox(width: 14),

                                // 📄 Pet Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.bloodtype,
                                            color: AppColors.secondrycolor,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            pet.petName.toString(),
                                            style: const TextStyle(
                                              color: AppColors.primarycolor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 6),

                                      Text(
                                        "${req.replaceAll("-", "")}${pet.petId}",
                                        style: const TextStyle(
                                          color: AppColors.fontGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${pet.petGender.toString() == "1" ? "Male" : "Female"}",
                                        style: const TextStyle(
                                          color: AppColors.fontGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (pet.countryBredIn.toString() != "null")
                                        Text(
                                          "${pet.countryBredIn}",
                                          style: const TextStyle(
                                            color: AppColors.fontGrey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                // ➡️ Action Icon
                                GestureDetector(
                                  onTap: () async {
                                    // String digiPin = await _listenLocation();
                                    // List divi = digiPin.split("/");
                                    // String digi = divi[0];
                                    // String lat = divi[1];
                                    // String lng = divi[2];
                                    print("get digipin" + digiPin);
                                    // submitForm(pet.petId.toString(), digi, lat, lng);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.primarycolor,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ); //   margin: const EdgeInsets.only(bottom: 12),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(16),
                      //     boxShadow: [
                      //       BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
                      //     ],
                      //   ),
                      //   child: ListTile(
                      //     contentPadding: const EdgeInsets.all(12),
                      //     leading: CircleAvatar(
                      //       radius: 30,
                      //       backgroundImage: pet.petImage!.isNotEmpty
                      //           ? NetworkImage("https://pashuraktkosh.lyferp.com/${pet.petImage}")
                      //           : const AssetImage("assets/pet.png") as ImageProvider,
                      //     ),
                      //     title: Text(
                      //       pet.petName!,
                      //       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      //     ),
                      //     subtitle: Padding(
                      //       padding: const EdgeInsets.only(top: 6),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text("Gender: ${pet.petGender}"),
                      //           Text("DOB: ${pet.petBirthDate}"),
                      //           Text("Country: ${pet.countryBredIn}"),
                      //         ],
                      //       ),
                      //     ),
                      //     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      //   ),
                      // );
                    },
                  );
                },
              ),
      ),
    );
  }

  Widget _genderButton(
    String gender,
    IconData icon,
    String selectedGender,
    Function(String) onSelected,
  ) {
    final bool isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        onSelected(gender); // ✅ dialog setState
      },
      child: Container(
        height: 48,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.successGreen : AppColors.white.withOpacity(0.7),
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
                fontSize: 12,
                color: isSelected ? AppColors.white : AppColors.primarycolor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLocationDialog(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.primarycolor,
        title: Column(
          children: [
            Icon(Icons.location_on, color: AppColors.successGreen),
            const SizedBox(height: 8),
            Text('Location of ${name}', style: TextStyle(color: AppColors.white)),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen),
              onPressed: () {
                Navigator.pop(context);
                // TODO: Open Digipin picker / API
              },
              icon: Icon(Icons.qr_code, color: AppColors.white),
              label: Text('Use Digipin', style: TextStyle(color: AppColors.white)),
            ),
          ],
        ),
        content: Text(
          'Please provide the current location where ${name} is located.',
          style: TextStyle(color: AppColors.white),
          textAlign: TextAlign.center,
        ),

        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: AppColors.darkRed)),
          ),
          TextButton(
            onPressed: () {
              _askingcurrentLocationDialog(context, name); // open second dialog
              Navigator.pop(context); // close first dialog
              // _showLocationDialog(context); // open second dialog
            },
            child: Text('Proceed', style: TextStyle(color: AppColors.successGreen)),
          ),
        ],
        // actions: [
        //   ElevatedButton.icon(
        //     style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen),
        //     onPressed: () {
        //       Navigator.pop(context);
        //       // TODO: Open Digipin picker / API
        //     },
        //     icon: Icon(Icons.qr_code, color: AppColors.white),
        //     label: Text('Use Digipin', style: TextStyle(color: AppColors.white)),
        //   ),
        // ],
      ),
    );
  }

  void _askingcurrentLocationDialog(BuildContext context, String name) {
    String selectedOption = "Use Digipin";

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, dialogSetState) {
          return AlertDialog(
            backgroundColor: AppColors.primarycolor,

            title: Column(
              children: [
                Icon(Icons.location_on, color: AppColors.successGreen),
                const SizedBox(height: 8),
                Text('Location of $name', style: TextStyle(color: AppColors.white)),
              ],
            ),

            /// ✅ FULL WIDTH CONTENT
            content: SizedBox(
              width: double.maxFinite, // ⭐ KEY LINE
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),

                  Column(
                    children: [
                      _genderButton("Use Digipin", Icons.qr_code, selectedOption, (value) {
                        dialogSetState(() {
                          selectedOption = value;
                        });
                      }),
                      const SizedBox(width: 10),
                      _genderButton("Manual Address", Icons.edit_location, selectedOption, (value) {
                        dialogSetState(() {
                          selectedOption = value;
                          _manulaLocationDialog(context, name);
                        });
                      }),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Please provide the current location where $name is located.',
                    style: TextStyle(color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel', style: TextStyle(color: AppColors.darkRed)),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, selectedOption);
                  if ("Use Digipin" == selectedOption) {
                    String digiPin = await _listenLocation();
                    List divi = digiPin.split("/");
                    String digi = divi[0];
                    String lat = divi[1];
                    String lng = divi[2];
                    print("get digipin" + digiPin);
                    setState(() {
                      submitForm(name.toString(), digi, lat, lng, "", "", "", "");
                    });
                  } else {
                    print("object");
                  }
                  print(selectedOption);
                  // Navigator.pop(context, selectedOption);
                },
                child: Text('Proceed', style: TextStyle(color: AppColors.successGreen)),
              ),
            ],
          );
        },
      ),
    );
  }
  // void _manulaLocationDialog(BuildContext context, String name) {
  //   CountryDropDownModel? selecteCountry;
  //   String? selectCountryId;
  //   StateModel? selecteState;
  //  String? selectStateId;
  //   DistrictModelDropDown? selecteDistrict;
  //   String? selectDistrictId;
  //   showDialog(
  //     context: context,
  //     builder: (context) => StatefulBuilder(
  //       builder: (context, dialogSetState) {
  //         return AlertDialog(
  //           content: SizedBox(
  //             width: double.maxFinite,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 /// 🌍 COUNTRY DROPDOWN
  //                 _label("Country"),
  //                 Container(
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(14),
  //                   ),
  //                   child: Countrywidget(
  //                     selectedLocation: selecteCountry,
  //                     onChanged: (value) {
  //                       dialogSetState(() {
  //                         selecteCountry = value;
  //                         selectCountryId = value?.countryId;
  //                         // ✅ reset dependent dropdowns
  //                         selecteState = null;
  //                         selectStateId = null;
  //                         selecteDistrict = null;
  //                         selectDistrictId = null;
  //                      });
  //                       if (value != null) {
  //                         print("Country ID: ${value.countryId}");
  //                         print("Country Name: ${value.countryName}");
  //                       }
  //                     },
  //                   ),
  //                 ),
  //                 const SizedBox(height: 12),
  //                 /// 🏙 STATE DROPDOWN
  //                 if (selectCountryId != null)
  //                   Statewidget(
  //                     categoryId: selectCountryId!,
  //                     selectedLocation: selecteState,
  //                     onChanged: (value) {
  //                       dialogSetState(() {
  //                         selecteState = value;
  //                         selectStateId = value?.stateId;
  //                         selecteDistrict = null;
  //                         selectDistrictId = null;
  //                       });
  //                     },
  //                  ),
  //                 const SizedBox(height: 12),
  //                 /// 🏘 DISTRICT DROPDOWN
  //                 if (selectStateId != null)
  //                   Districtwidget(
  //                     categoryId: selectStateId!,
  //                     selectedLocation: selecteDistrict,
  //                     onChanged: (value) {
  //                       dialogSetState(() {
  //                         selecteDistrict = value;
  //                         selectDistrictId = value?.districtId;
  //                       });
  //                     },
  //                   ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  void _manulaLocationDialog(BuildContext context, String name) {
    CountryDropDownModel? selecteCountry;
    StateModel? selecteState;
    DistrictModelDropDown? selecteDistrict;

    String? countid;
    String? distid;
    String? stateid;

    bool showForm = false; // 🔑 step switch

    final countryCtrl = TextEditingController();
    final stateCtrl = TextEditingController();
    final districtCtrl = TextEditingController();
    final pincodeCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, dialogSetState) {
          return AlertDialog(
            backgroundColor: AppColors.primarycolor,
            title: Text(
              showForm ? 'Confirm Location' : 'Select Location',
              style: TextStyle(color: AppColors.white),
            ),

            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// ================= STEP 1 =================
                  if (!showForm) ...[
                    _label("Country"),
                    Container(
                      // padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Countrywidget(
                        selectedLocation: selecteCountry,
                        onChanged: (value) {
                          dialogSetState(() {
                            selecteCountry = value;
                            countid = selecteCountry!.countryId.toString();
                            // print(countid);
                            selecteState = null;
                            selecteDistrict = null;
                          });
                        },
                      ),
                    ),

                    if (selecteCountry != null) ...[
                      const SizedBox(height: 12),
                      _label("State"),
                      Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Statewidget(
                          categoryId: selecteCountry!.countryId!,
                          selectedLocation: selecteState,
                          onChanged: (value) {
                            dialogSetState(() {
                              selecteState = value;
                              stateid = selecteState!.stateId.toString();

                              selecteDistrict = null;
                            });
                          },
                        ),
                      ),
                    ],

                    if (selecteState != null) ...[
                      const SizedBox(height: 12),
                      _label("District"),
                      Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Districtwidget(
                          categoryId: selecteState!.stateId!,
                          selectedLocation: selecteDistrict,
                          onChanged: (value) {
                            dialogSetState(() {
                              selecteDistrict = value;
                              distid = selecteDistrict!.districtId.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ],

                  /// ================= STEP 2 =================
                  if (showForm) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _filledField("Country", countryCtrl),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _filledField("State", stateCtrl),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _filledField("District", districtCtrl),
                    ),

                    // const SizedBox(height: 10),

                    /// PINCODE
                    _inputField("Pin Code", pincodeCtrl),
                  ],
                ],
              ),
            ),

            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel", style: TextStyle(color: AppColors.darkRed)),
              ),

              /// NEXT / SUBMIT
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen),
                onPressed: () {
                  if (!showForm) {
                    if (selecteCountry != null && selecteState != null && selecteDistrict != null) {
                      dialogSetState(() {
                        countryCtrl.text = selecteCountry!.countryName!;
                        stateCtrl.text = selecteState!.stateName!;
                        districtCtrl.text = selecteDistrict!.districtName!;
                        showForm = true;
                        // final scaffoldMessenger = ScaffoldMessenger.of(context);

                        // scaffoldMessenger.showSnackBar(
                        //   SnackBar(
                        //     content: Text("Uploaded"),
                        //     backgroundColor: Colors.redAccent, // Red for errors
                        //     behavior: SnackBarBehavior.floating, // Modern floating look
                        //     duration: Duration(seconds: 2),
                        //     // action: SnackBarAction(
                        //     //   label: 'RETRY',
                        //     //   textColor: Colors.white,
                        //     //   onPressed: () => firstnameController.clear(),
                        //     // ),
                        //   ),
                        // );
                      });
                    }
                  } else {
                    setState(() {
                      setState(() {
                        submitForm(
                          name.toString(),
                          "",
                          "",
                          "",
                          countid.toString(),
                          stateid.toString(),
                          distid.toString(),
                          pincodeCtrl.text,
                        );
                      });
                    });
                    print("Country: ${countryCtrl.text}");
                    print("State: ${stateCtrl.text}");
                    print("District: ${districtCtrl.text}");
                    print("Pincode: ${pincodeCtrl.text}");

                    // Navigator.pop(context);
                  }
                },
                child: Text(showForm ? "Submit" : "Proceed"),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _filledField(String label, TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: ctrl,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.black,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLength: 6,
        style: TextStyle(color: Colors.white),

        controller: ctrl,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.black,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _FirstshowLocationDialog(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.primarycolor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber_outlined, color: AppColors.darkRed),
            const SizedBox(height: 8),
            Text('Blood Donor Request', style: TextStyle(color: AppColors.white)),
          ],
        ),
        content: Text('Do you require blood?', style: TextStyle(color: AppColors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No', style: TextStyle(color: AppColors.darkRed)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close first dialog
              // _showLocationDialog(context, name); // open second dialog
              _askingcurrentLocationDialog(context, name.toString());
            },
            child: Text('Yes', style: TextStyle(color: AppColors.successGreen)),
          ),
        ],
      ),
    );
  }
}
