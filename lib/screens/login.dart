import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/screens/sign_up.dart';

import '../services/auth.dart';
import '../widgets/CustemTextFormField.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool value = false;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late String email = '', password = '';
  final _auth = Auth();
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
                    },
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
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: currentWidth * 0.6,
                    height: currentHeight * 0.06,
                    child: ElevatedButton(
                      onPressed: () async
                      {
                        if(_globalKey.currentState!.validate())
                        {
                          _globalKey.currentState?.save();
                          final authResult = await _auth.SignIn(email, password);
                        }
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

