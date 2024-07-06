import 'package:flutter/material.dart';
import 'package:coinwave/backend/coimarketcap_api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();
  Future<List<dynamic>>? cryptocurrencies;

  @override
  void initState() {
    super.initState();
    cryptocurrencies = apiService.fetchCryptocurrencies();
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
                hintText: 'Search Stocks or CyptoCurrencies',
                prefixIcon: Icon(Icons.travel_explore),
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
            child: FutureBuilder<List<dynamic>>(
              future: cryptocurrencies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                }
                else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var cryptocurrency = snapshot.data![index];
                      var logoUrl = 'https://s2.coinmarketcap.com/static/img/coins/64x64/${cryptocurrency['id']}.png';
                      return ListTile(
                        leading: Image.network(logoUrl, width: 40, height: 40, errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error);
                        }),
                        title: Text(cryptocurrency['name']),
                        subtitle: Text('Price: \$${cryptocurrency['quote']['USD']['price']}'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[500],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.paid),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
        ],
        selectedItemColor: Colors.white,
      ),
    );
  }
}
