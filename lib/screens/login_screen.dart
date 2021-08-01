import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_template/screens/home_screen.dart';
import 'package:firebase_auth_template/widgets/rounded_button.dart';
import 'package:firebase_auth_template/widgets/wave.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String password;
  String email;
  bool showSpinner = false;
  SharedPreferences prefs;

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
                    'Login',
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
                  title: 'Login',
                  color: Colors.blueAccent,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        prefs = await SharedPreferences.getInstance();
                        var firebaseUser = _auth.currentUser;
                        final QuerySnapshot result = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .where('id', isEqualTo: firebaseUser.uid)
                            .get();
                        final List<DocumentSnapshot> documents = result.docs;
                        final Map<String, dynamic> userData =
                            documents.last.data();
                        await prefs.setString('id', userData['id']);
                        await prefs.setString(
                          'nickname',
                          userData['nickname'],
                        );
                        // await prefs.setString(
                        //     'aboutMe', documents[0].data()['aboutMe']);
                        Navigator.pushNamed(context, HomeScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                      Widget okButton = TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          setState(() {
                            showSpinner = false;
                          });
                          Navigator.pop(context);
                        },
                      );
                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text("Invalid Credentials"),
                        content: Text("Incorrect email or password"),
                        actions: [
                          okButton,
                        ],
                      );
                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                  },
                ),
                RoundedButton(
                  title: 'Login with Google!',
                  color: Colors.lightBlue,
                  onPressed: () async {
                    final googleSignIn = GoogleSignIn();
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await googleSignIn.signIn();
                      if (user != null) {
                        final googleAuth = await user.authentication;

                        final credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth.accessToken,
                          idToken: googleAuth.idToken,
                        );
                        await _auth.signInWithCredential(credential);
                        prefs = await SharedPreferences.getInstance();
                        var firebaseUser = _auth.currentUser;
                        final QuerySnapshot result = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .where('id', isEqualTo: firebaseUser.uid)
                            .get();
                        final List<DocumentSnapshot> documents = result.docs;
                        final Map<String, dynamic> userData =
                            documents.last.data();
                        await prefs.setString('id', userData['id']);
                        await prefs.setString(
                          'nickname',
                          userData['nickname'],
                        );
                        // await prefs.setString(
                        //     'aboutMe', documents[0].data()['aboutMe']);
                        Navigator.pushNamed(context, HomeScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                      Widget okButton = TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          setState(() {
                            showSpinner = false;
                          });
                          Navigator.pop(context);
                        },
                      );
                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text("Invalid Credentials"),
                        content: Text("Incorrect email or password"),
                        actions: [
                          okButton,
                        ],
                      );
                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
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
