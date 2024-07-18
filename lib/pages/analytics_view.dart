import 'package:flutter/material.dart';

class AnalyticsView extends StatefulWidget {
  @override
  _AnalyticsViewState createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        elevation: 0,
        title: const Text('A N A L Y T I C S'),
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
        child: Text('Analytics content goes here'),
      ),
    );
  }
}
