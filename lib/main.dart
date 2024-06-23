import 'package:coinwave/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

// This is the main function that starts the application
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    // hello world
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      useMaterial3: true,
    ),
    home: const LoginView(),
  ),);
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register'),
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
              
              final userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword( 
                email: email, 
                password: password, 
                );
            },
            child: const Text('Register'),),
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

// This is the class for homepage 
