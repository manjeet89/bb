import 'package:flutter/material.dart';

class BloodBankHome extends StatelessWidget {
  const BloodBankHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Color(0XFFFFFFFF),
        // foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assest/bblogo.png", scale: 3),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(Icons.notifications_active_sharp, color: Colors.red),
                  Icon(Icons.sos_sharp, color: Colors.red),
                ],
              ),
            ),
            // const Text(
            //   'PashuRaktKosh',
            //   style: const TextStyle(
            //     fontSize: 16,
            //     color: Colors.black87,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
          ],
        ),
        actions: [Column(children: [
              
            ],
          )],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 24),
            // 1. Hero Card
            Center(child: _buildHeroCard()),
            const SizedBox(height: 24),

            // 2. Blood Groups Section
            Center(
              child: const Text(
                textAlign: TextAlign.center,
                'Current Blood \nAvailablity',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            _buildBloodGrid(),
            const SizedBox(height: 24),

            // 3. How it Works (Registration Workflow)
            // const Text(
            //   'How Registration Works',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 12),
            // _buildWorkflowSteps(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Card(
      // color: const Color(0xFFA41214),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xff7A0000), // Dark blood red (LEFT)
              Color(0xffC62828), // Medium red
              Color(0xffFF6F6F), // Light red (RIGHT)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff7A0000), // Dark blood red (LEFT)
                  Color(0xffC62828), // Medium red
                  Color(0xffFF6F6F), // Light red (RIGHT)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  textAlign: TextAlign.center,
                  'Every Drop Counts. ',
                  style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  textAlign: TextAlign.center,
                  'Save a Life Today. ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  textAlign: TextAlign.center,
                  'Join thousand of heroa who donate blood regularly.Your contribution can make the different between life and death ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 170, 167, 167),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBloodGrid() {
    final groups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: groups.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
            side: const BorderSide(
              color: Color(0xFF4EA04C), // The trustworthy blue color
              // width: 2.0, // Thickness of the border
            ),
          ),
          color: Color.from(alpha: 1, red: 0.902, green: 0.961, blue: 0.902),
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  Icons.local_fire_department_rounded,
                  size: 30,
                  color: const Color(0xFFA41214),
                ),
              ),

              Center(
                child: Text(
                  groups[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(6.0), // Space inside the container
                // margin: const EdgeInsets.all(20.0), // Space around the container itself
                // *** THIS IS WHERE THE MAGIC HAPPENS ***
                decoration: BoxDecoration(
                  color: const Color(0xFF8BC34A), // Inside color (Background)
                  border: Border.all(
                    color: const Color(0xFF4EA04C), // Border color (Deep Red)
                    // width: 2.0, // Border thickness
                  ),
                  borderRadius: BorderRadius.circular(2.0), // Rounded corners
                  boxShadow: [
                    // Optional: adds a subtle shadow for depth
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),

                // *** END OF DECORATION ***
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: const Text(
                    'Available unit 89',
                    style: TextStyle(
                      color: Color(0xFFA41214), // Text color (Matches the border)
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
