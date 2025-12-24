import 'package:bb/AnimalCategory/Model/AnimalCategoryModel.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AnimalCategoryCard extends StatelessWidget {
  final AnimalCategory category;
  final VoidCallback onTap;

  const AnimalCategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          // gradient: const LinearGradient(
          //   colors: [AppColors.darkRed, AppColors.lightRed],
          //   begin: Alignment.centerLeft,
          //   end: Alignment.centerRight,
          // ),
          borderRadius: BorderRadius.circular(18),
          color: const Color.fromARGB(255, 247, 244, 244),
          border: Border.all(color: AppColors.darkRed),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.redAccent.withOpacity(0.35),
          //     blurRadius: 8,
          //     offset: const Offset(0, 4),
          //   ),
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // use the Image widget provided by the model (category.image)
            SizedBox(height: 80, child: category.image),
            // Icon(category.image, color: Colors.white, size: 34),
            // const SizedBox(height: 10),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
