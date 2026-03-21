import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';

class RefundCalcilcation extends StatefulWidget {
  const RefundCalcilcation({super.key});

  @override
  State<RefundCalcilcation> createState() => _RefundCalcilcationState();
}

class _RefundCalcilcationState extends State<RefundCalcilcation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          "Refunds and Cancellations 🐾",
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
                _labelHeading(
                  "Refunds and Cancellation Policies of Canine and Feline Blood Bank of India(CFBBI)",
                ),
                SizedBox(height: 5),
                _label(
                  "Payment for Services, Cat Show Events, Seminars, Merchandise, Premiums, Franchise Fee, etc., is non-refundable.",
                ),
                SizedBox(height: 5),

                _label("Applications for all Services"),
                _labelpara(
                  "Cat / Litter Registrations, Pedigrees, Transfer of Registered Cat, etc. are processed by AFF on the basis of information supplied by the Applicant, who alone shall be fully responsible for the correctness of information supplied. AFF may at its sole discretion, verify this information, and reject any Application with incomplete or incorrect details. Giving incorrect details may also attract further penal action.",
                ),
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
