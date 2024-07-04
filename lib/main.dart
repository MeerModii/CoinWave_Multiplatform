import 'package:coinwave/login_view.dart';
import 'package:flutter/material.dart';
import 'package:coinwave/register_view.dart';
import 'package:coinwave/home_view.dart';
import 'package:coinwave/newlogin.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}
