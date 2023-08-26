import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/models/Users.dart';
import 'package:flutter_demo/screens/Initial_page.dart';
import 'package:flutter_demo/screens/sign_up.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../services/auth.dart';
import '../widgets/CustemTextFormField.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool value = false;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String email = '', password = '';
  final _auth = Auth();

  IconData pass_eye = MdiIcons.eyeLock;
  bool eye_pressed = false;
  String pass = "*********";
  Color save_changes = const Color.fromRGBO(1, 70, 66, 1.0);

  Future<void> _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (_globalKey.currentState!.validate()) {
      try {
        _globalKey.currentState?.save();
        final authResult = await _auth.SignIn(email, password);
// After successful login, retrieve user profile data from Firestore
        FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .limit(1)
            .get()
            .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            DocumentSnapshot snapshot = querySnapshot.docs.first;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => InitialPage(snapshot: snapshot),
              ),
            );
          } else {
            // Handle user not found or other login error
            print('User not found');
          }
        }).catchError((error) {
          // Handle login error
          print('Error logging in: $error');
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: KMainColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Form(
        key: _globalKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const Center(
                      child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: KMainColor,
                    ),
                  )),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      color: Colors.black12,
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(1, 126, 120, 1.0),
                                width: 2),
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.05),
                          ),
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(
                            overflow: TextOverflow.fade,
                            fontFamily: 'Amperzand',
                            fontSize: screenWidth * 0.05,
                            color: Colors.white,
                          ),
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontFamily: "Sweety",
                          ),
                          prefixIcon: Icon(
                            MdiIcons.emailBox,
                            color: Colors.black,
                          )),
                      onSaved: (value) {
                        email = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      color: Colors.black12,
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(1, 126, 120, 1.0),
                                width: 2),
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.05),
                          ),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(
                            overflow: TextOverflow.fade,
                            fontFamily: 'Amperzand',
                            fontSize: screenWidth * 0.05,
                            color: Colors.white,
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontFamily: "Sweety",
                          ),
                          prefixIcon: const Icon(
                            Icons.password_sharp,
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                eye_pressed = !eye_pressed;
                                pass_eye = eye_pressed
                                    ? MdiIcons.eyeCheck
                                    : MdiIcons.eyeLock;
                                pass = eye_pressed ? password : "*********";
                              });
                            },
                            icon: Icon(pass_eye),
                          )),
                      obscureText: true,
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: screenWidth * 0.6,
                    height: currentHeight * 0.06,
                    child: Builder(builder: (context) {
                      return ElevatedButton(
                        onPressed: () async {
                          _login(context);
                          // if(_globalKey.currentState!.validate())
                          // {
                          //   try {
                          //     _globalKey.currentState?.save();
                          //     final authResult = await _auth.SignIn(
                          //         email, password);
                          //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => const home()));
                          //
                          //   }catch(e){
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         backgroundColor: KMainColor,
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                          //         ),
                          //         content: Text(
                          //           e.toString(),
                          //         ),
                          //       ),
                          //     );
                          //   }
                          // }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    KMainColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                    side: const BorderSide(
                                        color: Colors.white)))),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an Account?',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignUp()));
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: KMainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
