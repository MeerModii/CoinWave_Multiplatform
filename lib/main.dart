import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// This is the main function that starts the application
void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      useMaterial3: true,
    ),
    home: const HomePage(),
  ),);
}

// This is the class for homepage 
class HomePage extends StatefulWidget {
  // This is default
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState(){
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  //We editted this
  @override
  Widget build(BuildContext context) {

    // This is for the top section of the home page
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      
      // This is for the bottom section background color
      backgroundColor: Colors.white,

      // This is for the body of the home page and we are centering it
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email'
            )
          ),
          TextField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password'
            ),
          ),
          TextButton(onPressed: () async {
            
          },child: const Text('Register'),),
        ],
      ),
    );
  }
}