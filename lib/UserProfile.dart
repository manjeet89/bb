import 'package:bb/HomeScreen.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
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
       backgroundColor: AppColors.darkRed,
        title: const Text(
          'User Profile',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600), // Limits width on Web/Desktop
            child: Column(
              children: [
                // Header section
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Tushar Aher',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                // const Text('User ID: 2', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 10),

                // Profile Fields
                _buildInfoCard([
                  _infoTile(Icons.phone, 'Mobile Number', '+91-9657267261'),
                  _infoTile(Icons.email, 'Email', 'tushar.sarvisolutions@gmail.com'),
                  _infoTile(Icons.cake, 'Date of Birth', '17 Nov 1990'),
                  _infoTile(Icons.person_outline, 'Gender', 'Male'),
                  _infoTile(Icons.bloodtype, 'Blood Group', 'B+'),
                  _infoTile(
                    Icons.location_on,
                    'Postal Address',
                    '704, Gurunath Tower, Guravali road, Titwala East, Thane, Nashik, Maharashtra, India',
                  ),
                  _infoTile(Icons.pin_drop, 'Pin Code / Zip Code', '422012'),
                ]),

                const SizedBox(height: 10),

                // Affiliate Section
                _buildInfoCard([
                  ListTile(
                    leading: const Icon(Icons.share, color: Color(0xFFA41214)),
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
    leading: Icon(icon, color: const Color(0xFFA41214)),
    title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    subtitle: Text(
      value,
      style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
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
