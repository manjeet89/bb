import 'dart:convert';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/PetInfo/petCategoryModel.dart';
import 'package:http/http.dart' as http;

class Petcategorycontroller {
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
