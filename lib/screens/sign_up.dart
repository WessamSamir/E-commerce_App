import 'package:flutter/services.dart';
import 'package:flutter_demo/screens/login.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/CustemTextFormField.dart';
import 'package:flutter_demo/services/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String? _email, _password, _confirmPass, _name, _phone;
  final _auth = Auth();
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
                  SizedBox(
                    height: 50,
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
                      _name = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hint: 'Phone Number',
                    icon: Icons.phone,
                    inputType: TextInputType.phone,
                    onClick: (value) {
                      _phone = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hint: 'Email Address',
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    onClick: (value) {
                      _email = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hint: 'Password',
                    icon: Icons.lock,
                    secure: true,
                    onClick: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hint: 'Confirm Password',
                    icon: Icons.lock,
                    secure: true,
                    onClick: (value) {
                      _confirmPass = value;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: currentWidth * 0.6,
                    height: currentHeight * 0.13,
                    child: Builder(
                      builder: (context) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (_globalKey.currentState!.validate()) {
                              if (_password == _confirmPass) {
                                try {
                                  _globalKey.currentState!.save();
                                  final authResult =
                                      await _auth.SignUp(_email!, _password!);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: KMainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(24.0),
                                          side: BorderSide(color: Colors.white)))),
                        );
                      }
                    ),
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
