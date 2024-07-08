import 'package:flutter/material.dart';
import 'package:coinwave/pages/register_view.dart';
import 'package:coinwave/pages/home_view.dart';
import 'package:coinwave/pages/login_view.dart';


void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
