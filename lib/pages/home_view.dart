import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  // Fetch cryptocurrencies
  Future<List<dynamic>> fetchCryptocurrencies() async {
    final response = await http.get(Uri.parse('$baseUrl/crypto'));

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load cryptocurrencies');
    }
  }

  // Fetch ETFs and stocks
  Future<Map<String, dynamic>> fetchStockAndEtfData() async {
    final response = await http.get(Uri.parse('$baseUrl/stocks'));

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load stocks and ETFs');
    }
  }
}



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService('http://192.168.1.234:5000');
  Future<List<dynamic>>? cryptocurrencies;
  Future<Map<String, dynamic>>? stocksAndEtfs;

  @override
  void initState() {
    super.initState();
    cryptocurrencies = apiService.fetchCryptocurrencies();
    stocksAndEtfs = apiService.fetchStockAndEtfData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        elevation: 0,
        title: const Text('C O I N W A V E'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            // menu open logic here
          },
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // profile open logic here
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Stocks or Cryptocurrencies',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.green,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<List<dynamic>>(
                    future: cryptocurrencies,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No cryptocurrencies available'));
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Cryptocurrencies',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var cryptocurrency = snapshot.data![index];
                                return ListTile(
                                  title: Text(cryptocurrency['Name']),
                                  subtitle: Text('Price: \$${cryptocurrency['Price (USD)']}'),
                                );
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  FutureBuilder<Map<String, dynamic>>(
                    future: stocksAndEtfs,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No stocks or ETFs available'));
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'ETFs',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!['etfs']!.length,
                              itemBuilder: (context, index) {
                                var etf = snapshot.data!['etfs']![index];
                                return ListTile(
                                  title: Text(etf['Symbol']),
                                  subtitle: Text('Price: \$${etf['Price (USD)']}'),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Stocks',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!['stocks']!.length,
                              itemBuilder: (context, index) {
                                var stock = snapshot.data!['stocks']![index];
                                return ListTile(
                                  title: Text(stock['Symbol']),
                                  subtitle: Text('Price: \$${stock['Price (USD)']}'),
                                );
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
