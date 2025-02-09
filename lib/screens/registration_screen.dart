import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_template/constants.dart';
import 'package:firebase_auth_template/screens/home_screen.dart';
import 'package:firebase_auth_template/widgets/rounded_button.dart';
import 'package:firebase_auth_template/widgets/wave.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String password;
  String displayName;
  String email;
  bool showSpinner = false;
  SharedPreferences prefs;

  setPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Stack(children: <Widget>[
          Container(
            height: size.height - 200,
            color: Colors.blueAccent,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: Wave(
              size: size,
              yOffset: size.height / 3.0,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: keyboardOpen ? 0.0 : 100.0,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                  ),
                  Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: keyboardOpen ? 0.0 : 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ]),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    displayName = value;
                  },
                  decoration: kInputDecoration.copyWith(
                      hintText: 'Enter your display name'),
                ),
                TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kInputDecoration.copyWith(
                        hintText: 'Enter your email')),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kInputDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  title: 'Register',
                  color: Colors.blueAccent,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        var firebaseUser = _auth.currentUser;
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(firebaseUser.uid)
                            .set({
                          'nickname': displayName,
                          'id': firebaseUser.uid,
                          'createdAt':
                              DateTime.now().millisecondsSinceEpoch.toString()
                        });
                        prefs = await SharedPreferences.getInstance();
                        // Write data to local
                        var currentUser = firebaseUser;
                        print(currentUser);
                        await prefs.setString('id', currentUser.uid);
                        await prefs.setString('nickname', displayName);
                        Fluttertoast.showToast(msg: "Registration success");
                        setState(() {
                          showSpinner = false;
                        });
                        Navigator.pushNamed(context, HomeScreen.id);
                      }
                    } catch (e) {
                      Fluttertoast.showToast(msg: "Registration failed");
                      setState(() {
                        showSpinner = false;
                      });
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
