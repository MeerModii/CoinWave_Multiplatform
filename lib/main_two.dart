import 'package:flutter/material.dart';
import 'coimarketcap_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // hello world
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
    // print(cryptocurrencies);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('CoinWave'),
      //   centerTitle: true,
      //     backgroundColor: Colors.green,
      //
      //   leading: Container(
      //     margin:EdgeInsets.all(10),
      //     decoration: BoxDecoration(
      //       color: Colors.black,
      //       borderRadius: BorderRadius.all(Radius.circular(10)),
      //     )
      //   ),
      //   actions: [
      //     Container(
      //       margin: EdgeInsets.only(right: 10.0), // Adjust margin as needed
      //       child: IconButton(
      //         icon: Icon(
      //           Icons.refresh,
      //           size: 35.0, // Adjust icon size as needed
      //         ),
      //         onPressed: () {
      //           cryptocurrencies = apiService.fetchCryptocurrencies();
      //           setState(() {});
      //         },
      //       ),
      //     )
      //   ],
      // ),
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
      backgroundColor: Colors.white,
    );
  }
}
