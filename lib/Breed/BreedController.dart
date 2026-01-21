import 'dart:convert';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:bb/Breed/BreedModel.dart';
import 'package:http/http.dart' as http;

class Breedcontroller {
  static Future<List<BreedModel>> fetchLocations(String id) async {
    var url = allapiscreen.breed.toString();
    var Header = await allapiscreen.headerFunction();

    final response = await http.post(
      Uri.parse(url),
      headers: Header,
      body: {"breed_category_id": id},
    );
    if (response.statusCode == 200) {
      String body = response.body;

      // Remove anything after the last closing brace
      int jsonEndIndex = body.lastIndexOf('}');
      if (jsonEndIndex != -1) {
        body = body.substring(0, jsonEndIndex + 1);
      }

      final data = json.decode(body);
      print(data['data']);

      // final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> locations = data['data'];
      return locations.map((e) => BreedModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load locations");
    }
  }
}
