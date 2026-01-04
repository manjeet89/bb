import 'dart:convert';

import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/HomeScreen.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchData();
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
        FirstName = decoded['data']["user_first_name"] ?? "null";
        LastName = decoded['data']['user_last_name'] ?? "null";
        Email = decoded['data']['user_email_id'] ?? "null";
        Dateofbirth = decoded['data']['user_date_of_birth'] ?? "null";
        Gender = decoded['data']['user_gender'] ?? "null";
        Number = decoded['data']['user_mobile_number'] ?? "null";
        Bloodname = decoded['data']['blood_name'] ?? "null";
        UserAddress = decoded['data']['user_address'] ?? "null";
        Country = decoded['data']['country_name'] ?? "null";
        State = decoded['data']['state_name'] ?? "null";
        District = decoded['data']['district_name'] ?? "null";
        City = decoded['data']['user_city'] ?? "null";
        Pincode = decoded['data']['user_pin_code'] ?? "null";
        ImageGet = decoded['data']['user_profile_image'] ?? "null";
      });
    } else {
      throw Exception("Failed to load pets");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0XFFFFFFFF),
      //   // foregroundColor: Colors.white,
      //   title: const Text(
      //     'User Profile',
      //     style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
      //   ),
      //   centerTitle: true,
      // ),
      appBar: AppBar(
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          'User Profile',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          await FetchData(); // Reload data when user performs swipe gesture
          setState(() {});
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600), // Limits width on Web/Desktop
              child: Column(
                children: [
                  // Header section
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: ImageGet == "null"
                        ? Image.asset('assest/petbird.png')
                        : CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: NetworkImage(
                              allapiscreen.imageapi.toString() + ImageGet,
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    FirstName + ' ' + LastName,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  // const Text('User ID: 2', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primarycolor, // Primary red
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () async {
                          final result = await navigatorKey.currentState?.pushNamed(
                            '/userRegistration',
                          );
                          if (result == true) {
                            FetchData(); // Reload data when returning from UpdateProfile
                          }
                        },
                        child: const Text('Update Profile', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),

                  // Profile Fields
                  _buildInfoCard([
                    _infoTile(Icons.phone, 'Mobile Number', Number),
                    _infoTile(Icons.email, 'Email', Email),
                    _infoTile(
                      Icons.cake,
                      "Date of Birth",
                      Dateofbirth == "null" ? "" : Dateofbirth,
                    ),
                    _infoTile(Icons.person_outline, 'Gender', Gender == "0" ? "Female" : "Male"),
                    _infoTile(Icons.bloodtype, 'Blood Group', Bloodname),
                    _infoTile(
                      Icons.location_on,
                      'Postal Address',
                      UserAddress + " " + City + " " + Country + " " + State + " " + District,
                    ),
                    _infoTile(Icons.pin_drop, 'Pin Code / Zip Code', Pincode),
                  ]),

                  const SizedBox(height: 10),

                  // Affiliate Section
                  _buildInfoCard([
                    ListTile(
                      leading: const Icon(Icons.share, color: AppColors.secondrycolor),
                      title: const Text(
                        'Affiliate Link',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('Become an Affiliate'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BloodBankHome()),
                        );

                        // Add affiliate link logic here
                      },
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// UI Helper for a grouped card
Widget _buildInfoCard(List<Widget> children) {
  return Card(
    color: Colors.white,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    elevation: 0,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: const Color(0xFF1A73E8)),
    ),
    child: Column(children: children),
  );
}

// UI Helper for each data row
Widget _infoTile(IconData icon, String label, String value) {
  return ListTile(
    leading: Icon(icon, color: AppColors.secondrycolor),
    title: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.fontGrey)),
    subtitle: Text(
      value,
      style: const TextStyle(fontSize: 16, color: AppColors.textDark, fontWeight: FontWeight.w500),
    ),
  );
}

// import 'package:flutter/material.dart';

// class Userprofile extends StatefulWidget {
//   const Userprofile({super.key});

//   @override
//   State<Userprofile> createState() => _UserprofileState();
// }

// class _UserprofileState extends State<Userprofile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile'), centerTitle: true),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Breakpoint for Desktop/Tablet
//           double padding = constraints.maxWidth > 600 ? 50.0 : 20.0;
//           return SingleChildScrollView(
//             padding: EdgeInsets.all(padding),
//             child: Center(
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxWidth: 600), // Limits width on Web/Desktop
//                 child: Column(
//                   children: [
//                     const CircleAvatar(radius: 60, backgroundImage: NetworkImage('picsum.photos')),
//                     const SizedBox(height: 20),
//                     const Text(
//                       'Tushar',
//                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     const Text('tushare@example.com', style: TextStyle(color: Colors.grey)),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFFC62828), // Primary red
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                       ),
//                       onPressed: () {},
//                       child: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
//                     ),
//                     const Divider(height: 40),
//                     _buildProfileItem(Icons.settings, 'Settings'),
//                     _buildProfileItem(Icons.history, 'Order History'),
//                     _buildProfileItem(Icons.logout, 'Logout', color: Colors.red),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// Widget _buildProfileItem(IconData icon, String title, {Color? color}) {
//   return ListTile(
//     leading: Icon(icon, color: color),
//     title: Text(title, style: TextStyle(color: color)),
//     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//     onTap: () {},
//   );
// }
