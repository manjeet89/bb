import 'dart:convert';
import 'package:bb/AddressModule/State/StateModel.dart';
import 'package:bb/ApiFolder/AllapiScreen.dart';
import 'package:http/http.dart' as http;

class Statecontroller {
  static Future<List<StateModel>> fetchLocations({required String categoryId}) async {
    var url = allapiscreen.state.toString();
    var Header = await allapiscreen.headerFunction();

    final response = await http.post(
      Uri.parse(url),
      headers: Header,
      body: {'country_id': categoryId},
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
      return locations.map((e) => StateModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load locations");
    }
  }
}
