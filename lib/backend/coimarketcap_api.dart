import 'dart:convert';

// dart:convert: This Dart library provides utilities to encode and decode JSON. We use it to 
//convert JSON data from the API response into a Dart map.

import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = '4b63ad08-de18-4768-933d-7730186e8ac6';
  final String apiUrl = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';

  Future<List<dynamic>> fetchCryptocurrencies() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'X-CMC_PRO_API_KEY': apiKey,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
