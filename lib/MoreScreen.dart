import 'package:bb/main.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Morescreen extends StatefulWidget {
  const Morescreen({super.key});

  @override
  State<Morescreen> createState() => _MorescreenState();
}

class _MorescreenState extends State<Morescreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevents the app from closing
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return; // If already popped, do nothing

        // Always navigate to Home when back is pressed
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkRed,
          title: const Text(
            'Profile',
            style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          onPressed: () {
            setState(() {
              navigatorKey.currentState?.pushNamed('/userRegistration');
            });
          },
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Breakpoint for Desktop/Tablet
            double padding = constraints.maxWidth > 600 ? 50.0 : 20.0;
            return SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600), // Limits width on Web/Desktop
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('picsum.photos'),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Tushar',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Text('tushare@example.com', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFC62828), // Primary red
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          navigatorKey.currentState?.pushNamed('/profile');
                        },
                        child: const Text('Profile', style: TextStyle(color: Colors.white)),
                      ),
                      const Divider(height: 40),
                      _buildProfileItem(Icons.policy, 'Privacy & Policy'),
                      _buildProfileItem(Icons.perm_contact_cal, 'Contact'),
                      _buildProfileforlogout(Icons.logout, 'Logout', color: Colors.red),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildProfileItem(IconData icon, String title, {Color? color}) {
  return ListTile(
    leading: Icon(icon, color: color, fontWeight: FontWeight.w700),
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
    leading: Icon(icon, color: color, fontWeight: FontWeight.w700),
    title: Text(
      title,
      style: TextStyle(color: color, fontWeight: FontWeight.w600),
    ),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Or use prefs.remove('auth_token')
      navigatorKey.currentState?.pushReplacementNamed('/login');
    },
  );
}
