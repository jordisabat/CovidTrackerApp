import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_ddd_notes/models/covid_country.model.dart';

import 'api.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService(this.api);
  final API api;

  Future<CovidCountry> getEndpointData({
    @required Endpoint endpoint,
    @required String country,
  }) async {
    final uri = api.endpointUri(endpoint, country);
    final response = await http.get(
      uri.toString(),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return CovidCountry.fromJson(json.decode(response.body));
    }
    print(
        'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }
}
