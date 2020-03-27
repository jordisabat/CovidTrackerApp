import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'api.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService(this.api);
  final API api;

  Future<int> getEndpointData({
    @required Endpoint endpoint,
    @required String country,
  }) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(
      uri.toString(),
    );
    print(response);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        // final String responseJsonKey = _responseJsonKeys[endpoint];
        final int result = endpointData['cases'];
        if (result != null) {
          return result;
        }
      }
    }
    print(
        'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  // static Map<Endpoint, String> _responseJsonKeys = {
  //   Endpoint.countries: 'countries',
  // };
}
