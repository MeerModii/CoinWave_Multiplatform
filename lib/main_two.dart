import 'package:flutter/material.dart';
import 'coimarketcap_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinMarketCap API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService apiService = ApiService();
  Future<List<dynamic>>? cryptocurrencies;

  @override
  void initState() {
    super.initState();
    cryptocurrencies = apiService.fetchCryptocurrencies();
    print(cryptocurrencies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CoinMarketCap API Demo'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: cryptocurrencies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var cryptocurrency = snapshot.data![index];
                return ListTile(
                  title: Text(cryptocurrency['name']),
                  subtitle: Text('Price: \$${cryptocurrency['quote']['USD']['price']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}