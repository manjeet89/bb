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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoginCheck();
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

  void submitForm(String petId, String digipin, String lat, String lng) async {
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

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          "My Pets 🐾",
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
                    padding: const EdgeInsets.all(12),
                    itemCount: pets.length,
                    itemBuilder: (context, index) {
                      final pet = pets[index];
                      List reqnumber = pet.petBirthDate.toString().split(" ");
                      String req = reqnumber[0];

                      return InkWell(
                        onTap: () async {
                          String digiPin = await _listenLocation();
                          List divi = digiPin.split("/");
                          String digi = divi[0];
                          String lat = divi[1];
                          String lng = divi[2];
                          print("get digipin" + digiPin);
                          submitForm(pet.petId.toString(), digi, lat, lng);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),

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
                            color: AppColors.backgrounLightGrey,
                            // gradient: const LinearGradient(
                            //   colors: [
                            //     Color(0xff7A0000), // Dark blood red (LEFT)
                            //     Color(0xffC62828), // Medium red
                            //     Color(0xffFF6F6F), // Light red (RIGHT)
                            //   ],
                            //   begin: Alignment.centerLeft,
                            //   end: Alignment.centerRight,
                            // ),
                            borderRadius: BorderRadius.circular(20),
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
                                    radius: 34,
                                    backgroundImage: pet.petImage!.isNotEmpty
                                        ? NetworkImage(
                                            "https://pashuraktkosh.lyferp.com/${pet.petImage}",
                                          )
                                        : const AssetImage("assest/bblogo.png") as ImageProvider,
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
                                    String digiPin = await _listenLocation();
                                    List divi = digiPin.split("/");
                                    String digi = divi[0];
                                    String lat = divi[1];
                                    String lng = divi[2];
                                    print("get digipin" + digiPin);
                                    submitForm(pet.petId.toString(), digi, lat, lng);
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
}
