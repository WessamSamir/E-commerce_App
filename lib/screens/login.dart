import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/screens/Initial_page.dart';
import 'package:flutter_demo/screens/home.dart';
import 'package:flutter_demo/screens/sign_up.dart';

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

  Future<void> _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (_globalKey.currentState!.validate()) {
      try {
        _globalKey.currentState?.save();
        final authResult = await _auth.SignIn(
            email, password);
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const home()));

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: KMainColor,
            shape: RoundedRectangleBorder(
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
  }

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    final currentWidth = MediaQuery.of(context).size.width;

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
                      )
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextFormField(
                    hint: 'Enter your email',
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    onClick: (value)
                    {
                      email = value!;
                    }, controller: _emailController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextFormField(
                      hint: 'Enter your password',
                      icon: Icons.lock,
                    secure: true,
                    onClick: (value)
                    {
                      password = value!;
                    }, controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: currentWidth * 0.6,
                    height: currentHeight * 0.06,
                    child: Builder(
                      builder: (context) {
                        return ElevatedButton(
                          onPressed: () async
                          {
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
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(KMainColor),
                              shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      side: const BorderSide(color: Colors.white)))),
                        );
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an Account?',
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUp()));
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


