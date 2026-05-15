// import 'dart:async';

// import 'package:bb/utils/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class Splashscreen extends StatefulWidget {
//   const Splashscreen({super.key});

//   @override
//   State<Splashscreen> createState() => _SplashscreenState();
// }

// class _SplashscreenState extends State<Splashscreen> {
//   double opacity = 0;

//   @override
//   void initState() {
//     super.initState();

//     Timer(Duration(milliseconds: 500), () {
//       setState(() {
//         opacity = 1;
//       });
//     });

//     Timer(Duration(seconds: 3), () {
//       Navigator.pushReplacementNamed(context, '/home');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//             child: SizedBox(
//               // width: 190,
//               // height: 190,
//               // child: Image.asset('assest/CFBBI.png'),
//               child: AnimatedOpacity(
//                 duration: Duration(seconds: 2),
//                 opacity: opacity,
//                 child: Image.asset('assest/dog.gif'),
//               )
//               //Image.asset('assest/dog.gif'),
//               // Lottie.asset('assest/dog.gif'),
//             ),
//           ),
//           Center(
//             child: Text(
//               "Welcome to CFBBI",
//               style: TextStyle(color: AppColors.darkRed, fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           // Image.asset("assest/bblogo.png", scale: 2),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int totalDog = 0;
  int totalCat = 0;
  bool isLoaded = false;

  // @override
  // void initState() {
  //   super.initState();

  //   _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
  //     ..repeat(reverse: true); // 🔥 important

  //   _animation = Tween<double>(
  //     begin: -15,
  //     end: 15,
  //   ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  //   Future.delayed(const Duration(seconds: 5), () {
  //     Navigator.pushReplacementNamed(context, '/home');
  //   });
  // }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -15,
      end: 15,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    loadData();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    String dog = prefs.getString("Total_Dog") ?? "";
    String cat = prefs.getString("Total_Cat") ?? "";

    totalDog = int.tryParse(dog) ?? 0;
    totalCat = int.tryParse(cat) ?? 0;

    setState(() {
      isLoaded = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                  if (!isLoaded) {
                    return const CircularProgressIndicator();
                  }

                  /// BOTH EMPTY → show both
                  if (totalDog == 0 && totalCat == 0) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.translate(
                          offset: Offset(0, _animation.value),
                          child: Image.asset('assest/cat.png', width: 140),
                        ),
                        const SizedBox(width: 20),
                        Transform.translate(
                          offset: Offset(0, -_animation.value),
                          child: Image.asset('assest/dog.png', width: 140),
                        ),
                      ],
                    );
                  }

                  /// DOG MORE → show only dog
                  if (totalDog > totalCat) {
                    return Transform.translate(
                      offset: Offset(0, _animation.value),
                      child: Image.asset('assest/dog.png', width: 160),
                    );
                  }

                  /// CAT MORE → show only cat
                  return Transform.translate(
                    offset: Offset(0, _animation.value),
                    child: Image.asset('assest/cat.png', width: 160),
                  );
              },
            ),
          ),
          Center(
            child: Text(
              "Welcome to CFBBI",
              style: TextStyle(color: AppColors.darkRed, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
