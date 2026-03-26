// import 'dart:convert';
// import 'dart:io';
// import 'package:bb/ApiFolder/AllapiScreen.dart';
// import 'package:bb/PetInfo/petListModel.dart';
// import 'package:bb/utils/app_colors.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

// class MicrochipForm extends StatefulWidget {
//   const MicrochipForm({super.key});

//   @override
//   State<MicrochipForm> createState() => _MicrochipFormState();
// }

// class _MicrochipFormState extends State<MicrochipForm> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController microchipNumberCtrl = TextEditingController();
//   final TextEditingController implementerNameCtrl = TextEditingController();
//   final TextEditingController mobileCtrl = TextEditingController();
//   final TextEditingController dateCtrl = TextEditingController();

//   String? implementedBy;
//   File? certificateFile;

//   bool isCheckboxChecked = true; // Track checkbox state
//   bool isCheckboxCheckedsecond = true; // Track checkbox state

//   final List<String> implementedByList = ['Veterinarian', 'Different Feline Club', 'Other'];

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

//       setState(() {
//         microchipNumberCtrl.text = pet.microchipNumber ?? "";
//         implementerNameCtrl.text = pet.microchipImplementorName ?? "";
//         mobileCtrl.text = pet.microchipImplementorMobileNumber ?? "";
//         dateCtrl.text = pet.microchipImplementedDate ?? "";
//         implementedBy = pet.microchipImplementedBy;
//       });
//     });
//   }

//   Future<void> scanAndFetchStock() async {
//     String barcodescanerres;
//     String? qrCode = await SimpleBarcodeScanner.scanBarcode(
//       context,
//       barcodeAppBar: const BarcodeAppBar(
//         appBarTitle: 'Test',
//         centerTitle: false,
//         enableBackButton: true,
//         backButtonIcon: Icon(Icons.arrow_back_ios),
//       ),
//       isShowFlashIcon: true,
//       delayMillis: 500,
//       cameraFace: CameraFace.back,
//       scanFormat: ScanFormat.ALL_FORMATS,
//     );
//     barcodescanerres = qrCode as String;
//     if (qrCode != '-1') {
//       setState(() {
//         microchipNumberCtrl.text = barcodescanerres;
//       });
//     }
//   }

//   /// 📂 Pick document/image/pdf
//   Future<void> pickCertificate() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'png', 'pdf', 'doc', 'docx'],
//     );

//     if (result != null) {
//       setState(() {
//         DateTime now = DateTime.now();
//         certificateFile = File(result.files.single.path!);
//         print(now.second.toString() + certificateFile!.path.split('/').last);
//       });
//     }
//   }

//   /// 📅 Pick date
//   Future<void> pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//       initialDate: DateTime.now(),
//     );

//     if (picked != null) {
//       dateCtrl.text = "${picked.year}-${picked.month}-${picked.day}";
//     }
//   }

//   /// 📤 Submit
//   void submitForm() async {
//     // if (_formKey.currentState!.validate() && certificateFile != null) {
//     //   final data = {
//     //     "microchip_number": microchipNumberCtrl.text,
//     //     "implemented_by": implementedBy,
//     //     "implementer_name": implementerNameCtrl.text,
//     //     "implementer_mobile": mobileCtrl.text,
//     //     "implemented_date": dateCtrl.text,
//     //     "certificate_file": certificateFile!.path,
//     //   };

//     //   debugPrint("FORM DATA 👉 $data");
//     // }

//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

//     var url = allapiscreen.microchipupdate.toString();
//     var Header = await allapiscreen.headerFunction();

//     Dio dio = Dio();
//     DateTime now = DateTime.now();

//     FormData formData = FormData.fromMap({
//       if (certificateFile.toString() != "null")
//         'microchip_document': await MultipartFile.fromFile(
//           certificateFile!.path,
//           filename: now.second.toString() + certificateFile!.path.split('/').last,
//         ),
//       "pet_id": pet.petId.toString(),
//       "microchip_number": microchipNumberCtrl.text,
//       "microchip_implemented_by": implementedBy,
//       "microchip_implementor_name": implementerNameCtrl.text,
//       "microchip_implementor_mobile_number": mobileCtrl.text,
//       "microchip_implemented_date": dateCtrl.text,
//     });

//     Response response = await dio.post(
//       url,
//       data: formData,
//       options: Options(headers: Header),
//     );

//     if (response.statusCode == 200) {
//       print("done");
//       print(response);

//       scaffoldMessenger.showSnackBar(
//         SnackBar(
//           content: Text("Uploaded"),
//           backgroundColor: Colors.redAccent, // Red for errors
//           behavior: SnackBarBehavior.floating, // Modern floating look
//           duration: Duration(seconds: 2),
//           // action: SnackBarAction(
//           //   label: 'RETRY',
//           //   textColor: Colors.white,
//           //   onPressed: () => firstnameController.clear(),
//           // ),
//         ),
//       );
//       Navigator.pop(context);
//     }
//   }

//   Widget _label(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Text(
//         text,
//         style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final scaffoldMessenger = ScaffoldMessenger.of(context);
//     final Petlistmodel pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Microchip Details",
//           style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: AppColors.primarycolor,
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//           color: AppColors.dividerGrey,
//           // gradient: LinearGradient(
//           //   colors: [AppColors.darkRed, AppColors.lightRed],
//           //   begin: Alignment.centerLeft,
//           //   end: Alignment.centerRight,
//           // ),
//         ),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(6),
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: AppColors.secondrycolor,
//                         blurRadius: 8,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       _detailRow("Name of Pet", pet.petName.toString().replaceAll("-", "")),
//                       _detailRow(
//                         "Registration Number",
//                         pet.petBirthDate.toString().replaceAll("-", "") + pet.petId.toString(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(6),
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: AppColors.secondrycolor,
//                         blurRadius: 8,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _label("Microchip Number "),
//                           InkWell(
//                             onTap: () async {
//                               // scanBarCode();
//                               scanAndFetchStock();
//                             },
//                             child: const Icon(
//                               Icons.qr_code_scanner_outlined,
//                               color: Color(0xFF035d79),
//                               size: 25,
//                             ),
//                           ),
//                         ],
//                       ),
//                       _buildTextField(controller: microchipNumberCtrl),

//                       _label("Implemented By *"),
//                       _buildDropdown(),

//                       _label("Veterinarian Name *"),
//                       _buildTextField(controller: implementerNameCtrl),

//                       _label("Veterinarian Mobile Number *"),
//                       _buildTextField(controller: mobileCtrl, keyboard: TextInputType.phone),

//                       _label("Insertion Date"),
//                       _buildDateField(),

//                       _label("Microchip Insertion Certificate *"),
//                       _buildFilePicker(),

//                       const SizedBox(height: 18),

//                       /// Checkbox with text
//                       CheckboxListTile(
//                         value: isCheckboxChecked,
//                         onChanged: (value) {
//                           setState(() {
//                             isCheckboxChecked = value ?? false;
//                           });
//                         },
//                         title: const Text(
//                           "By submitting this form, you agree to indemnify and hold the website harmless, its officers, directors, employees, and agents from and against any and all claims, liabilities, damages, losses, and expenses, including but not limited to legal fees, arising out of or in connection with your participation in the activities of the Absolute Feline Fanciers.",
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       /// Checkbox with text
//                       CheckboxListTile(
//                         value: isCheckboxCheckedsecond,
//                         onChanged: (value) {
//                           setState(() {
//                             isCheckboxCheckedsecond = value ?? false;
//                           });
//                         },
//                         title: const Text(
//                           "I certify that the information provided in this form is true, accurate, and complete to the best of my knowledge. I understand that providing false or misleading information may result in the rejection of this application or termination of membership.",
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       const SizedBox(height: 24),

//                       SizedBox(
//                         width: double.infinity,
//                         height: 52,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primarycolor,
//                             foregroundColor: AppColors.white,
//                             // padding: const EdgeInsets.symmetric(vertical: 14),
//                           ),
//                           onPressed: isCheckboxChecked && isCheckboxCheckedsecond
//                               ? () {
//                                   if (microchipNumberCtrl.text.isEmpty) {
//                                     scaffoldMessenger.showSnackBar(
//                                       SnackBar(
//                                         content: Text('MicroChip number enter'),
//                                         backgroundColor: AppColors.warningOrange, // Red for errors
//                                         behavior: SnackBarBehavior.floating, // Modern floating look
//                                         duration: Duration(seconds: 3),
//                                         action: SnackBarAction(
//                                           label: 'RETRY',
//                                           textColor: Colors.white,
//                                           onPressed: () => microchipNumberCtrl.clear(),
//                                         ),
//                                       ),
//                                     );
//                                   } else if (implementedBy == "null") {
//                                     scaffoldMessenger.showSnackBar(
//                                       SnackBar(
//                                         content: Text('Select Implemented By'),
//                                         backgroundColor: AppColors.warningOrange, // Red for errors
//                                         behavior: SnackBarBehavior.floating, // Modern floating look
//                                         duration: Duration(seconds: 3),
//                                         // action: SnackBarAction(
//                                         //   label: 'RETRY',
//                                         //   textColor: Colors.white,
//                                         //   onPressed: () => petNameController.clear(),
//                                         // ),
//                                       ),
//                                     );
//                                   } else if (implementerNameCtrl.text.isEmpty) {
//                                     scaffoldMessenger.showSnackBar(
//                                       SnackBar(
//                                         content: Text('Implemented name enter'),
//                                         backgroundColor: AppColors.warningOrange, // Red for errors
//                                         behavior: SnackBarBehavior.floating, // Modern floating look
//                                         duration: Duration(seconds: 3),
//                                         action: SnackBarAction(
//                                           label: 'RETRY',
//                                           textColor: Colors.white,
//                                           onPressed: () => implementerNameCtrl.clear(),
//                                         ),
//                                       ),
//                                     );
//                                   } else if (mobileCtrl.text.isEmpty) {
//                                     scaffoldMessenger.showSnackBar(
//                                       SnackBar(
//                                         content: Text('Number enter'),
//                                         backgroundColor: AppColors.warningOrange, // Red for errors
//                                         behavior: SnackBarBehavior.floating, // Modern floating look
//                                         duration: Duration(seconds: 3),
//                                         action: SnackBarAction(
//                                           label: 'RETRY',
//                                           textColor: Colors.white,
//                                           onPressed: () => mobileCtrl.clear(),
//                                         ),
//                                       ),
//                                     );
//                                   } else if (dateCtrl.text.isEmpty) {
//                                     scaffoldMessenger.showSnackBar(
//                                       SnackBar(
//                                         content: Text('Implemented date enter'),
//                                         backgroundColor: AppColors.warningOrange, // Red for errors
//                                         behavior: SnackBarBehavior.floating, // Modern floating look
//                                         duration: Duration(seconds: 3),
//                                         action: SnackBarAction(
//                                           label: 'RETRY',
//                                           textColor: Colors.white,
//                                           onPressed: () => dateCtrl.clear(),
//                                         ),
//                                       ),
//                                     );
//                                   } else if (certificateFile.toString() == "null") {
//                                     scaffoldMessenger.showSnackBar(
//                                       SnackBar(
//                                         content: Text('Select doc'),
//                                         backgroundColor: AppColors.warningOrange, // Red for errors
//                                         behavior: SnackBarBehavior.floating, // Modern floating look
//                                         duration: Duration(seconds: 3),
//                                         // action: SnackBarAction(
//                                         //   label: 'RETRY',
//                                         //   textColor: Colors.white,
//                                         //   onPressed: () => petNameController.clear(),
//                                         // ),
//                                       ),
//                                     );
//                                   } else {
//                                     // scaffoldMessenger.showSnackBar(
//                                     //   SnackBar(
//                                     //     content: Text(
//                                     //       'Unhandled Exception: type MultipartFile is not a subtype of type String in type cast',
//                                     //     ),
//                                     //     backgroundColor: AppColors.warningOrange, // Red for errors
//                                     //     behavior: SnackBarBehavior.floating, // Modern floating look
//                                     //     duration: Duration(seconds: 3),
//                                     //     // action: SnackBarAction(
//                                     //     //   label: 'RETRY',
//                                     //     //   textColor: Colors.white,
//                                     //     //   onPressed: () => petNameController.clear(),
//                                     //     // ),
//                                     //   ),
//                                     // );
//                                     submitForm();
//                                   }
//                                 }
//                               : null,
//                           child: const Text(
//                             "SUBMIT",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _detailRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(color: AppColors.fontGrey, fontWeight: FontWeight.w400),
//           ),
//           Text(
//             value.isNotEmpty ? value : "-",
//             style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primarycolor),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🔹 TextField
//   Widget _buildTextField({
//     required TextEditingController controller,

//     TextInputType keyboard = TextInputType.text,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboard,
//         validator: (v) => v!.isEmpty ? 'Required' : null,
//         decoration: _inputDecoration(),
//       ),
//     );
//   }

//   /// 🔹 Dropdown
//   Widget _buildDropdown() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: DropdownButtonFormField<String>(
//         initialValue: implementedBy,
//         items: implementedByList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//         onChanged: (v) => setState(() => implementedBy = v),
//         validator: (v) => v == null ? 'Required' : null,
//         decoration: _inputDecoration(),
//       ),
//     );
//   }

//   /// 🔹 Date Picker
//   Widget _buildDateField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: TextFormField(
//         controller: dateCtrl,
//         readOnly: true,
//         validator: (v) => v!.isEmpty ? 'Required' : null,
//         decoration: _inputDecoration().copyWith(suffixIcon: const Icon(Icons.calendar_today)),
//         onTap: pickDate,
//       ),
//     );
//   }

//   /// 🔹 File Picker
//   Widget _buildFilePicker() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: InkWell(
//         onTap: pickCertificate,
//         child: InputDecorator(
//           decoration: _inputDecoration(),
//           child: Row(
//             children: [
//               const Icon(Icons.attach_file),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Text(
//                   certificateFile == null
//                       ? "Select Image / PDF / DOC"
//                       : certificateFile!.path.split('/').last,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// 🎨 Input Decoration
//   InputDecoration _inputDecoration() {
//     return InputDecoration(
//       filled: true,
//       fillColor: AppColors.white,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide(color: AppColors.border),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Header.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/utils/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class MicrochipForm extends StatefulWidget {
  const MicrochipForm({super.key});

  @override
  State<MicrochipForm> createState() => _MicrochipFormState();
}

class _MicrochipFormState extends State<MicrochipForm> {
  final _formKey = GlobalKey<FormState>();

  final microchipNumberCtrl = TextEditingController();
  final implementerNameCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final dateCtrl = TextEditingController();

  String? implementedBy;
  File? certificateFile;

  bool agree1 = false;
  bool agree2 = false;

  final implementedByList = ['Veterinarian', 'Different Feline Club', 'Other'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

      microchipNumberCtrl.text = pet.microchipNumber ?? "";
      implementerNameCtrl.text = pet.microchipImplementorName ?? "";
      mobileCtrl.text = pet.microchipImplementorMobileNumber ?? "";
      dateCtrl.text = pet.microchipImplementedDate ?? "";
      implementedBy = pet.microchipImplementedBy;
      setState(() {});
    });
  }

  // ================= SCAN =================
  Future<void> scanMicrochip() async {
    String? code = await SimpleBarcodeScanner.scanBarcode(
      context,
      isShowFlashIcon: true,
      scanFormat: ScanFormat.ALL_FORMATS,
    );
    if (code != null && code != '-1') {
      microchipNumberCtrl.text = code;
    }
  }

  // ================= DATE =================
  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      dateCtrl.text = "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  // ================= FILE =================
  Future<void> pickCertificate() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf', 'doc', 'docx'],
    );
    if (result != null) {
      certificateFile = File(result.files.single.path!);
      setState(() {});
    }
  }

  // ================= SUBMIT =================
  Future<void> submitForm() async {
    final pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;
    final header = await allapiscreen.headerFunction();
    final url = allapiscreen.microchipupdate.toString();

    FormData data = FormData.fromMap({
      "pet_id": pet.petId.toString(),
      "microchip_number": microchipNumberCtrl.text,
      "microchip_implemented_by": implementedBy,
      "microchip_implementor_name": implementerNameCtrl.text,
      "microchip_implementor_mobile_number": mobileCtrl.text,
      "microchip_implemented_date": dateCtrl.text,
      if (certificateFile != null)
        "microchip_document": await MultipartFile.fromFile(certificateFile!.path),
    });

    await Dio().post(
      url,
      data: data,
      options: Options(headers: header),
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Microchip details saved")));
    Navigator.pushNamed(context, '/home1');
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final pet = ModalRoute.of(context)!.settings.arguments as Petlistmodel;

    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),
      // appBar: AppBar(
      //   title: const Text(
      //     "Microchip Details",
      //     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      //   ),
      //   backgroundColor: AppColors.primarycolor,
      // ),
            appBar: const CommonAppBar(),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.white, AppColors.secondrycolor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _card(
                child: Column(
                  children: [
                    _infoRow("Pet Name", pet.petName ?? "-"),
                    _infoRow("Registration No", "${pet.petBirthDate}${pet.petId}"),
                  ],
                ),
              ),

              _card(
                title: "Microchip Information",
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label("Microchip Number"),
                    _input(
                      controller: microchipNumberCtrl,
                      suffix: IconButton(
                        icon: const Icon(Icons.qr_code_scanner),
                        onPressed: scanMicrochip,
                      ),
                    ),

                    _label("Implemented By"),
                    _dropdown(),

                    _label("Veterinarian Name"),
                    _input(controller: implementerNameCtrl),

                    _label("Mobile Number"),
                    _input(controller: mobileCtrl, keyboard: TextInputType.phone),

                    _label("Insertion Date"),
                    _dateField(),

                    _label("Insertion Certificate"),
                    _filePicker(),
                  ],
                ),
              ),

              _card(
                title: "Declaration",
                child: Column(
                  children: [
                    CheckboxListTile(
                      value: agree1,
                      onChanged: (v) => setState(() => agree1 = v!),
                      title: const Text(
                        "I agree to indemnify and hold the organization harmless.",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                    CheckboxListTile(
                      value: agree2,
                      onChanged: (v) => setState(() => agree2 = v!),
                      title: const Text(
                        "I certify that the information provided is true.",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: agree1 && agree2 && _formKey.currentState!.validate()
                      ? submitForm
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarycolor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    "SUBMIT",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= REUSABLE =================

  Widget _card({String? title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondrycolor,
                ),
              ),
            ),
          child,
        ],
      ),
    );
  }

  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      t,
      style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.fontGrey),
    ),
  );

  Widget _input({
    required TextEditingController controller,
    TextInputType keyboard = TextInputType.text,
    Widget? suffix,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: (v) => v!.isEmpty ? "Required" : null,
      decoration: _decoration(suffix: suffix),
    ),
  );

  Widget _dropdown() => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: DropdownButtonFormField<String>(
      value: implementedBy,
      items: implementedByList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (v) => setState(() => implementedBy = v),
      validator: (v) => v == null ? "Required" : null,
      decoration: _decoration(),
    ),
  );

  Widget _dateField() => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextFormField(
      controller: dateCtrl,
      readOnly: true,
      validator: (v) => v!.isEmpty ? "Required" : null,
      onTap: pickDate,
      decoration: _decoration(suffix: const Icon(Icons.calendar_today)),
    ),
  );

  Widget _filePicker() => InkWell(
    onTap: pickCertificate,
    child: InputDecorator(
      decoration: _decoration(),
      child: Row(
        children: [
          const Icon(Icons.attach_file),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              certificateFile == null ? "Select file" : certificateFile!.path.split('/').last,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _infoRow(String t, String v) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(t, style: const TextStyle(color: AppColors.fontGrey)),
        Text(
          v,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primarycolor),
        ),
      ],
    ),
  );

  InputDecoration _decoration({Widget? suffix}) => InputDecoration(
    filled: true,
    fillColor: Colors.grey.shade50,
    suffixIcon: suffix,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: AppColors.border),
    ),
  );
}
