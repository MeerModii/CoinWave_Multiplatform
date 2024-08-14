import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoService {
  final String baseUrl;

  CryptoService(this.baseUrl);

  Future<List<dynamic>> fetchTopCryptoData() async {
    final response = await http.get(Uri.parse('$baseUrl/crypto'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> fetchSpecificCryptoData(String cryptoName) async {
    final response = await http.get(Uri.parse('$baseUrl/crypto/$cryptoName'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

// class StockService {
//   final String baseUrl;

//   StockService(this.baseUrl);

//   Future<Map<String, dynamic>> fetchStockData() async {
//     final response = await http.get(Uri.parse('$baseUrl/stocks'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   Future<Map<String, dynamic>> fetchSpecificStockData(String tickerSymbol) async {
//     final response = await http.get(Uri.parse('$baseUrl/stocks/$tickerSymbol'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }
