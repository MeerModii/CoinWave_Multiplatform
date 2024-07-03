import 'package:flutter/material.dart';

class DesignPage extends StatelessWidget {
  const DesignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DesignPage'),
        centerTitle: true,

        leading: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius:BorderRadius.circular(10),
          )
        )
      ),
    );
  }
}
