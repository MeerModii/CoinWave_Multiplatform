

import 'package:coinwave/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  // This is default
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
  
  
  @override
  Widget build(BuildContext context) {

    // This is for the top section of the home page
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      
      // This is for the bottom section background color
      backgroundColor: Colors.white,

      // This is for the body of the home page and we are centering it
      body: FutureBuilder(
        future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
                      return Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
        
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email'
              )
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
        
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password'
              ),
            ),
            TextButton(onPressed: () async {
 
              final email = _email.text;
              final password = _password.text;
              try{
                final userCred = await FirebaseAuth.instance.signInWithEmailAndPassword( 
                  email: email, 
                  password: password, 
                  );
                  print(userCred);                
              }
              on FirebaseAuthException catch(e){
                // firebase does not allow the check for indivitual errors like wrong-password etc
                // it just prints a generic error. 
                print(e);
             }

            },
            child: const Text('Login'),),
          ],
        );

            default:
             return const Text('Loading...');
          }
        },

      ),
    );
  }

}