import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_demo/screens/Initial_page.dart';
import 'package:flutter_demo/screens/home.dart';
import 'package:flutter_demo/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/profile.dart';
import 'package:flutter_demo/services/fireStore.dart';
import '../constants.dart';
import '../models/Personal_info.dart';
import '../models/Users.dart';
import '../widgets/CustemTextFormField.dart';
import 'package:flutter_demo/services/auth.dart';
import 'package:flutter_demo/services/store.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String? _email, _password, _confirmPass, _name, _phone;
  final _auth = Auth();
  final _store = Store();
  // Person_info person=Person_info("Loay Mohamed", "01121510042", "looay432@gmail.com","2001369105694");
  // // late Person_info person;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPpasswordController = TextEditingController();

  void _signUp(BuildContext context) {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;

    // Get other sign-up field values as needed

    FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'email': email,
      'phone' : phone,
      'password': password,
      // Add other sign-up field values to be stored in Firestore as needed
    }).then((value) {
      // Navigate to the profile screen after successful sign-up
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => InitialPage(userId: value.id)),
      // );
    }).catchError((error) {
      // Handle sign-up error
      print('Error signing up: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.width;

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
                    height: 60,
                  ),
                  Text(
                    'Create new account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: KMainColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'please fill the form to continue...',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomTextFormField(
                    hint: 'Full Name',
                    icon: Icons.person,
                    onClick: (value) {
                      _name = value!;
                    }, controller: _nameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hint: 'Phone Number',
                    icon: Icons.phone,
                    inputType: TextInputType.phone,
                    onClick: (value) {
                      _phone = value!;
                    }, controller: _phoneController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hint: 'Email Address',
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    onClick: (value) {
                      _email = value!;
                    }, controller: _emailController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hint: 'Password',
                    icon: Icons.lock,
                    secure: true,
                    onClick: (value) {
                      _password = value!;
                    }, controller: _passwordController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hint: 'Confirm Password',
                    icon: Icons.lock,
                    secure: true,
                    onClick: (value) {
                      _confirmPass = value!;
                    }, controller: _confirmPpasswordController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: currentWidth * 0.6,
                    height: currentHeight * 0.13,
                    child: Builder(builder: (context) {
                      return ElevatedButton(
                        onPressed: () async {
                          if (_globalKey.currentState!.validate()) {
                            if (_password == _confirmPass) {
                              print("on buttun");
                              try {
                                _globalKey.currentState!.save();

                                final authResult =
                                    await _auth.SignUp(_email!, _password!);
                                Fluttertoast.showToast(
                                    msg: "Registered Successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: KMainColor,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                _signUp(context);
                                // _store.addUser(Users(
                                //     name: _name,
                                //     phone: _phone,
                                //     email: _email,
                                //     password: _password));
                                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile(userId: userId)));
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: KMainColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                    ),
                                    content: Text(
                                      e.toString(),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              print('error');
                            }
                            // print(_email);
                            // print(_password);
                            // print(_confirmPass);
                          }
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(KMainColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                    side: BorderSide(color: Colors.white)))),
                      );
                    }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an Account?',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          'Sign in',
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
