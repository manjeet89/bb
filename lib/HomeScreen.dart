// import 'package:bb/main.dart';
// import 'package:bb/utils/app_colors.dart';
// import 'package:flutter/material.dart';

// class BloodBankHome extends StatelessWidget {
//   const BloodBankHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         final shouldExit = await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text('Exit App'),
//             content: Text('Are you sure you want to exit?'),
//             actions: [
//               TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text('Cancel')),
//               TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Exit')),
//             ],
//           ),
//         );
//         return shouldExit ?? false;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,

//         appBar: AppBar(
//           backgroundColor: Color(0XFFFFFFFF),
//           // foregroundColor: Colors.white,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Image.asset("assest/bblogo.png", scale: 3),
//               InkWell(
//                 onTap: () {
//                   navigatorKey.currentState?.pushNamed('/sos');
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,

//                     children: [
//                       Icon(Icons.notifications_active_sharp, color: AppColors.errorRed),
//                       Icon(Icons.sos_sharp, color: AppColors.errorRed),
//                     ],
//                   ),
//                 ),
//               ),
//               // const Text(
//               //   'PashuRaktKosh',
//               //   style: const TextStyle(
//               //     fontSize: 16,
//               //     color: Colors.black87,
//               //     fontWeight: FontWeight.w500,
//               //   ),
//               // ),
//             ],
//           ),
//           actions: [Column(children: [

//               ],
//             )],
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // const SizedBox(height: 24),
//               // 1. Hero Card
//               Center(child: _buildHeroCard()),
//               const SizedBox(height: 24),

//               // 2. Blood Groups Section
//               Center(
//                 child: const Text(
//                   textAlign: TextAlign.center,
//                   'Current Blood \nAvailablity',
//                   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               _buildBloodGrid(),
//               const SizedBox(height: 24),

//               // 3. How it Works (Registration Workflow)
//               // const Text(
//               //   'How Registration Works',
//               //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               // ),
//               // const SizedBox(height: 12),
//               // _buildWorkflowSteps(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeroCard() {
//     return Card(
//       // color: const Color(0xFFA41214),
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.cardBackgroundWhite,
//           // gradient: const LinearGradient(
//           //   colors: [
//           //     Color(0xff7A0000), // Dark blood red (LEFT)
//           //     Color(0xffC62828), // Medium red
//           //     Color(0xffFF6F6F), // Light red (RIGHT)
//           //   ],
//           //   begin: Alignment.centerLeft,
//           //   end: Alignment.centerRight,
//           // ),
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.secondrycolor.withOpacity(0.4),
//               blurRadius: 10,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColors.bgGrey,

//               // gradient: const LinearGradient(
//               //   colors: [
//               //     Color(0xff7A0000), // Dark blood red (LEFT)
//               //     Color(0xffC62828), // Medium red
//               //     Color(0xffFF6F6F), // Light red (RIGHT)
//               //   ],
//               //   begin: Alignment.centerLeft,
//               //   end: Alignment.centerRight,
//               // ),
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.cardBackgroundWhite,

//                   // color: Colors.redAccent.withOpacity(0.4),
//                   blurRadius: 10,
//                   offset: const Offset(0, 6),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text(
//                   textAlign: TextAlign.center,
//                   'Every Drop Counts. ',
//                   style: TextStyle(
//                     color: AppColors.primarycolor,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 const Text(
//                   textAlign: TextAlign.center,
//                   'Save a Life Today. ',
//                   style: TextStyle(
//                     color: AppColors.secondrycolor,

//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 const Text(
//                   textAlign: TextAlign.center,
//                   'Join thousand of heroa who donate blood regularly.Your contribution can make the different between life and death ',
//                   style: TextStyle(
//                     color: AppColors.fontGrey,

//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBloodGrid() {
//     final groups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemCount: groups.length,
//       itemBuilder: (context, index) {
//         return Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0), // Rounded corners
//             side: const BorderSide(
//               color: Color(0xFF4EA04C), // The trustworthy blue color
//               // width: 2.0, // Thickness of the border
//             ),
//           ),
//           color: Color.from(alpha: 1, red: 0.902, green: 0.961, blue: 0.902),
//           elevation: 2,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Icon(
//                   Icons.local_fire_department_rounded,
//                   size: 30,
//                   color: const Color(0xFFA41214),
//                 ),
//               ),

//               Center(
//                 child: Text(
//                   groups[index],
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                     color: Color.fromARGB(255, 0, 0, 0),
//                   ),
//                 ),
//               ),
//               Container(
//                 // padding: const EdgeInsets.all(6.0), // Space inside the container
//                 // margin: const EdgeInsets.all(20.0), // Space around the container itself
//                 // *** THIS IS WHERE THE MAGIC HAPPENS ***
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF8BC34A), // Inside color (Background)
//                   border: Border.all(
//                     color: const Color(0xFF4EA04C), // Border color (Deep Red)
//                     // width: 2.0, // Border thickness
//                   ),
//                   borderRadius: BorderRadius.circular(2.0), // Rounded corners
//                   boxShadow: [
//                     // Optional: adds a subtle shadow for depth
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),

//                 // *** END OF DECORATION ***
//                 child: Padding(
//                   padding: const EdgeInsets.all(2.0),
//                   child: const Text(
//                     'Available unit 89',
//                     style: TextStyle(
//                       color: Color(0xFFA41214), // Text color (Matches the border)
//                       fontSize: 8,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// Pet Blood App – Unique Home Page UI
// Focus: Cards + Animations + Pet-friendly look
// You can paste this into home_screen.dart

import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class BloodBankHome extends StatefulWidget {
  const BloodBankHome({super.key});

  @override
  State<BloodBankHome> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<BloodBankHome> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
      ..forward();
    getFCMToken();
  }

  Future<String?> getFCMToken() async {
    // Request permission for Apple platforms/Web
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      provisional: true, // Allows user to choose permissions later
    );

    // Get the token
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");

    // You should send this token to your backend server and store it
    return token;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Are you sure you want to exit?'),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text('Cancel')),
              TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Exit')),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Color(0XFFFFFFFF),
          // foregroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assest/bblogo.png", scale: 3),
              InkWell(
                onTap: () {
                  navigatorKey.currentState?.pushNamed('/sos');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(Icons.notifications_active_sharp, color: AppColors.errorRed),
                      Icon(Icons.sos_sharp, color: AppColors.errorRed),
                    ],
                  ),
                ),
              ),
              // const Text(
              //   'PashuRaktKosh',
              //   style: const TextStyle(
              //     fontSize: 16,
              //     color: Colors.black87,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
            ],
          ),
          actions: [Column(children: [

                    ],
                  )],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerCard(),
              const SizedBox(height: 20),
              _sectionTitle('Quick Actions'),
              const SizedBox(height: 12),
              _quickActions(),
              const SizedBox(height: 24),
              _sectionTitle('Blood Availability'),
              const SizedBox(height: 12),
              _bloodCards(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerCard() {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondrycolor.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
          gradient: const LinearGradient(
            colors: [AppColors.primarycolor, AppColors.cardBackgroundWhite],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Save Pet Lives 🐾',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find blood donors for dogs & cats nearby',
                    style: TextStyle(color: AppColors.white),
                  ),
                ],
              ),
            ),
            SizedBox(width: 90, height: 90, child: Lottie.asset('assest/blooddonneranime.json')),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _quickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionCard(Icons.search, 'Find Donor'),
        _actionCard(Icons.bloodtype, 'Request Blood'),
        GestureDetector(
          onTap: () {
            navigatorKey.currentState?.pushNamed('/petCategoryScreen');
          },
          child: _actionCard(Icons.pets, 'Register Pet'),
        ),
      ],
    );
  }

  Widget _actionCard(IconData icon, String title) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondrycolor.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
          // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.dividerGrey,

              child: Icon(icon, color: AppColors.primarycolor),
            ),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _bloodCards() {
    return Column(
      children: [
        _bloodItem('Dog', 'DEA 1.1+', '5 Donors Available'),
        _bloodItem('Cat', 'A', '2 Donors Available'),
      ],
    );
  }

  Widget _bloodItem(String pet, String group, String status) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondrycolor.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
        // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.dividerGrey,
            child: Icon(Icons.pets, color: AppColors.darkRed),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$pet Blood Group: $group',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(status, style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}
