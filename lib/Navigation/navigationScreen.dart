import 'package:bb/HomeScreen.dart';
import 'package:bb/MoreScreen.dart';
import 'package:bb/PetInfo/petListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Flutter code sample for [NavigationBar].

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample(), debugShowCheckedModeBanner: false);
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return PopScope(
      canPop: false, // 1. Prevent the app from closing immediately
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        // 2. Logic: If not on Home (index 0), go back to Home
        if (currentPageIndex != 0) {
          setState(() {
            currentPageIndex = 0;
          });
        } else {
          // 3. If already on Home, allow the app to close
          // You can also show a "Press back again to exit" snackbar here
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.red,
          backgroundColor: Colors.white,
          selectedIndex: currentPageIndex,

          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.pets),
              icon: Icon(Icons.pets_outlined),
              label: 'My Pets',
            ),
            // NavigationDestination(
            //   icon: Badge(child: Icon(Icons.pets)),
            //   label: 'My Pets',
            // ),
            NavigationDestination(icon: Icon(Icons.more_horiz_outlined), label: 'More'),
            // NavigationDestination(
            //   icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
            //   label: 'Messages',
            // ),
          ],
        ),
        body: <Widget>[
          /// Home page
          BloodBankHome(),
          // Card(
          //   shadowColor: Colors.transparent,
          //   margin: const EdgeInsets.all(8.0),
          //   child: SizedBox.expand(
          //     child: Center(child: Text('Home page', style: theme.textTheme.titleLarge)),
          //   ),
          // ),

          /// Notifications page
          PetListScreen(),

          /// Messages page
          Morescreen(),
        ][currentPageIndex],
      ),
    );
  }
}
