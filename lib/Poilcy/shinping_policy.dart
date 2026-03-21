import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ShinpingPolicy extends StatefulWidget {
  const ShinpingPolicy({super.key});

  @override
  State<ShinpingPolicy> createState() => _ShinpingPolicyState();
}

class _ShinpingPolicyState extends State<ShinpingPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          "Shipping Policies 🐾",
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
                _labelHeading("Shipping Policies of Canine and Feline Blood Bank of India(CFBBI)"),

                SizedBox(height: 10),
                _label("Shipment processing time"),
                _labelpara(
                  "All orders are processed within 2–3 business days of receipt. Orders are not processed or shipped from Friday, 12 pm EST through Sunday, or holidays.\nIf we are experiencing a high volume of orders, shipments may be delayed by a few days. If your shipment experiences a significant delay, we will contact you via email or phone.",
                ),
                SizedBox(height: 10),
                _label("Shipping rates and delivery estimates"),
                _labelpara(
                  "Shipping charges for your order will be calculated and displayed at checkout.",
                ),
                SizedBox(height: 10),

                _label("Shipping delivery timeframe"),
                _labelpara(
                  "Shipping physical items will take around 7 to 30 days, depending on the delivery location. You will be notified about the estimated delivery timeframe when you contact the support team after successful payment of your items.",
                ),
                SizedBox(height: 10),

                _label("Shipment Confirmation and Order Tracking"),
                _labelpara(
                  "You will receive a Shipment Confirmation email with your tracking number once your order has shipped. The tracking number will be active within 24 hours.",
                ),
                SizedBox(height: 10),

                _label("Customs, Duties, and Taxes"),
                _labelpara(
                  "Absolute Feline Fanciers is not responsible for any customs and taxes applied to your order. All fees imposed during or after shipping are the customer’s responsibility (including tariffs, taxes, and other costs).",
                ),
                SizedBox(height: 10),

                _label("SECTION 6 – SECURITY"),
                _labelpara(
                  "To protect your personal information, we take reasonable precautions and follow industry best practices to make sure it is not inappropriately lost, misused, accessed, disclosed, altered or destroyed.",
                ),
                SizedBox(height: 10),
                _label("Damages"),
                _labelpara(
                  "Absolute Feline Fanciers is not liable for any products damaged or lost during shipping. If you received your order damaged, please file a claim with the shipment carrier. Save all packaging materials and damaged goods before filing a claim.",
                ),
                SizedBox(height: 10),
                _label("Incorrect Shipping Addresses and Refused Delivery"),
                _labelpara(
                  "We make every attempt to validate the shipping address provided at checkout to ensure it’s recognized as a valid address by the USPS. If we cannot validate the address, we will try to contact the customer to provide an updated address. If we cannot update the address, the order will be canceled and refunded.\nAbsolute Feline Fanciers will not be held responsible if the customer provides the wrong shipping address and we cannot recover the package.",
                ),
                SizedBox(height: 10),
                _label("Missing or Stolen Shipments"),
                _labelpara(
                  "If you didn't receive your order, but the shipping carrier has reported that it was delivered, please let us know as soon as possible.\nWe will file a claim with the shipping carrier. Local law enforcement will be involved. We will replace or refund your order when the investigation is complete. Allow up to 21 days for the investigation.",
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
