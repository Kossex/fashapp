import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        Fluttertoast.showToast(msg: 'Sign in with Google canceled');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential;
    } catch (e) {
      print('Sign-in with Google failed: $e');
      Fluttertoast.showToast(msg: 'Sign-in with Google failed');
      return null;
    }
  }

  Future<UserCredential?> _signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email');
      } else if (e.code == 'wrong-password') {
        print(password);
        Fluttertoast.showToast(msg: 'Wrong password provided');
      } else {
        Fluttertoast.showToast(msg: 'Sign-in with email/password failed');
      }
      return null;
    } catch (e) {
      print('Sign-in with email/password failed: $e');
      Fluttertoast.showToast(msg: 'Sign-in with email/password failed');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  if (email.isNotEmpty && password.isNotEmpty) {
                    final userCredential =
                        await _signInWithEmailAndPassword(email, password);
                    if (userCredential != null) {
                      Fluttertoast.showToast(
                          msg: 'Sign in with email/password successful');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: 'Please enter email and password');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Set button color to blue
                ),
                child: Text('Sign in with Email/Password'),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  final UserCredential? userCredential =
                      await _signInWithGoogle();
                  if (userCredential != null) {
                    Fluttertoast.showToast(
                        msg: 'Sign in with Google successful');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Set button color to blue
                ),
                icon: Image.asset(
                  'images/google.png',
                  width: 24,
                  height: 24,
                ),
                label: Text(
                  'Sign in with Google',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
