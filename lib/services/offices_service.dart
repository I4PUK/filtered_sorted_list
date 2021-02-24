import 'dart:convert';

import 'package:test_unikoom/models/office/office.dart';
import 'package:test_unikoom/models/offices_list/offices_list.dart';
import 'package:http/http.dart' as http;

class OfficesService {
  static Future<OfficesList> getOfficesList() async {
    const url = 'https://about.google/static/data/locations.json';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return OfficesList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}
