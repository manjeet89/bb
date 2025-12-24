import 'package:bb/AnimalCategory/Model/AnimalCategoryModel.dart';
import 'package:bb/AnimalCategory/widget/animal_category_card.dart';
import 'package:flutter/material.dart';

class AnimalCategoryScreen extends StatelessWidget {
  AnimalCategoryScreen({super.key});

  final List<AnimalCategory> categories = [
    AnimalCategory(name: "Cat", image: Image.asset('assest/petcat.png')),
    AnimalCategory(name: "Dog", image: Image.asset('assest/petdog.png')),
    AnimalCategory(name: "Horse", image: Image.asset('assest/pethorse.png')),
    AnimalCategory(name: "Hamster", image: Image.asset('assest/pethamster.png')),
    AnimalCategory(name: "Bird", image: Image.asset('assest/petbird.png')),
    AnimalCategory(name: "Pony", image: Image.asset('assest/petpony.png')),
    AnimalCategory(name: "Guinea Pig", image: Image.asset('assest/petguinee.png')),
    AnimalCategory(name: "Cattle", image: Image.asset('assest/petcattle.png')),

    // AnimalCategory(name: "Dog", icon: FontAwesomeIcons.dog),
    // AnimalCategory(name: "Horse", icon: FontAwesomeIcons.house),
    // AnimalCategory(name: "Hamster", icon: FontAwesomeIcons.mouse),
    // AnimalCategory(name: "Bird", icon: Icons.brightness_medium),
    // AnimalCategory(name: "Pony", icon: FontAwesomeIcons.podcast),
    // AnimalCategory(name: "Guinea Pig", icon: FontAwesomeIcons.piggyBank),
    // AnimalCategory(name: "Cattle", icon: FontAwesomeIcons.calendarTimes),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animal Categories")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
          ),
          itemBuilder: (context, index) {
            return AnimalCategoryCard(
              category: categories[index],
              // category: categories[index], // ✅ FIXED
              onTap: () {
                print("Selected: ${categories[index].name}");
              },
            );
          },
        ),

        // GridView.builder(
        //   itemCount: categories.length,
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3,
        //     mainAxisSpacing: 14,
        //     crossAxisSpacing: 14,
        //     childAspectRatio: 0.9,
        //   ),
        //   itemBuilder: (context, index) {
        //     return AnimalCategoryCard(
        //       category: categories[index],

        //       onTap: () {
        //         print("Selected: ${categories[index].name}");
        //       },
        //     );
        //   },
        // ),
      ),
    );
  }
}
