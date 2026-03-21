import 'dart:convert';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BloodBankLoginPage extends StatefulWidget {
  const BloodBankLoginPage({super.key});

  @override
  State<BloodBankLoginPage> createState() => _BloodBankLoginPageState();
}

class _BloodBankLoginPageState extends State<BloodBankLoginPage> {
  final TextEditingController __mobilenumberController = TextEditingController();
  // Show a loading indicator (optional but recommended)
  Future<void> _login() async {
    var url = allapiscreen.login.toString();
    final response = await http.post(
      Uri.parse(url),
      body: {'user_mobile_number': __mobilenumberController.text},
    );
    print(jsonDecode(response.body).toString());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String userId = data['user_id']; // Adjust based on your API response structure

      // Save session to Shared Preferences
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('auth_token', token);
      // await prefs.setBool('isLoggedIn', true);

      // Navigate to Home Screen
      // Navigate to SecondPage
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Otpscreen()));
      // Navigator.pushNamed(context, '/otp', arguments: userId);
      // Instead of Navigator.pushReplacementNamed(context, '/home');
      navigatorKey.currentState?.pushNamed('/otp', arguments: userId);
    } else {
      // Handle error (e.g., show a snackbar)
      print('Login failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Use MediaQuery to get screen size for responsiveness
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF), // White background
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80),
              // Logo/Icon Placeholder
              Image.asset("assest/bblogo.png"),
              // Icon(
              //   Icons.favorite,
              //   color: Color(0xFFC62828), // Primary red color
              //   size: 100.0,
              // ),
              SizedBox(height: 30),
              Text(
                'Welcome to PashuRaktKosh', // Example App Name
                textAlign: TextAlign.center, // Centers each line
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263238),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Enter your mobile number to begin your journey with PashuRaktkosh.',
                textAlign: TextAlign.center, // Centers each line
                style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
              ),
              SizedBox(height: 40),
              // _mobilenumber Field
              TextField(
                controller: __mobilenumberController,
                keyboardType: TextInputType.number, // Shows the numeric keyboard

                maxLength: 11, // Also limits the length and optionally shows a counter

                decoration: InputDecoration(
                  counterText: "",
                  hintText: 'Enter 10 numbers',
                  labelText: 'Enter Your Mobile Number',
                  labelStyle: TextStyle(
                    color: Color(0xFFC62828),
                    fontWeight: FontWeight.bold,
                  ), // Accent blue
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.call, color: Color(0xFFC62828)),
                ),
              ),
              SizedBox(height: 20),

              // Login Button (Call to Action)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Login logic here
                    if (__mobilenumberController.text.isEmpty) {
                      // FAILURE: Show "Invalid Password" or Error message
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text('Enter mobile number.'),
                          backgroundColor: AppColors.warningOrange, // Red for errors
                          behavior: SnackBarBehavior.floating, // Modern floating look
                          duration: Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'RETRY',
                            textColor: Colors.white,
                            onPressed: () => __mobilenumberController.clear(),
                          ),
                        ),
                      );
                    } else {
                      _login();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarycolor, // Primary red
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('SUBMIT', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),

              // SizedBox(height: 20),
              // Container(
              //   width: double.infinity,
              //   height: 50,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // Login logic here
              //       // Navigate to SecondPage
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => NavigationBarApp()),
              //       );
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Color(0xFFC62828), // Primary red
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              //     ),
              //     child: Text('Varification', style: TextStyle(fontSize: 18, color: Colors.white)),
              //   ),
              // ),
              // SizedBox(height: 20),
              // Container(
              //   width: double.infinity,
              //   height: 50,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // Login logic here
              //       // Navigate to SecondPage
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => Userprofile()));
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Color(0xFFC62828), // Primary red
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              //     ),
              //     child: Text('Profile', style: TextStyle(fontSize: 18, color: Colors.white)),
              //   ),
              // ),
              // SizedBox(height: 20),
              // Container(
              //   width: double.infinity,
              //   height: 50,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // Login logic here
              //       // Navigate to SecondPage
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => BloodBankHome()),
              //       );
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Color(0xFFC62828), // Primary red
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              //     ),
              //     child: Text('Home', style: TextStyle(fontSize: 18, color: Colors.white)),
              //   ),
              // ),
              SizedBox(height: 20),
              // Forgot Password Link
              TextButton(
                onPressed: () {},
                child: Text('Forgot Password?', style: TextStyle(color: Color(0xFF1976D2))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:bb/Credential/otpScreen.dart';
// import 'package:flutter/material.dart';

// class BloodBankLoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Use MediaQuery to get screen size for responsiveness
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Colors.white, // Secondary Color
//       body: SingleChildScrollView(
//         // Prevents overflow on small screens
//         child: Column(
//           children: <Widget>[
//             // Top section with a graphic/logo (responsive height)
//             Container(
//               height: screenHeight * 0.3, // Takes 30% of screen height
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 109, 2, 95), // Primary Color
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//               ),
//               child: Center(
//                 child: Image.asset(
//                   'assest/bblogo.png',
//                   height: 100,
//                 ), // Placeholder for your logo
//               ),
//             ),

//              SizedBox(height: 30),
//               Text(
//                 'Welcome to PashuRaktKosh', // Example App Name
//                 textAlign: TextAlign.center, // Centers each line
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF263238),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'Enter your mobile number to begin your journey with PashuRaktkosh.',
//                 textAlign: TextAlign.center, // Centers each line
//                 style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
//               ),
//               SizedBox(height: 40),
//               // Email Field
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Enter Your Mobile Number',
//                   labelStyle: TextStyle(color: Color(0xFF1976D2)), // Accent blue
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.call, color: Color(0xFF1976D2)),
//                 ),
//               ),
//               SizedBox(height: 20),

//               // Login Button (Call to Action)
//               Container(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Login logic here
//                     // Navigate to SecondPage
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => Otpscreen()));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFFC62828), // Primary red
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   child: Text('SUBMIT', style: TextStyle(fontSize: 18, color: Colors.white)),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Forgot Password Link
//               TextButton(
//                 onPressed: () {},
//                 child: Text('Forgot Password?', style: TextStyle(color: Color(0xFF1976D2))),
//               ),
//             ],
//           ),
//         ),
      
//     );
//   }
// }
