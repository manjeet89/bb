import 'dart:convert';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/PetInfo/petCategoryModel.dart';
import 'package:bb/PetInfo/petListModel.dart';
import 'package:bb/PetInfo/petWeightHistoryModel.dart';
import 'package:http/http.dart' as http;

class PetService {
  static Future<List<Petlistmodel>> fetchPets() async {
    var url = allapiscreen.mypetlist.toString();
    // var categoryurl = allapiscreen.petcategory.toString();

    var Header = await allapiscreen.headerFunction();
    final response = await http.post(Uri.parse(url), headers: Header);
    // final categoryresponse = await http.post(Uri.parse(categoryurl), headers: Header);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      print(decoded);
      List list = decoded['data'];

      return list.map((e) => Petlistmodel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load pets");
    }
  }

  static Future<List<Petweighthistorymodel>> fetchPetsWeightHistory(String petId, String petWeight) async {
    var url = allapiscreen.petweight.toString();
    // var categoryurl = allapiscreen.petcategory.toString();

    var Header = await allapiscreen.headerFunction();
    final response = await http.post(
      Uri.parse(url),
      headers: Header,
      body: {"pet_id": petId, "pet_weight_in_kg": petWeight},
    );
    // final categoryresponse = await http.post(Uri.parse(categoryurl), headers: Header);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      print(decoded);
      List list = decoded['history_data'];

      return list.map((e) => Petweighthistorymodel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load pets");
    }
  }

  static Future<List<Petcategorymodel>> fetchPetsCategory() async {
    var url = allapiscreen.petcategory.toString();
    var Header = await allapiscreen.headerFunction();

    print(Header.toString());
    final response = await http.post(Uri.parse(url), headers: Header);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      print(decoded);
      List list = decoded['data'];

      return list.map((e) => Petcategorymodel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load pets");
    }
  }
}
