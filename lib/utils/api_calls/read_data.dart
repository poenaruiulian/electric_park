import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:electric_park/utils/utils.dart';

Future<List<Charger>> fetchData(
    http.Client client, latitude, double longitude) async {
  var url = Uri.parse(
      "https://api.openchargemap.io/v3/poi/?output=json&countrycode=RO&latitude=${latitude}5&longitude=$longitude&maxresults=30&compact=true&verbose=false&key=da8008a5-72f5-446c-95fa-31e1788a957d");
  final response =
      await client.get(url, headers: const {'User-Agent': 'Dart/3.0.6'});

  final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

  return parsed.map<Charger>((json) => Charger.fromJson(json)).toList();
}
