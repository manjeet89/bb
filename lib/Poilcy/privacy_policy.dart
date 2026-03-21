import 'package:bb/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primarycolor,
        title: const Text(
          "Privacy Policies 🐾",
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
                _labelHeading("Privacy Policies of Canine and Feline Blood Bank of India(CFBBI)"),
                SizedBox(height: 10),

                _label("SECTION 1 – WHAT DO WE DO WITH YOUR INFORMATION?"),
                _labelpara(
                  "When you purchase something from our store, as part of the buying and selling process, we collect the personal information you give us such as your name, address and email address.\nWhen you browse our store, we also automatically receive your computer’s internet protocol (IP) address in order to provide us with information that helps us learn about your browser and operating system.\nEmail marketing: With your permission, we may send you emails about our store, new products and other updates.",
                ),
                SizedBox(height: 10),
                _label("SECTION 2 – CONSENT"),
                _labelpara(
                  "How do you get my consent?\nWhen you provide us with personal information to complete a transaction, verify your credit card, place an order, arrange for a delivery or return a purchase, we imply that you consent to our collecting it and using it for that specific reason only.\nIf we ask for your personal information for a secondary reason, like marketing, we will either ask you directly for your expressed consent, or provide you with an opportunity to say no.\nHow do I withdraw my consent?\nIf after you opt-in, you change your mind, you may withdraw your consent for us to contact you, for the continued collection, use or disclosure of your information, at anytime, by contacting us at office@cfbbi.com",
                ),
                SizedBox(height: 10),

                _label("SECTION 3 – DISCLOSURE"),
                _labelpara(
                  "We may disclose your personal information if we are required by law to do so or if you violate our Terms of Service.",
                ),
                SizedBox(height: 10),

                _label("SECTION 4 – PAYMENT"),
                _labelpara(
                  "We use PayPal for processing payments. We/PayPal do not store your card data on their servers. The data is encrypted through the Payment Card Industry Data Security Standard (PCI-DSS) when processing payment. Your purchase transaction data is only used as long as is necessary to complete your purchase transaction. After that is complete, your purchase transaction information is not saved.\nOur payment gateway adheres to the standards set by PCI-DSS as managed by the PCI Security Standards Council, which is a joint effort of brands like Visa, MasterCard, American Express and Discover.\nPCI-DSS requirements help ensure the secure handling of credit card information by our store and its service providers. For more insight, you may also want to read terms and conditions of PayPal on https://paypal.com.",
                ),
                SizedBox(height: 10),

                _label("SECTION 5 – THIRD-PARTY SERVICES"),
                _labelpara(
                  "In general, the third-party providers used by us will only collect, use and disclose your information to the extent necessary to allow them to perform the services they provide to us.\nHowever, certain third-party service providers, such as payment gateways and other payment transaction processors, have their own privacy policies in respect to the information we are required to provide to them for your purchase-related transactions.\nFor these providers, we recommend that you read their privacy policies so you can understand the manner in which your personal information will be handled by these providers.\nIn particular, remember that certain providers may be located in or have facilities that are located a different jurisdiction than either you or us. So if you elect to proceed with a transaction that involves the services of a third-party service provider, then your information may become subject to the laws of the jurisdiction(s) in which that service provider or its facilities are located.\nOnce you leave our store’s website or are redirected to a third-party website or application, you are no longer governed by this Privacy Policy or our website’s Terms of Service. When you click on links on our store, they may direct you away from our site. We are not responsible for the privacy practices of other sites and encourage you to read their privacy statements.",
                ),
                SizedBox(height: 10),

                _label("SECTION 6 – SECURITY"),
                _labelpara(
                  "To protect your personal information, we take reasonable precautions and follow industry best practices to make sure it is not inappropriately lost, misused, accessed, disclosed, altered or destroyed.",
                ),
                SizedBox(height: 10),
                _label("SECTION 7 – COOKIES"),
                _labelpara(
                  "We use cookies to maintain session of your user. It is not used to personally identify you on other websites.",
                ),
                SizedBox(height: 10),
                _label("SECTION 8 – AGE OF CONSENT"),
                _labelpara(
                  "By using this site, you represent that you are at least the age of majority in your state or province of residence, or that you are the age of majority in your state or province of residence and you have given us your consent to allow any of your minor dependents to use this site.",
                ),
                SizedBox(height: 10),
                _label("SECTION 9 – CHANGES TO THIS PRIVACY POLICY"),
                _labelpara(
                  "We reserve the right to modify this privacy policy at any time, so please review it frequently. Changes and clarifications will take effect immediately upon their posting on the website. If we make material changes to this policy, we will notify you here that it has been updated, so that you are aware of what information we collect, how we use it, and under what circumstances, if any, we use and/or disclose it.\nIf our store is acquired or merged with another company, your information may be transferred to the new owners so that we may continue to sell products to you.",
                ),

                SizedBox(height: 10),
                _label("QUESTIONS AND CONTACT INFORMATION"),
                _labelpara(
                  "If you would like to: access, correct, amend or delete any personal information we have about you, register a complaint, or simply want more information contact our Privacy Compliance Officer at office@cfbbi.com",
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
