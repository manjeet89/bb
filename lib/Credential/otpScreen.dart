import 'dart:convert';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Otpscreen extends StatefulWidget {
  const Otpscreen({super.key});

  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  final TextEditingController __otpController = TextEditingController();
  // Show a loading indicator (optional but recommended)

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

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
                'Sign in to continue with PashuRaktkosh.',
                textAlign: TextAlign.center, // Centers each line
                style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
              ),
              SizedBox(height: 40),
              // Email Field
              TextField(
                controller: __otpController,
                keyboardType: TextInputType.number, // Shows the numeric keyboard

                maxLength: 4,
                decoration: InputDecoration(
                  labelText: 'Enter Your OTP',
                  labelStyle: TextStyle(
                    color: Color(0xFFC62828),
                    fontWeight: FontWeight.bold,
                  ), // Accent blue
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.verified, color: Color(0xFFC62828)),
                ),
              ),
              SizedBox(height: 20),

              // Login Button (Call to Action)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (__otpController.text.isEmpty) {
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
                            onPressed: () => __otpController.clear(),
                          ),
                        ),
                      );
                    } else {
                      _login();
                    }
                    // Login logic here
                    // Navigate to SecondPage
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => Userprofile()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarycolor, // Primary red
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('LOGIN', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    var url = allapiscreen.otp.toString();
    final userid = ModalRoute.of(context)!.settings.arguments;

    final response = await http.post(
      Uri.parse(url),
      body: {'user_otp': __otpController.text, "user_id": userid},
    );
    print(response.body.toString());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['code'].toString() == "201") {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(data['message'].toString()),
            backgroundColor: AppColors.warningOrange, // Red for errors
            behavior: SnackBarBehavior.floating, // Modern floating look
            duration: Duration(seconds: 3),
            action: SnackBarAction(
              label: 'RETRY',
              textColor: Colors.white,
              onPressed: () => __otpController.clear(),
            ),
          ),
        );
      } else {
        String token = data['user_token']; // Adjust based on your API response structure

        // Save session to Shared Preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        await prefs.setString('auth_userId', userid.toString());
        await prefs.setBool('isLoggedIn', true);

        // Navigate to Home Screen
        // Navigate to SecondPage
        // Navigator.push(context, MaterialPageRoute(builder: (context) => Otpscreen()));
        navigatorKey.currentState?.pushReplacementNamed('/home');
      }
    } else {
      // Handle error (e.g., show a snackbar)
      print('Login failed: ${response.body}');
    }
  }
}
