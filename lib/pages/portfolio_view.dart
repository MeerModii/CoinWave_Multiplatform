import 'package:flutter/material.dart';

class PortfolioView extends StatefulWidget {
  @override
  _PortfolioViewState createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        elevation: 0,
        title: const Text('P O R T F O L I O'),
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
      body: Center(
        child: Text('Your portfolio goes here'),
      ),
    );
  }
}
