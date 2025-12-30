import 'dart:convert';

import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Morescreen extends StatefulWidget {
  const Morescreen({super.key});

  @override
  State<Morescreen> createState() => _MorescreenState();
}

class _MorescreenState extends State<Morescreen> {
  var FirstName = "";
  var LastName = "";
  var email = "";
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
        email = decoded['data']['user_email_id'] ?? "null";
        ImageGet = decoded['data']['user_profile_image'] ?? "null";
      });
    } else {
      throw Exception("Failed to load pets");
    }
  }

  @override
  Widget build(BuildContext context) {
    print(FirstName + "withem");
    return PopScope(
      canPop: false, // Prevents the app from closing
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return; // If already popped, do nothing

        // Always navigate to Home when back is pressed
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primarycolor,
          title: const Text(
            'Profile',
            style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),

        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   backgroundColor: Colors.green,
        //   foregroundColor: Colors.white,
        //   onPressed: () {
        //     setState(() {
        //       navigatorKey.currentState?.pushNamed('/userRegistration');
        //     });
        //   },
        // ),
        backgroundColor: AppColors.cardBackgroundWhite,

        body: Container(
          color: AppColors.cardBackgroundWhite,

          child: LayoutBuilder(
            builder: (context, constraints) {
              // Breakpoint for Desktop/Tablet
              double padding = constraints.maxWidth > 600 ? 50.0 : 20.0;
              return FirstName.toString() == ""
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      padding: EdgeInsets.all(padding),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 600,
                          ), // Limits width on Web/Desktop
                          child: Container(
                            // color: AppColors.backgrounLightGrey,
                            child: Column(
                              children: [
                                Visibility(
                                  visible: FirstName == "null" ? false : true,
                                  child: // Header section
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
                                ),
                                const SizedBox(height: 20),
                                Visibility(
                                  visible: FirstName == "null" ? false : true,
                                  child: Text(
                                    FirstName + " " + LastName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primarycolor,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: FirstName == "null" ? false : true,
                                  child: Text(email, style: TextStyle(color: AppColors.fontGrey)),
                                ),
                                const SizedBox(height: 20),

                                FirstName == "null"
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primarycolor,
                                          // Primary red
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () {
                                          navigatorKey.currentState?.pushNamed('/userRegistration');
                                        },
                                        child: const Text(
                                          'Update Profile',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primarycolor,
                                          // Primary red
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () {
                                          navigatorKey.currentState?.pushNamed('/profile');
                                        },
                                        child: const Text(
                                          'Profile',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                const Divider(height: 40),
                                _buildProfileItem(Icons.policy, 'Privacy & Policy'),
                                _buildProfileItem(Icons.perm_contact_cal, 'Contact'),
                                _buildProfileforlogout(Icons.logout, 'Logout', color: Colors.red),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildProfileItem(IconData icon, String title, {Color? color}) {
  return ListTile(
    leading: Icon(icon, color: AppColors.warningOrange, fontWeight: FontWeight.w700),
    title: Text(
      title,
      style: TextStyle(color: color, fontWeight: FontWeight.w600),
    ),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () async {},
  );
}

Widget _buildProfileforlogout(IconData icon, String title, {Color? color}) {
  return ListTile(
    leading: Icon(icon, color: AppColors.warningOrange, fontWeight: FontWeight.w700),
    title: Text(
      title,
      style: TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.w600),
    ),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Or use prefs.remove('auth_token')
      navigatorKey.currentState?.pushReplacementNamed('/login');
    },
  );
}
