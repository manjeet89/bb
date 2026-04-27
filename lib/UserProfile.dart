// import 'dart:convert';

// import 'package:bb/ApiFolder/AllapiScreen.dart';
// import 'package:bb/HomeScreen.dart';
// import 'package:bb/main.dart';
// import 'package:bb/utils/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_animate/flutter_animate.dart';

// class Userprofile extends StatefulWidget {
//   const Userprofile({super.key});

//   @override
//   State<Userprofile> createState() => _UserprofileState();
// }

// class _UserprofileState extends State<Userprofile> {
//   var FirstName = "";
//   var LastName = "";
//   var Email = "";
//   var Number = "";
//   var Gender = "";
//   var Dateofbirth = "";
//   var Bloodname = "";
//   var UserAddress = "";
//   var Country = "";
//   var State = "";
//   var District = "";
//   var City = "";
//   var Pincode = "";
//   var ImageGet = "";

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     FetchData();
//   }

//   Future<void> FetchData() async {
//     var url = allapiscreen.userprofile.toString();
//     var Header = await allapiscreen.headerFunction();

//     print(Header.toString());
//     final response = await http.post(Uri.parse(url), headers: Header);

//     if (response.statusCode == 200) {
//       final decoded = json.decode(response.body);
//       // print(decoded['data']["user_first_name"]);

//       setState(() {
//         FirstName = decoded['data']["user_first_name"] ?? "null";
//         LastName = decoded['data']['user_last_name'] ?? "null";
//         Email = decoded['data']['user_email_id'] ?? "null";
//         Dateofbirth = decoded['data']['user_date_of_birth'] ?? "null";
//         Gender = decoded['data']['user_gender'] ?? "null";
//         Number = decoded['data']['user_mobile_number'] ?? "null";
//         Bloodname = decoded['data']['blood_name'] ?? "null";
//         UserAddress = decoded['data']['user_address'] ?? "null";
//         Country = decoded['data']['country_name'] ?? "null";
//         State = decoded['data']['state_name'] ?? "null";
//         District = decoded['data']['district_name'] ?? "null";
//         City = decoded['data']['user_city'] ?? "null";
//         Pincode = decoded['data']['user_pin_code'] ?? "null";
//         ImageGet = decoded['data']['user_profile_image'] ?? "null";
//       });
//     } else {
//       throw Exception("Failed to load pets");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Color(0XFFFFFFFF),
//       //   // foregroundColor: Colors.white,
//       //   title: const Text(
//       //     'User Profile',
//       //     style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
//       //   ),
//       //   centerTitle: true,
//       // ),
//       appBar: AppBar(
//         backgroundColor: AppColors.primarycolor,
//         title: const Text(
//           'User Profile',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//         ),
//         centerTitle: true,
//       ),
//       backgroundColor: AppColors.white,
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await FetchData(); // Reload data when user performs swipe gesture
//           setState(() {});
//         },
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 600), // Limits width on Web/Desktop
//               child: Column(
//                 children: [
//                   // Header section
//                   Card(
//                     elevation: 11,
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),

//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: AppColors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: AppColors.secondrycolor,
//                             blurRadius: 2,
//                             offset: Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           CircleAvatar(
//                             radius: 50,
//                             backgroundColor: Colors.white,
//                             child: ImageGet == "null"
//                                 ? Image.asset('assest/petbird.png')
//                                 : CircleAvatar(
//                                     radius: 50,
//                                     backgroundColor: Colors.grey.shade300,
//                                     backgroundImage: NetworkImage(
//                                       allapiscreen.imageapi.toString() + ImageGet,
//                                     ),
//                                   ),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             '$FirstName $LastName',
//                             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                           ),
//                           // const Text('User ID: 2', style: TextStyle(color: Colors.grey)),
//                           const SizedBox(height: 10),

//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Align(
//                               alignment: Alignment.centerRight,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: AppColors.primarycolor, // Primary red
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 onPressed: () async {
//                                   final result = await navigatorKey.currentState?.pushNamed(
//                                     '/userRegistration',
//                                   );
//                                   if (result == true) {
//                                     FetchData(); // Reload data when returning from UpdateProfile
//                                   }
//                                 },
//                                 child: const Text(
//                                   'Update Profile',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ].animate().fadeIn(delay: 200.ms).slideX(),
//                       ),
//                     ),
//                   ),

//                   // Profile Fields
//                   _buildInfoCard(
//                     [
//                           _infoTile(Icons.phone, 'Mobile Number', Number),
//                           _infoTile(Icons.email, 'Email', Email),
//                           _infoTile(
//                             Icons.cake,
//                             "Date of Birth",
//                             Dateofbirth == "null" ? "" : Dateofbirth,
//                           ),
//                           _infoTile(
//                             Icons.person_outline,
//                             'Gender',
//                             Gender == "0" ? "Female" : "Male",
//                           ),
//                           _infoTile(Icons.bloodtype, 'Blood Group', Bloodname),
//                           _infoTile(
//                             Icons.location_on,
//                             'Postal Address',
//                             "$UserAddress $City $Country $State $District",
//                           ),
//                           _infoTile(Icons.pin_drop, 'Pin Code / Zip Code', Pincode),
//                         ]
//                         .animate(interval: 200.ms) // Staggers the animation for each child
//                         .fade(duration: 100.ms)
//                         .slide(),
//                   ),

//                   const SizedBox(height: 10),

//                   // Affiliate Section
//                   // _buildInfoCard([
//                   //   ListTile(
//                   //     leading: const Icon(Icons.share, color: AppColors.secondrycolor),
//                   //     title: const Text(
//                   //       'Affiliate Link',
//                   //       style: TextStyle(fontWeight: FontWeight.bold),
//                   //     ),
//                   //     subtitle: const Text('Become an Affiliate'),
//                   //     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                   //     onTap: () {
//                   //       Navigator.push(
//                   //         context,
//                   //         MaterialPageRoute(builder: (context) => BloodBankHome()),
//                   //       );

//                   //       // Add affiliate link logic here
//                   //     },
//                   //   ),
//                   // ]),
//                 ],
//                 // .animate(interval: 200.ms) // Staggers the animation for each child
//                 // .fade(duration: 100.ms)
//                 // .slide(),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // UI Helper for a grouped card
// Widget _buildInfoCard(List<Widget> children) {
//   return Card(
//     color: Colors.white,
//     margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//     elevation: 11,

//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(12),
//       side: BorderSide(color: const Color(0xFF1A73E8)),
//     ),
//     child: Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: const [
//           BoxShadow(color: AppColors.secondrycolor, blurRadius: 2, offset: Offset(0, 4)),
//         ],
//       ),
//       child: Column(children: children),
//     ),
//   );
// }

// // UI Helper for each data row
// Widget _infoTile(IconData icon, String label, String value) {
//   return ListTile(
//     leading: Icon(icon, color: AppColors.secondrycolor),
//     title: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.fontGrey)),
//     subtitle: Text(
//       value,
//       style: const TextStyle(fontSize: 16, color: AppColors.textDark, fontWeight: FontWeight.w500),
//     ),
//   );
// }

import 'dart:convert';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Header.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  String formattedDate = "-";
  String firstName = "",
      orgtype = "",
      orgName = "",
      lastName = "",
      email = "",
      number = "",
      gender = "",
      dob = "",
      blood = "",
      address = "",
      country = "",
      state = "",
      district = "",
      city = "",
      pincode = "",
      image = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = allapiscreen.userprofile.toString();
    final header = await allapiscreen.headerFunction();

    final response = await http.post(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];

      setState(() {
        firstName = data['user_first_name'] ?? "";
        orgName = data['organisation_name'] ?? "";
        orgtype = data['owner_type'] ?? "";
        lastName = data['user_last_name'] ?? "";
        email = data['user_email_id'] ?? "";
        number = data['user_mobile_number'] ?? "";
        gender = data['user_gender'] ?? "";
        dob = data['user_date_of_birth'] ?? "";
        blood = data['blood_name'] ?? "";
        address = data['user_address'] ?? "";
        country = data['country_name'] ?? "";
        state = data['state_name'] ?? "";
        district = data['district_name'] ?? "";
        city = data['user_city'] ?? "";
        pincode = data['user_pin_code'] ?? "";
        image = data['user_profile_image'] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dob.toString().isNotEmpty) {
      final inputFormat = DateFormat('d-MM-yyyy');
      final outputFormat = DateFormat('dd-MMMM-yyyy');
      print(dob.toString());

      DateTime date = inputFormat.parse(dob.toString());
      formattedDate = outputFormat.format(date);
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBar(),

      body: RefreshIndicator(
        onRefresh: fetchData,
        child: CustomScrollView(
          slivers: [
            _buildHeader(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _infoCard([
                      _infoRow(Icons.phone, "Mobile", number),
                      if (orgtype == "1") _infoRow(Icons.groups_2, "Organization Name", orgName),
                      _infoRow(Icons.email, "Email", email),
                      _infoRow(Icons.cake, "DOB", formattedDate),
                      _infoRow(Icons.person, "Gender", gender == "0" ? "Female" : "Male"),
                      _infoRow(Icons.bloodtype, "Blood Group", blood),
                    ]),
                    const SizedBox(height: 16),
                    _infoCard([
                      _infoRow(Icons.location_on, "Address", "$address, $city"),
                      _infoRow(Icons.map, "District", district),
                      _infoRow(Icons.flag, "State", state),
                      _infoRow(Icons.public, "Country", country),
                      _infoRow(Icons.pin_drop, "Pincode", pincode),
                    ]),
                  ].animate(interval: 120.ms).fadeIn().slideY(begin: 0.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- HEADER ----------------
  SliverAppBar _buildHeader() {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: AppColors.CatSilhouter,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          "$firstName $lastName",
          style: const TextStyle(fontSize: 16, color: AppColors.AddButtonColor, fontWeight: FontWeight.bold),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // AppColors.primarycolor
                AppColors.AddButtonColor,
                AppColors. CatSilhouter,
                // , AppColors.secondrycolor
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(height: 40),
              // CircleAvatar(
              //   radius: 60,
              //   backgroundColor: Colors.white,
              //   backgroundImage: image.isEmpty
              //       ? const AssetImage("assest/petbird.png")
              //       : NetworkImage(allapiscreen.imageapi + image) as ImageProvider,
              // ).animate().fadeIn(duration: 400.ms).scale(),
              // const SizedBox(height: 12),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    backgroundImage: image.isEmpty
                        ? const AssetImage("assest/catdog.jpeg")
                        : NetworkImage(allapiscreen.imageapi + image) as ImageProvider,
                  ).animate().fadeIn(duration: 400.ms).scale(),

                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () async {
                        final result = await navigatorKey.currentState?.pushNamed(
                          '/userRegistration',
                        );
                        if (result == true) fetchData();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primarycolor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:  AppColors.CatSilhouter
                            
                              .withOpacity(0.25),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.edit, color: Colors.white, size: 18),
                      ),
                    ).animate().fadeIn(delay: 300.ms).scale(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------- INFO CARD ----------------
Widget _infoCard(List<Widget> children) {
  return Card(
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(children: children),
    ),
  );
}

/// ---------------- INFO ROW ----------------
Widget _infoRow(IconData icon, String label, String value) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: AppColors.secondrycolor.withOpacity(.1),
      child: Icon(icon, color: AppColors.CatSilhouter),
    ),
    title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    subtitle: Text(
      value.isEmpty ? "-" : value,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: AppColors.AddButtonColor,
      ),
    ),
  );
}
