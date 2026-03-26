import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Aboutsus extends StatefulWidget {
  const Aboutsus({super.key});

  @override
  State<Aboutsus> createState() => _AboutsusState();
}

class _AboutsusState extends State<Aboutsus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          "About Us 🐾",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label("We’re in this together. "),
                _labelpara(
                  "No pet parent should ever feel alone in an emergency. The Canine & Feline Blood Bank of India (CFBBI) was built by the Fredun Group to ensure that when your best friend needs a hero, one is only a tap away. ",
                ),
                SizedBox(height: 10),
                _label("What you can do here: "),
                _labelpara(
                  "Request Help: If your pet is in trouble, raise an SOS. We’ll help you find a donor nearby, fast.",
                ),
                _labelpara(
                  "Save a Life: Register your pet as a donor. It’s a simple act of kindness that could be the miracle another family is praying for. ",
                ),
                _labelpara(
                  "We know how much they mean to you. We’re here to help you protect them. ",
                ),
                SizedBox(height: 10),

                _labelHeading("No One Fights Alone. "),
                SizedBox(height: 10),

                _labelpara(
                  "The Canine & Feline Blood Bank of India (CFBBI) was built by the Fredun Group to ensure that when a life is on the line, help is only a tap away. Whether it’s your childhood pet or a stray you’ve just rescued from the street, we are here to help you protect them. ",
                ),
                SizedBox(height: 10),

                _label("How we support you:"),
                _labelpara(
                  "Raise an SOS: In an emergency, post a blood requirement immediately. We connect pet parents and rescue organizations with a network of verified donors nearby.",
                ),
                _labelpara(
                  "Be a Lifesaver: Register your healthy dog or cat as a donor. Your pet’s donation could be the miracle a family or a shelter is praying for. ",
                ),
                _labelpara(
                  "Every drop counts. Every life matters. Join our community of heroes today.",
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _labelHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.darkRed, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primarycolor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _labelpara(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primarycolor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
