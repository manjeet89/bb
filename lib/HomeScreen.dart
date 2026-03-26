// import 'package:bb/main.dart';
// import 'package:bb/utils/app_colors.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:lottie/lottie.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:url_launcher/url_launcher.dart';

// class BloodBankHome extends StatefulWidget {
//   const BloodBankHome({super.key});

//   @override
//   State<BloodBankHome> createState() => _BloodBankHomeState();
// }

// class _BloodBankHomeState extends State<BloodBankHome> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
//       ..forward();
//     getFCMToken();
//   }

//   Future<String?> getFCMToken() async {
//     // Request permission for Apple platforms/Web
//     NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
//       provisional: true, // Allows user to choose permissions later
//     );

//     // Get the token
//     String? token = await FirebaseMessaging.instance.getToken();
//     print("FCM Token: $token");

//     // You should send this token to your backend server and store it
//     return token;
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

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
//                 onTap: () async {
//                   await Geolocator.requestPermission();

//                   try {
//                     Position pos = await Geolocator.getCurrentPosition(
//                       desiredAccuracy: LocationAccuracy.high,
//                     );

//                     double currentLat = pos.latitude;
//                     double currentLng = pos.longitude;

//                     // Example: destination (change this!)
//                     double destLat = 28.6139;
//                     double destLng = 77.2090;

//                     final Uri googleMapsUrl = Uri.parse(
//                       'https://www.google.com/maps/dir/?api=1'
//                       '&origin=$currentLat,$currentLng'
//                       '&destination=$destLat,$destLng'
//                       '&travelmode=driving',
//                     );

//                     await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
//                   } catch (e) {
//                     debugPrint('Location / Map error: $e');
//                   }
//                 },

//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,

//                     children: [
//                       Icon(Icons.notifications_active_sharp, color: AppColors.secondrycolor),
//                     ],
//                   ),
//                 ),
//               ),
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

//                     ],
//                   )],
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Welcome Message
//               Text(
//                 'Welcome to Blood Bank Home!',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               const SizedBox(height: 20),

//               _headerCard(),
//               const SizedBox(height: 20),

//               // New Section
//               _sectionTitle('New Features'),
//               const SizedBox(height: 12),
//               Text(
//                 'Explore our latest features and updates to make your experience even better.',
//                 style: TextStyle(fontSize: 16, color: Colors.black87),
//               ),
//               const SizedBox(height: 20),

//               // Improved Quick Actions
//               _sectionTitle('Quick Actions'),
//               const SizedBox(height: 12),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _quickActionButton(Icons.bloodtype, 'Request Blood', () {
//                     // Navigate to Request Blood Page
//                   }),
//                   _quickActionButton(Icons.volunteer_activism, 'Donate Blood', () {
//                     // Navigate to Donate Blood Page
//                   }),
//                   _quickActionButton(Icons.local_hospital, 'Find Hospitals', () {
//                     // Navigate to Find Hospitals Page
//                   }),
//                 ],
//               ),

//               const SizedBox(height: 24),
//               _sectionTitle('Happy Pets'),
//               const SizedBox(height: 12),
//               CarouselSlider(
//                 items: [
//                   _sliderImage(
//                     "https://images.pexels.com/photos/8730617/pexels-photo-8730617.jpeg",
//                   ),
//                   _sliderImage("https://images.pexels.com/photos/89028/pexels-photo-89028.png"),
//                   _sliderImage("https://images.pexels.com/photos/33287/dog-viszla-close.jpg"),
//                   _sliderImage(
//                     "https://images.pexels.com/photos/2194261/pexels-photo-2194261.jpeg",
//                   ),
//                   _sliderImage(
//                     "https://images.pexels.com/photos/31440974/pexels-photo-31440974.jpeg",
//                   ),
//                 ],
//                 options: CarouselOptions(
//                   height: 180,
//                   enlargeCenterPage: true,
//                   autoPlay: true,
//                   autoPlayCurve: Curves.fastOutSlowIn,
//                   enableInfiniteScroll: true,
//                   autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                   viewportFraction: 0.8,
//                 ),
//               ),

//               const SizedBox(height: 24),
//               _sectionTitle('Blood Availability'),
//               const SizedBox(height: 12),
//               // _bloodCards(),
//               _bloodavailable(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _headerCard() {
//     return FadeTransition(
//       opacity: _controller,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.secondrycolor.withOpacity(0.4),
//               blurRadius: 10,
//               offset: const Offset(0, 6),
//             ),
//           ],
//           gradient: const LinearGradient(
//             colors: [AppColors.primarycolor, AppColors.cardBackgroundWhite],
//           ),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     'Save Pet Lives 🐾',
//                     style: TextStyle(
//                       color: AppColors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Find blood donors for dogs & cats nearby',
//                     style: TextStyle(color: AppColors.white),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: 90, height: 90, child: Lottie.asset('assest/blooddonneranime.json')),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _sectionTitle(String title) {
//     return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
//   }

//   Widget _quickActions() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _actionCard(Icons.search, 'Find Donor'),
//         _actionCard(Icons.bloodtype, 'Request Blood'),
//         // GestureDetector(
//         //   onTap: () {
//         //     navigatorKey.currentState?.pushNamed('/petCategoryScreen');
//         //   },
//         //   child:
//         _actionCard(Icons.pets, 'Register Pet'),
//         // ),
//       ],
//     );
//   }

//   Widget _bloodavailable() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _petblooadavalableactionCard("assest/petcat.png", '1.2K Cats'),
//         _petblooadavalableactionCard("assest/petdog.png", '3.2K Dogs'),
//         // GestureDetector(
//         //   onTap: () {
//         //     navigatorKey.currentState?.pushNamed('/petCategoryScreen');
//         //   },
//         //   child:
//         // _actionCard(Icons.pets, 'Register Pet'),
//         // ),
//       ],
//     );
//   }

//   Widget _actionCard(IconData icon, String title) {
//     return Expanded(
//       child: InkWell(
//         onTap: () {
//           navigatorKey.currentState?.pushNamed('/petCategoryScreen');
//         },
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 6),
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.secondrycolor.withOpacity(0.4),
//                 blurRadius: 10,
//                 offset: const Offset(0, 6),
//               ),
//             ],
//             // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
//           ),
//           child: Column(
//             children: [
//               CircleAvatar(
//                 radius: 22,
//                 backgroundColor: AppColors.dividerGrey,

//                 child: Icon(icon, color: AppColors.primarycolor),
//               ),
//               const SizedBox(height: 10),
//               Text(title, textAlign: TextAlign.center),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _petblooadavalableactionCard(String image, String title) {
//     return Expanded(
//       child: InkWell(
//         onTap: () {
//           navigatorKey.currentState?.pushNamed('/petCategoryScreen');
//         },
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 6),
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.secondrycolor.withOpacity(0.4),
//                 blurRadius: 10,
//                 offset: const Offset(0, 6),
//               ),
//             ],
//             // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
//           ),
//           child: Column(
//             children: [
//               CircleAvatar(
//                 radius: 22,

//                 // backgroundColor: AppColors.dividerGrey,
//                 child: Image.asset(image),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: AppColors.primarycolor, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _bloodCards() {
//     return Column(
//       children: [
//         _bloodItem('Dog', 'DEA 1.1+', '5 Donors Available'),
//         _bloodItem('Cat', 'A', '2 Donors Available'),
//       ],
//     );
//   }

//   Widget _sliderImage(String url) {
//     return Container(
//       margin: const EdgeInsets.all(6),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
//       ),
//     );
//   }

//   Widget _bloodItem(String pet, String group, String status) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 500),
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.secondrycolor.withOpacity(0.4),
//             blurRadius: 10,
//             offset: const Offset(0, 6),
//           ),
//         ],
//         // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 24,
//             backgroundColor: AppColors.dividerGrey,
//             child: Icon(Icons.pets, color: AppColors.darkRed),
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '$pet Blood Group: $group',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(status, style: const TextStyle(color: Colors.green)),
//               ],
//             ),
//           ),
//           const Icon(Icons.arrow_forward_ios, size: 16),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/LeaderBoard.dart';
import 'package:bb/MovingDonateButton.dart';
import 'package:bb/Ratatingquotes.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

/// ================= DONOR MODEL =================
class Donor {
  final String petType;
  final String bloodGroup;
  final String distance;
  final bool available;
  final String lastDonation;

  Donor({
    required this.petType,
    required this.bloodGroup,
    required this.distance,
    required this.available,
    required this.lastDonation,
  });
}

class BloodDonor {
  final String name;
  final String bloodGroup;
  final String distance;
  final String image;

  BloodDonor({
    required this.name,
    required this.bloodGroup,
    required this.distance,
    required this.image,
  });
}

/// ================= HOME SCREEN =================
class BloodBankHome extends StatefulWidget {
  const BloodBankHome({super.key});

  @override
  State<BloodBankHome> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<BloodBankHome> with SingleTickerProviderStateMixin {
  /// 🔹 YOUR DATA
  final double totalCats = 1.2;
  final double totalDogs = 1.5;

  /// 🔹 ADDITIONAL DATA (API-ready)
  final List<Donor> donors = [
    Donor(
      petType: "Dog",
      bloodGroup: "DEA 1.1+",
      distance: "0.8 km",
      available: true,
      lastDonation: "3 months ago",
    ),
    Donor(
      petType: "Cat",
      bloodGroup: "A+",
      distance: "1.5 km",
      available: false,
      lastDonation: "1 month ago",
    ),
    Donor(
      petType: "Dog",
      bloodGroup: "DEA 1.2",
      distance: "2.3 km",
      available: true,
      lastDonation: "5 months ago",
    ),
  ];

  final List<BloodDonor> donorss = [
    BloodDonor(
      name: "Rahul Sharma",
      bloodGroup: "A+",
      distance: "0.8 km",
      image: "assets/user1.png",
    ),
    BloodDonor(name: "Neha Verma", bloodGroup: "O+", distance: "1.2 km", image: "assets/user2.png"),
    BloodDonor(name: "Amit Singh", bloodGroup: "B+", distance: "1.9 km", image: "assets/user3.png"),
  ];

  @override
  void initState() {
    super.initState();
    _fetchProfile();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation = Tween<double>(
      begin: -20,
      end: 20,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true); // 🔥 left-right loop
  }

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchProfile() async {
    var url = allapiscreen.userprofile.toString();
    var header = await allapiscreen.headerFunction();

    final response = await http.post(Uri.parse(url), headers: header);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      setState(() async {
        SharedPreferences FontEmpTypeName = await SharedPreferences.getInstance();
        await FontEmpTypeName.setString("FirstName", decoded['data']['user_first_name'] ?? "");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      floatingActionButton: MovingDonateButton(
        onTap: () {
          navigatorKey.currentState?.pushNamed('/Donatenow');
        },
      ),

      /// ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Image.asset("assest/bblogo.png", scale: 3),
        actions: [Padding(padding: const EdgeInsets.only(right: 12), child: _sosBellWidget())],
      ),

      /// ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------- HERO ----------
            _heroCard().animate().fadeIn().slideY(),

            const SizedBox(height: 20),

            CarouselSlider(
              items: [
                _sliderImage("https://images.pexels.com/photos/8730617/pexels-photo-8730617.jpeg"),
                _sliderImage("https://images.pexels.com/photos/89028/pexels-photo-89028.png"),
                _sliderImage("https://images.pexels.com/photos/33287/dog-viszla-close.jpg"),
                _sliderImage("https://images.pexels.com/photos/2194261/pexels-photo-2194261.jpeg"),
                _sliderImage(
                  "https://images.pexels.com/photos/31440974/pexels-photo-31440974.jpeg",
                ),
              ],
              options: CarouselOptions(
                height: 140,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
            const SizedBox(height: 26),

            /// ---------- LEADER BOARD (CATS / DOGS) ----------
            _sectionTitle("Leaderboard"),
           const LeaderboardSection() .animate().fadeIn(delay: 200.ms).slideX(),

            const SizedBox(height: 26),

            /// ---------- YOUR DATA (CATS / DOGS) ----------
            _sectionTitle("Available Blood Donors"),
            Row(
              children: [
                _countCard(title: "Cats", value: "$totalCats k", image: "assest/petcat.png"),
                _countCard(title: "Dogs", value: "$totalDogs k", image: "assest/petdog.png"),
              ],
            ).animate().fadeIn(delay: 200.ms).slideX(),

            const SizedBox(height: 26),
            _sectionTitle("Best pet quotes"),
            RotatingQuotes(
              quotes: [
                "“Animals are a window to your soul and a doorway to your spiritual destiny.” — Kim Shotola",
                "“The bond with a dog is as lasting as the ties of this Earth can ever be.” — Konrad Lorenz",
                "“I had been told that the training procedure for cats was difficult. It isn’t. Mine had me trained in two days.” — Bill Dana",

                "“Happiness is a warm puppy.” — Charles M. Schulz",
                "“A kitten is, in the animal world, what a rosebud is in the garden.” — Robert Southey",
                "“To love and be loved is to feel the sun from both sides.” — David Viscott",
                "“Friendship isn’t a big thing — it’s a million little things.” — Paulo Coelho",
                "“Animals are such agreeable friends — they ask no questions, they pass no criticism.” — George Eliot",
              ],
            ),

            const SizedBox(height: 24),
            _sectionTitle('Pet Care Tips'),
            const SizedBox(height: 12),
            Column(
              children: [
                _adviceCard(
                  'Regular Vet Checkups',
                  'Ensure your pet gets regular checkups to stay healthy and catch any issues early.',
                ),
                // const SizedBox(height: 12),
                // _adviceCard(
                //   'Balanced Diet',
                //   'Provide a balanced diet with the right nutrients for your pet’s age and breed.',
                // ),
                // const SizedBox(height: 12),
                // _adviceCard(
                //   'Exercise',
                //   'Keep your pet active with regular exercise to maintain their physical and mental health.',
                // ),
                // const SizedBox(height: 12),
                _adviceCard(
                  'Grooming',
                  'Regular grooming helps keep your pet clean and prevents skin issues.',
                ),
              ],
            ),

            const SizedBox(height: 24),
            // _sectionTitle('More Happy Pets'),
            // const SizedBox(height: 12),
            // CarouselSlider(
            //   items: [
            //     _sliderImage("https://images.pexels.com/photos/1231231/pexels-photo-1231231.jpeg"),
            //     _sliderImage("https://images.pexels.com/photos/4564564/pexels-photo-4564564.jpeg"),
            //     _sliderImage("https://images.pexels.com/photos/7897897/pexels-photo-7897897.jpeg"),
            //     _sliderImage("https://images.pexels.com/photos/1010101/pexels-photo-1010101.jpeg"),
            //     _sliderImage("https://images.pexels.com/photos/2020202/pexels-photo-2020202.jpeg"),
            //   ],
            //   options: CarouselOptions(
            //     height: 180,
            //     enlargeCenterPage: true,
            //     autoPlay: true,
            //     autoPlayCurve: Curves.fastOutSlowIn,
            //     enableInfiniteScroll: true,
            //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
            //     viewportFraction: 0.8,
            //   ),
            // ),

            /// ---------- ADDITIONAL DATA ----------
            // _sectionTitle("Nearby Blood Donors"),
            // const SizedBox(height: 12),

            //  nearbyBloodDonorsSection(context),
            // ...donors.map((d) => _donorCard(d)).toList(),
          ],
        ),
      ),
    );
  }

  Widget donorCard(BloodDonor donor) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.red.withOpacity(0.85), Colors.redAccent.withOpacity(0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🧑 Avatar + Blood Group
          Row(
            children: [
              CircleAvatar(radius: 22, backgroundImage: AssetImage(donor.image)),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  donor.bloodGroup,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// 👤 Name
          Text(
            donor.name,
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          /// 📍 Distance
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.white),
              const SizedBox(width: 4),
              Text(donor.distance, style: const TextStyle(color: Colors.white)),
            ],
          ),

          const Spacer(),

          /// 📞 Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call, size: 16),
                  label: const Text("Call"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.warning, size: 16),
                  label: const Text("SOS"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black.withOpacity(0.2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget nearbyBloodDonorsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔴 Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Nearby Blood Donors",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {}, child: const Text("View All")),
            ],
          ),
        ),

        const SizedBox(height: 10),

        /// 🩸 Animated List
        SizedBox(
          height: 190,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            itemCount: donors.length,
            itemBuilder: (context, index) {
              return AnimatedSlide(
                offset: Offset(index == 0 ? 0 : 0.2, 0),
                duration: Duration(milliseconds: 400 + index * 200),
                curve: Curves.easeOut,
                child: AnimatedOpacity(
                  opacity: 1,
                  duration: Duration(milliseconds: 500 + index * 200),
                  child: donorCard(donorss[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// ================= SOS + BELL + IMAGE =================
  Widget _sosBellWidget() {
    return InkWell(
      onTap: () {
        navigatorKey.currentState?.pushNamed('/sos');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔔 Bell with dot
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    navigatorKey.currentState?.pushNamed('/Notification');
                  },
                  child: const Icon(
                    Icons.notifications_active,
                    color: AppColors.secondrycolor,
                    size: 22,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 8),

            /// 🖼 Pet image
            // CircleAvatar(
            //   radius: 14,
            //   backgroundColor: AppColors.primarycolor.withOpacity(0.1),
            //   child: Image.asset("assest/petdog.png", width: 18),
            // ),
            const SizedBox(width: 8),

            /// 🚨 SOS badge (animated pulse)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.errorRed,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: AppColors.errorRed.withOpacity(0.6), blurRadius: 12)],
              ),
              child: const Text(
                "SOS",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ).animate().scale(duration: 800.ms).then().scale(),
          ],
        ),
      ),
    );
  }

  /// ================= HERO CARD =================
  Widget _heroCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(colors: [AppColors.primarycolor, AppColors.darkRed]),
        boxShadow: [BoxShadow(color: AppColors.primarycolor.withOpacity(0.4), blurRadius: 20)],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Save Pet Lives 🐾",
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Verified blood donors near your area",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          SizedBox(width: 90, height: 90, child: Lottie.asset("assest/blooddonneranime.json")),
        ],
      ),
    );
  }

  /// ================= COUNT CARD =================
  Widget _countCard({required String title, required String value, required String image}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.08), blurRadius: 12)],
        ),
        child: Column(
          children: [
            CircleAvatar(radius: 22, child: Image.asset(image)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(title),
          ],
        ),
      ),
    ).animate().scale();
  }

  /// ================= DONOR CARD =================
  Widget _donorCard(Donor donor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.08), blurRadius: 10)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primarycolor.withOpacity(0.1),
            child: const Icon(Icons.pets),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${donor.petType} • ${donor.bloodGroup}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Distance: ${donor.distance}"),
                Text("Last donation: ${donor.lastDonation}", style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),

          Chip(
            label: Text(
              donor.available ? "Available" : "Busy",
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: donor.available ? Colors.green : Colors.grey,
          ),
        ],
      ),
    ).animate().fadeIn().slideX();
  }

  Widget _sectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _sliderImage(String url) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }

  Widget _quickActionButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(16),
            // primary: AppColors.primarycolor,
          ),
          child: Icon(icon, size: 32, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _adviceCard(String title, String description) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(colors: [AppColors.primarycolor, AppColors.secondrycolor]),
          boxShadow: [BoxShadow(color: AppColors.secondrycolor.withOpacity(0.4), blurRadius: 20)],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.warningOrange,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
