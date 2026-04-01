import 'package:bb/Header.dart';
import 'package:flutter/material.dart';
import 'package:bb/utils/app_colors.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      appBar: const CommonAppBar(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🐶 DOG SECTION
            _sectionTitle("Top Donors - Dogs 🐶"),
            const SizedBox(height: 10),

            _gridSection([
              {"name": "Bruno", "lives": 12, "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0mabj2ZGtjJfaC54TQ-OoL6CTLbQo81xDLw&s"},
              {"name": "Rocky", "lives": 10, "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbUyiw-zbfQZRZ3JDtgdn-GmFn6E-40qF2ZA&s"},
              {"name": "Max", "lives": 8, "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSU5hEMKALb8V1zuRpt1GmxpBQcKH7aK4-Llw&s"},
              {"name": "Tommy", "lives": 6, "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoHxeSYYYQzQkI1zpoBCFjfIrIPwQebLddcw&s"},
            ]),

            const SizedBox(height: 20),

            /// 🐱 CAT SECTION
            _sectionTitle("Top Donors - Cats 🐱"),
            const SizedBox(height: 10),

            _gridSection([
              {"name": "Kitty", "lives": 9, "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTbkqGxs6Zs6xF3674m8Sa7fuK8aMQ_9Q1B8nkN9Rbv98zbszOrlTFQOg&s"},
              {"name": "Milo", "lives": 7, "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTupiPeJOG4_7BhdEgSJZBm3R09WRdwHjgmCggKx7FsatccaFiPZH-Fi3pxPw&s"},
              {"name": "Luna", "lives": 5, "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQArXHY6NtmmO71J-evwk4b-uN0k7Dh1Dc-CTjucKPSCUyzrEp7Ldqq-H8&s"},
              {"name": "Simba", "lives": 4, "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQye-ATSuKvIbJ9Sn6WOqim28hQTyEBUrNc2mowzUPYtIBF-f-ibQ76Pmk&s"},
            ]),
          ],
        ),
      ),
    );
  }

  /// 🧩 SECTION TITLE
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.primarycolor,
      ),
    );
  }

  /// 🔥 GRID SECTION (2 per row)
  Widget _gridSection(List<Map<String, dynamic>> data) {
    return GridView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 👈 2 items per row
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        return _leaderCard(
          name: data[index]["name"],
          lives: data[index]["lives"],
          image: data[index]["image"],
          rank: index + 1,
        );
      },
    );
  }

  /// 🏆 PREMIUM CARD
  Widget _leaderCard({
    required String name,
    required int lives,
    required String image,
    required int rank,
  }) {
    Color badgeColor;

    if (rank == 1) {
      badgeColor = Colors.amber;
    } else if (rank == 2) {
      badgeColor = Colors.grey;
    } else if (rank == 3) {
      badgeColor = Colors.brown;
    } else {
      badgeColor = Colors.blueGrey;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            AppColors.primarycolor.withOpacity(0.9),
            AppColors.secondrycolor.withOpacity(0.9),
          ],
        ),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// 🥇 RANK BADGE
          Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: badgeColor,
              child: Text(
                "$rank",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          /// 🐾 IMAGE
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: CircleAvatar(radius: 32, backgroundImage: NetworkImage(image)),
          ),

          const SizedBox(height: 10),

          /// ⭐ NAME
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 16),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          /// ❤️ LIVES
          Text("$lives lives saved", style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}
