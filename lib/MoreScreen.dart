// import 'dart:convert';
// import 'package:firebase_analytics/firebase_analytics.dart';

// import 'package:bb/ApiFolder/AllapiScreen.dart';
// import 'package:bb/main.dart';
// import 'package:bb/utils/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class Morescreen extends StatefulWidget {
//   const Morescreen({super.key});

//   @override
//   State<Morescreen> createState() => _MorescreenState();
// }

// class _MorescreenState extends State<Morescreen> {
//   var FirstName = "";
//   var LastName = "";
//   var email = "";
//   var ImageGet = "";

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     LoginCheck();

//     FetchData();
//   }

//   Future<void> LoginCheck() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//     print(isLoggedIn.toString());
//     if (isLoggedIn.toString() == "false") {
//       setState(() {
//         FirstName = "False";
//       });
//     }
//     // setState(() {

//     // });
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
//         email = decoded['data']['user_email_id'] ?? "null";
//         ImageGet = decoded['data']['user_profile_image'] ?? "null";
//       });
//     } else {
//       throw Exception("Failed to load pets");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("${FirstName}withem");
//     return PopScope(
//       canPop: false, // Prevents the app from closing
//       onPopInvokedWithResult: (didPop, result) {
//         if (didPop) return; // If already popped, do nothing

//         // Always navigate to Home when back is pressed
//         Navigator.pushReplacementNamed(context, '/home');
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.primarycolor,
//           title: const Text(
//             'Profile',
//             style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//         ),

//         // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//         // floatingActionButton: FloatingActionButton(
//         //   child: Icon(Icons.add),
//         //   backgroundColor: Colors.green,
//         //   foregroundColor: Colors.white,
//         //   onPressed: () {
//         //     setState(() {
//         //       navigatorKey.currentState?.pushNamed('/userRegistration');
//         //     });
//         //   },
//         // ),
//         backgroundColor: AppColors.cardBackgroundWhite,

//         body: RefreshIndicator(
//           onRefresh: () async {
//             await FetchData(); // Reload data when user performs swipe gesture
//             setState(() {});
//           },
//           child: FirstName == "False"
//               ? Container(
//                   color: AppColors.cardBackgroundWhite,

//                   child: LayoutBuilder(
//                     builder: (context, constraints) {
//                       // Breakpoint for Desktop/Tablet
//                       double padding = constraints.maxWidth > 600 ? 50.0 : 20.0;
//                       return FirstName.toString() == ""
//                           ? Center(child: CircularProgressIndicator())
//                           : SingleChildScrollView(
//                               padding: EdgeInsets.all(padding),
//                               child: Center(
//                                 child: ConstrainedBox(
//                                   constraints: const BoxConstraints(
//                                     maxWidth: 600,
//                                   ), // Limits width on Web/Desktop
//                                   child: Container(
//                                     // color: AppColors.backgrounLightGrey,
//                                     child: Column(
//                                       children: [
//                                         CircleAvatar(
//                                           radius: 50,
//                                           backgroundColor: Colors.white,
//                                           child: Image.asset('assest/petbird.png'),
//                                         ),
//                                         const SizedBox(height: 20),
//                                         Text(
//                                           "Welcome to pashuRaktKosh.",
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                             color: AppColors.secondrycolor,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 20),

//                                         ElevatedButton(
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: AppColors.primarycolor,
//                                             // Primary red
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                           ),
//                                           onPressed: () async {
//                                             final result = await navigatorKey.currentState
//                                                 ?.pushNamed('/login');
//                                             if (result == null) {
//                                               FetchData(); // Reload data when returning from UpdateProfile
//                                             }
//                                             // navigatorKey.currentState?.pushNamed('/userRegistration');
//                                           },
//                                           child: const Text(
//                                             'Go to Login',
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                         ),

//                                         const Divider(height: 40),
//                                         _buildProfileItem(
//                                           Icons.policy,
//                                           'Privacy & Policy',
//                                           "privacyPolicy",
//                                         ),
//                                         _buildProfileItem(
//                                           Icons.note,
//                                           'Terms and Conditions',
//                                           "termsConditions",
//                                         ),
//                                         _buildProfileItem(
//                                           Icons.money,
//                                           'Refunds and Cancellation',
//                                           "refundCalcilcation",
//                                         ),
//                                         _buildProfileItem(
//                                           Icons.local_shipping,
//                                           'Shipping Policies',
//                                           "shinpingPolicy",
//                                         ),
//                                         _buildProfileforlogout(
//                                           Icons.logout,
//                                           'Logout',
//                                           color: Colors.red,
//                                         ),
//                                         FirstName != "False"
//                                             ? _buildProfileforlogout(
//                                                 Icons.logout,
//                                                 'Logout',
//                                                 color: Colors.red,
//                                               )
//                                             : Text(""),
//                                       ].animate().fadeIn(delay: 200.ms).slideX(),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                     },
//                   ),
//                 )
//               : Container(
//                   color: AppColors.cardBackgroundWhite,

//                   child: LayoutBuilder(
//                     builder: (context, constraints) {
//                       // Breakpoint for Desktop/Tablet
//                       double padding = constraints.maxWidth > 600 ? 50.0 : 20.0;
//                       return FirstName.toString() == ""
//                           ? Center(child: CircularProgressIndicator())
//                           : SingleChildScrollView(
//                               padding: EdgeInsets.all(padding),
//                               child: Center(
//                                 child: ConstrainedBox(
//                                   constraints: const BoxConstraints(
//                                     maxWidth: 600,
//                                   ), // Limits width on Web/Desktop
//                                   child: Container(
//                                     // color: AppColors.backgrounLightGrey,
//                                     child: Column(
//                                       children: [
//                                         Card(
//                                           elevation: 11,
//                                           child: Container(
//                                             padding: const EdgeInsets.all(20),
//                                             decoration: BoxDecoration(
//                                               color: AppColors.white,
//                                               borderRadius: BorderRadius.circular(8),
//                                               boxShadow: const [
//                                                 BoxShadow(
//                                                   color: AppColors.secondrycolor,
//                                                   blurRadius: 2,
//                                                   offset: Offset(0, 4),
//                                                 ),
//                                               ],
//                                             ),
//                                             width: double.infinity,
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                               mainAxisAlignment: MainAxisAlignment.center,
//                                               children: [
//                                                 const SizedBox(height: 10),

//                                                 Visibility(
//                                                   visible: FirstName == "null" ? false : true,
//                                                   child: // Header section
//                                                   CircleAvatar(
//                                                     radius: 50,
//                                                     backgroundColor: Colors.white,
//                                                     child: ImageGet == "null"
//                                                         ? Image.asset('assest/petbird.png')
//                                                         : CircleAvatar(
//                                                             radius: 50,
//                                                             backgroundColor: Colors.grey.shade300,
//                                                             backgroundImage: NetworkImage(
//                                                               allapiscreen.imageapi.toString() +
//                                                                   ImageGet,
//                                                             ),
//                                                           ),
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 20),
//                                                 Visibility(
//                                                   visible: FirstName == "null" ? false : true,
//                                                   child: Text(
//                                                     "$FirstName $LastName",
//                                                     style: TextStyle(
//                                                       fontSize: 20,
//                                                       fontWeight: FontWeight.bold,
//                                                       color: AppColors.primarycolor,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Visibility(
//                                                   visible: FirstName == "null" ? false : true,
//                                                   child: Text(
//                                                     email,
//                                                     style: TextStyle(color: AppColors.fontGrey),
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 20),

//                                                 FirstName == "null"
//                                                     ? ElevatedButton(
//                                                         style: ElevatedButton.styleFrom(
//                                                           backgroundColor: AppColors.primarycolor,
//                                                           // Primary red
//                                                           shape: RoundedRectangleBorder(
//                                                             borderRadius: BorderRadius.circular(8),
//                                                           ),
//                                                         ),
//                                                         onPressed: () async {
//                                                           await FirebaseAnalytics.instance.logEvent(
//                                                             name: 'profile',
//                                                             parameters: {
//                                                               'button_id': 'profile_button',
//                                                               'location': 'profilePage',
//                                                             },
//                                                           );

//                                                           final result = await navigatorKey
//                                                               .currentState
//                                                               ?.pushNamed('/userRegistration');
//                                                           if (result == null) {
//                                                             FetchData(); // Reload data when returning from UpdateProfile
//                                                           }
//                                                           // navigatorKey.currentState?.pushNamed('/userRegistration');
//                                                         },
//                                                         child: const Text(
//                                                           'Update Profile',
//                                                           style: TextStyle(color: Colors.white),
//                                                         ),
//                                                       )
//                                                     : ElevatedButton(
//                                                         style: ElevatedButton.styleFrom(
//                                                           backgroundColor: AppColors.primarycolor,
//                                                           // Primary red
//                                                           shape: RoundedRectangleBorder(
//                                                             borderRadius: BorderRadius.circular(8),
//                                                           ),
//                                                         ),
//                                                         onPressed: () async {
//                                                           final result = await navigatorKey
//                                                               .currentState
//                                                               ?.pushNamed('/profile');
//                                                           print(result);
//                                                           if (result == null) {
//                                                             FetchData(); // Reload data when returning from UpdateProfile
//                                                           }
//                                                           // navigatorKey.currentState?.pushNamed('/profile');
//                                                         },
//                                                         child: const Text(
//                                                           'Profile',
//                                                           style: TextStyle(color: Colors.white),
//                                                         ),
//                                                       ),
//                                                 // const SizedBox(height: 40),
//                                               ],
//                                             ),
//                                           ),
//                                         ),

//                                         const Divider(height: 40),
//                                         _buildProfileItem(
//                                           Icons.policy,
//                                           'Privacy & Policy',
//                                           "privacyPolicy",
//                                         ),
//                                         _buildProfileItem(
//                                           Icons.note,
//                                           'Terms and Conditions',
//                                           "termsConditions",
//                                         ),
//                                         _buildProfileItem(
//                                           Icons.money,
//                                           'Refunds and Cancellation',
//                                           "refundCalcilcation",
//                                         ),
//                                         _buildProfileItem(
//                                           Icons.local_shipping,
//                                           'Shipping Policies',
//                                           "shinpingPolicy",
//                                         ),
//                                         _buildProfileforlogout(
//                                           Icons.logout,
//                                           'Logout',
//                                           color: Colors.red,
//                                         ),
//                                       ].animate().fadeIn(delay: 200.ms).slideX(),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                     },
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }

// Widget _buildProfileItem(IconData icon, String title, String classname, {Color? color}) {
//   return ListTile(
//     leading: Icon(icon, color: AppColors.warningOrange, fontWeight: FontWeight.w700),
//     title: Text(
//       title,
//       style: TextStyle(color: color, fontWeight: FontWeight.w600),
//     ),
//     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//     onTap: () async {
//       navigatorKey.currentState?.pushNamed('/$classname');
//     },
//   );
// }

// Widget _buildProfileItemforprivay(IconData icon, String title, {Color? color}) {
//   return ListTile(
//     leading: Icon(icon, color: AppColors.warningOrange, fontWeight: FontWeight.w700),
//     title: Text(
//       title,
//       style: TextStyle(color: color, fontWeight: FontWeight.w600),
//     ),
//     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//     onTap: () async {
//       print('hii');
//       navigatorKey.currentState?.pushReplacementNamed('/privacyPolicy');
//     },
//   );
// }

// Widget _buildProfileforlogout(IconData icon, String title, {Color? color}) {
//   return ListTile(
//     leading: Icon(icon, color: AppColors.warningOrange, fontWeight: FontWeight.w700),
//     title: Text(
//       title,
//       style: TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.w600),
//     ),
//     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//     onTap: () async {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.clear(); // Or use prefs.remove('auth_token')
//       navigatorKey.currentState?.pushReplacementNamed('/home');
//     },
//   );
// }

import 'dart:convert';
import 'package:bb/Header.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Morescreen extends StatefulWidget {
  const Morescreen({super.key});

  @override
  State<Morescreen> createState() => _MorescreenState();
}

class _MorescreenState extends State<Morescreen> {
  String firstName = "";
  String lastName = "";
  String email = "";
  String image = "";
  bool isLoggedIn = true;

  @override
  void initState() {
    super.initState();
    _checkLogin();
    _fetchProfile();
  }

  Future<void> _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  Future<void> _fetchProfile() async {
    var url = allapiscreen.userprofile.toString();
    var header = await allapiscreen.headerFunction();

    final response = await http.post(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      setState(() {
        firstName = decoded['data']['user_first_name'] ?? "";
        lastName = decoded['data']['user_last_name'] ?? "";
        email = decoded['data']['user_email_id'] ?? "";
        image = decoded['data']['user_profile_image'] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF5F6FA),
        // appBar: AppBar(
        //   backgroundColor: AppColors.primarycolor,
        //   title: const Text(
        //     "Profile",
        //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        //   ),
        //   centerTitle: true,
        // ),
        appBar: const CommonAppBar(),

        body: RefreshIndicator(
          onRefresh: () async => _fetchProfile(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(children: [_profileHeader(), const SizedBox(height: 24), _menuSection()]),
          ),
        ),
      ),
    );
  }

  // ---------------- PROFILE HEADER ----------------

  Widget _profileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.AddButtonColor, AppColors.CatSilhouter],
          //[AppColors.primarycolor, AppColors.secondrycolor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.primarycolor.withOpacity(.4),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 46,
            backgroundColor: Colors.white,
            backgroundImage: image.isNotEmpty
                ? NetworkImage(allapiscreen.imageapi + image)
                : const AssetImage("assest/catdog.jpeg") as ImageProvider,
          ),
          const SizedBox(height: 12),
          Text(
            isLoggedIn ? "$firstName $lastName" : "Welcome to PashuRaktKosh",
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (isLoggedIn) Text(email, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primarycolor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () async {
              final route = isLoggedIn ? '/profile' : '/login';
              final result = await navigatorKey.currentState?.pushNamed(route);
              if (result == null) _fetchProfile();
            },
            child: Text(isLoggedIn ? "View Profile" : "Go to Login",style: TextStyle(color: AppColors.AddButtonColor),),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.2);
  }

  // ---------------- MENU SECTION ----------------

  Widget _menuSection() {
    return Column(
      children: [
        if (isLoggedIn)
          _menuCardDeactivate(Icons.disabled_visible_outlined, "Deactivate Account", ""),
        _menuCard(Icons.policy, "Privacy Policy", "privacyPolicy"),
        _menuCard(Icons.note, "Terms & Conditions", "termsConditions"),
        _menuCard(Icons.money, "Refunds & Cancellation", "refundCalcilcation"),
        _menuCard(Icons.local_shipping, "Shipping Policies", "shinpingPolicy"),
        _menuCard(Icons.align_vertical_bottom_rounded, "About Us", "Aboutsus"),
        if (isLoggedIn) _menuCard(Icons.logout, "Logout", "", color: Colors.red, onTap: _logout),
      ].animate(interval: 120.ms).fadeIn().slideX(),
    );
  }

  Widget _menuCard(IconData icon, String title, String route, {Color? color, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.CatSilhouter.withOpacity(.15),
          child: Icon(icon, color: AppColors.CatSilhouter),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, color: color ?? AppColors.AddButtonColor),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap:
            onTap ??
            () {
              navigatorKey.currentState?.pushNamed('/$route');
            },
      ),
    );
  }

  Widget _menuCardDeactivate(
    IconData icon,
    String title,
    String route, {
    Color? color,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 10)],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.CatSilhouter.withOpacity(.15),
          child: Icon(icon, color: AppColors.CatSilhouter),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, color: color ?? AppColors.AddButtonColor),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap:
            onTap ??
            () {
              ShowDigiPin(context);
              // navigatorKey.currentState?.pushNamed('/$route');
            },
      ),
    );
  }

  void ShowDigiPin(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.primarycolor,
        title: Column(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.darkRed.withOpacity(.15),
              child: Icon(Icons.bloodtype, color: AppColors.darkRed, size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              "You want to deactivate your account",
              style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),

        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Cancel", style: TextStyle(color: AppColors.darkRed)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.successGreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () async {
              var url = allapiscreen.deactivate.toString();
              var header = await allapiscreen.headerFunction();

              final response = await http.post(Uri.parse(url), headers: header);
              print(jsonDecode(response.body).toString());

              if (response.statusCode == 200) {
                _logout();
                final data = jsonDecode(response.body);
                print(data);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Deactivate Account."),
                    backgroundColor: AppColors.successGreen,
                  ),
                );
              } else {
                // Handle error (e.g., show a snackbar)
                print('Login failed: ${response.body}');
              }
            },
            child: const Text("Proceed"),
          ),
        ],
      ),
    );
  }

  // ---------------- LOGOUT ----------------

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    navigatorKey.currentState?.pushReplacementNamed('/home');
  }
}
