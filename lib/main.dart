import 'dart:convert';
import 'package:bb/AnimalCategory/screen/animal_category_screen.dart';
import 'package:bb/Credential/loginScreen.dart';
import 'package:bb/Credential/otpScreen.dart';
import 'package:bb/DonateNow.dart';
import 'package:bb/LeaderBoard.dart';
import 'package:bb/LeaderBoardPage.dart';
import 'package:bb/Navigation/navigationScreen.dart';
import 'package:bb/Notification.dart';
import 'package:bb/PetInfo/Blood_Donate.dart';
import 'package:bb/PetInfo/ExpireDate.dart';
import 'package:bb/PetInfo/Mensuration.dart';
import 'package:bb/PetInfo/PetReqistration.dart';
import 'package:bb/PetInfo/UpdatePetDetails.dart';
import 'package:bb/PetInfo/WeightUpdate.dart';
import 'package:bb/PetInfo/petCategoryScreen.dart';
import 'package:bb/PetInfo/petDetails.dart';
import 'package:bb/PetInfo/petHealthInfo.dart';
import 'package:bb/PetInfo/petListScreen.dart';
import 'package:bb/PetInfo/petMedications.dart';
import 'package:bb/PetInfo/petMicroChipForm.dart';
import 'package:bb/PetInfo/petVaccinationDetails.dart';
import 'package:bb/PetInfo/petVeterinarianInfo.dart';
import 'package:bb/Poilcy/AboutsUs.dart';
import 'package:bb/Poilcy/privacy_policy.dart';
import 'package:bb/Poilcy/refund_calcilcation.dart';
import 'package:bb/Poilcy/shinping_policy.dart';
import 'package:bb/Poilcy/terms_conditions.dart';
import 'package:bb/SosSCreen.dart';
import 'package:bb/Splash/splashScreen.dart';
import 'package:bb/UpdateProfile.dart';
import 'package:bb/UserProfile.dart';
import 'package:bb/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';

// At the top of your main.dart file
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase using the default options for the current platform
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(
    MaterialApp(
      navigatorKey: navigatorKey, // <--- Add this
      home: Splashscreen(),
      // home: isLoggedIn ? NavigationBarApp() : BloodBankLoginPage(),
      // 2. Define all routes consistently
      routes: {
        '/login': (context) => BloodBankLoginPage(),
        '/otp': (context) => Otpscreen(),
        '/home': (context) => NavigationBarApp(indexvalue: 0),
        '/home1': (context) => NavigationBarApp(indexvalue: 1),
        '/home2': (context) => NavigationBarApp(indexvalue: 2),
        '/profile': (context) => Userprofile(),
        '/petRegistration': (context) => PetFormScreen(),
        '/updatepetDetails': (context) => Updatepetdetails(),
        '/petList': (context) => PetListScreen(),
        '/userRegistration': (context) => Updateprofile(),
        '/petDetails': (context) => PetDetailScreen(),
        '/petCategory': (context) => AnimalCategoryScreen(),
        '/petmicrochip': (context) => MicrochipForm(),
        '/mensuration': (context) => Mensuration(),
        '/sos': (context) => Sosscreen(),
        '/petCategoryScreen': (context) => Petcategoryscreen(),
        '/petHealthinfo': (context) => Pethealthinfo(),
        '/petvaccinationdetails': (context) => Petvaccinationdetails(),
        '/petmedications': (context) => Petmedications(),
        '/petveterinarianinfo': (context) => Petveterinarianinfo(),
        '/petWeightupdate': (context) => Weightupdate(),
        // policys
        '/privacyPolicy': (context) => PrivacyPolicy(),
        '/termsConditions': (context) => TermsConditions(),
        '/refundCalcilcation': (context) => RefundCalcilcation(),
        '/shinpingPolicy': (context) => ShinpingPolicy(),
        '/Aboutsus': (context) => Aboutsus(),
        '/Expiredate': (context) => Expiredate(),
        '/BloodDonatePetInfo': (context) => BloodDonatePetInfo(),
        '/Notification': (context) => NotificationApp(),
        '/Donatenow': (context) => Donatenow(),
        '/LeaderboardSection': (context) => LeaderboardScreen(),
      },
      debugShowCheckedModeBanner: false,
      navigatorObservers: [observer],
    ),
  );
  // runApp( MyApp(isLoggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //bool isLoggedIn,
  // This widget is the root of your application.
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      navigatorObservers: [observer],
      // initialRoute: '/login',
      // routes: {
      //   '/login': (context) => BloodBankLoginPage(),
      //   '/otp': (context) => Otpscreen(), // Your current screen
      //   '/home': (context) => NavigationBarApp(), // The screen you want to go to
      // },
      // home: BloodBankLoginPage(),
      //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ================= PRODUCTION CONFIG =================
  // final String environment = "PRODUCTION";
  // final String merchantId = "M22ATOSMNURWN";
  // final String saltKey = "2f2fa7cd-e50d-480c-9534-78d54127a0f0";
  // final String saltIndex = "1";

  final String environment = "SANDBOX"; // or "PRODUCTION"
  final String merchantId = "PGTESTPAYUAT86";
  final String saltKey = "96434309-7796-489d-8924-ab56988a6076";
  final String saltIndex = "1";
  // final String appId = "";

  final String callbackUrl = "https://affcats.com/";
  final String apiEndPoint = "/pg/v1/pay";
  final bool enableLogging = true;
  final String appId = "com.pashuraktkosh.app";
  // =====================================================

  final uuid = const Uuid();
  String transactionId = "";
  String body = "";
  String checksum = "";
  String result = "";

  @override
  void initState() {
    super.initState();
    initPhonePe();
  }

  // ---------------- INIT SDK ----------------
  Future<void> initPhonePe() async {
    print("$environment $merchantId $appId $enableLogging");
    try {
      final isInit = await PhonePePaymentSdk.init(environment, merchantId, appId, enableLogging);

      setState(() {
        result = "SDK Initialized: $isInit";
      });
    } catch (e) {
      setState(() {
        result = "Init Error: $e";
      });
    }
  }

  // ---------------- CHECKSUM ----------------
  // void createChecksum() {
  //   transactionId = "ORD${DateTime.now().millisecondsSinceEpoch}";

  //   final payload = {
  //     "merchantId": merchantId,
  //     "merchantTransactionId": transactionId,
  //     "merchantUserId": "USER123",
  //     "amount": 100, // ₹1 (paise)
  //     "callbackUrl": callbackUrl,
  //     "paymentInstrument": {"type": "PAY_PAGE", "targetApp": "com.phonepe.app"},
  //     "deviceContext": {"deviceOS": "ANDROID"},
  //   };

  //   // ✅ JSON string for SDK
  //   body = json.encode(payload);

  //   // ✅ Base64 ONLY for checksum
  //   final base64Body = base64.encode(utf8.encode(body));

  //   checksum = "${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey))}###$saltIndex";
  // }

  String getChecksum() {
    transactionId = "ORD${DateTime.now().millisecondsSinceEpoch}";
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": transactionId,
      "merchantUserId": "90223250",
      "amount": 1000,
      "mobileNumber": "9999999999",
      "callbackUrl": callbackUrl,
      "paymentInstrument": {"type": "PAY_PAGE"},
    };

    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));

    checksum =
        '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';

    return base64Body;
  }

  // ---------------- START PAYMENT ----------------

  Future<void> startPayment() async {
    try {
      var response = PhonePePaymentSdk.startTransaction(body, checksum);
      response
          .then((val) async {
            if (val != null) {
              String status = val['status'].toString();
              String error = val['error'].toString();

              if (status == 'SUCCESS') {
                result = "Flow complete - status : SUCCESS";

                await checkStatus();
              } else {
                result = "Flow complete - status : $status and error $error";
              }
            } else {
              result = "Flow Incomplete";
            }
          })
          .catchError((error) {
            // handleError(error);
            return <dynamic>{};
          });
    } catch (e) {
      setState(() => result = "Payment Error: $e");
    }
  }

  // ---------------- CHECK STATUS ----------------
  Future<void> checkStatus() async {
    final url = "https://api.phonepe.com/apis/hermes/pg/v1/status/$merchantId/$transactionId";

    final xVerify =
        "${sha256.convert(utf8.encode("/pg/v1/status/$merchantId/$transactionId$saltKey"))}###$saltIndex";

    final headers = {
      "Content-Type": "application/json",
      "X-VERIFY": xVerify,
      "X-MERCHANT-ID": merchantId,
    };

    final res = await http.get(Uri.parse(url), headers: headers);
    setState(() {
      result = "Status API: ${res.body}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PhonePe Production")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                body = getChecksum().toString();
                startPayment();
              },
              child: const Text("Pay ₹1 with PhonePe"),
            ),
          ],
        ),
      ),
    );
  }
}
