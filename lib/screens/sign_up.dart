// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:flutter_demo/screens/login.dart';
// import '../constants.dart';
// import 'package:flutter_demo/services/auth.dart';
// import 'package:flutter_demo/services/store.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:image_picker/image_picker.dart';
//
// class SignUp extends StatefulWidget {
//   const SignUp({super.key});
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
//   String? _email, _password, _confirmPass, _name, _phone;
//   final _auth = Auth();
//   final _store = Store();
//   double screenWidth = 0;
//
//   IconData pass_eye = MdiIcons.eyeLock;
//   bool eye_pressed = false;
//   String pass = "*********";
//   Color save_changes = const Color.fromRGBO(1, 70, 66, 1.0);
//
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPpasswordController = TextEditingController();
//
//   void _signUp(BuildContext context) {
//     String name = _nameController.text;
//     String email = _emailController.text;
//     String phone = _phoneController.text;
//     String password = _passwordController.text;
//
//     FirebaseFirestore.instance.collection('users').add({
//       'name': name,
//       'email': email,
//       'phone' : phone,
//       'password': password,
//       // Add other sign-up field values to be stored in Firestore as needed
//     }).then((value) {
//       // Navigate to the profile screen after successful sign-up
//       // Navigator.pushReplacement(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => InitialPage(userId: value.id)),
//       // );
//     }).catchError((error) {
//       // Handle sign-up error
//       print('Error signing up: $error');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final currentWidth = MediaQuery.of(context).size.width;
//     final currentHeight = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       body: Form(
//         key: _globalKey,
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 60,
//                   ),
//                   Text(
//                     'Create new account',
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: KMainColor,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   Text(
//                     'please fill the form to continue...',
//                     style: TextStyle(
//                       color: Colors.grey,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius:
//                       BorderRadius.circular(screenWidth * 0.05),
//                       color: Colors.black12,
//                     ),
//                     child: TextField(
//                       controller: _nameController,
//                       // onSaved: (value) {
//                       //   _name = value!;
//                       // },
//                       decoration: InputDecoration(
//                           enabledBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Color.fromRGBO(1, 126, 120, 1.0),
//                                 width: 2),
//                             borderRadius:
//                             BorderRadius.circular(screenWidth * 0.05),
//                           ),
//                           hintText: 'Full Name',
//                           hintStyle: TextStyle(
//                             overflow: TextOverflow.fade,
//                             fontFamily: 'Amperzand',
//                             fontSize: screenWidth * 0.05,
//                             color: Colors.white,
//                           ),
//                           labelText: "user name",
//                           labelStyle: TextStyle(
//                             fontSize: screenWidth * 0.06,
//                             fontFamily: "Sweety",
//                           ),
//                           prefixIcon: const Icon(
//                             FontAwesomeIcons.userCircle,
//                             color: Colors.black,
//                           )),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius:
//                       BorderRadius.circular(screenWidth * 0.05),
//                       color: Colors.black12,
//                     ),
//                     child: TextFormField(
//                       controller: _phoneController,
//                       onSaved: (value) {
//                         _phone = value!;
//                       },
//                       decoration: InputDecoration(
//                           enabledBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Color.fromRGBO(1, 126, 120, 1.0),
//                                 width: 2),
//                             borderRadius:
//                             BorderRadius.circular(screenWidth * 0.05),
//                           ),
//                           hintText: 'Phone',
//                           hintStyle: TextStyle(
//                             overflow: TextOverflow.fade,
//                             fontFamily: 'Amperzand',
//                             fontSize: screenWidth * 0.05,
//                             color: Colors.white,
//                           ),
//                           labelText: "phone number",
//                           labelStyle: TextStyle(
//                             fontSize: screenWidth * 0.06,
//                             fontFamily: "Sweety",
//                           ),
//                           prefixIcon: const Icon(
//                             FontAwesomeIcons.phoneVolume,
//                             color: Colors.black,
//                           )),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius:
//                       BorderRadius.circular(screenWidth * 0.05),
//                       color: Colors.black12,
//                     ),
//                     child: TextFormField(
//                       controller: _emailController,
//                       onSaved: (value) {
//                         _email = value!;
//                       },
//                       decoration: InputDecoration(
//                           enabledBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Color.fromRGBO(1, 126, 120, 1.0),
//                                 width: 2),
//                             borderRadius:
//                             BorderRadius.circular(screenWidth * 0.05),
//                           ),
//                           hintText: 'Email',
//                           hintStyle: TextStyle(
//                             overflow: TextOverflow.fade,
//                             fontFamily: 'Amperzand',
//                             fontSize: screenWidth * 0.05,
//                             color: Colors.white,
//                           ),
//                           labelText: "Email",
//                           labelStyle: TextStyle(
//                             fontSize: screenWidth * 0.06,
//                             fontFamily: "Sweety",
//                           ),
//                           prefixIcon: Icon(
//                             MdiIcons.emailBox,
//                             color: Colors.black,
//                           )),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius:
//                       BorderRadius.circular(screenWidth * 0.05),
//                       color: Colors.black12,
//                     ),
//                     child: TextFormField(
//                       controller: _passwordController,
//                       onSaved: (value) {
//                         _password = value!;
//                       },
//                       decoration: InputDecoration(
//                           enabledBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Color.fromRGBO(1, 126, 120, 1.0),
//                                 width: 2),
//                             borderRadius:
//                             BorderRadius.circular(screenWidth * 0.05),
//                           ),
//                           hintText: 'Password',
//                           hintStyle: TextStyle(
//                             overflow: TextOverflow.fade,
//                             fontFamily: 'Amperzand',
//                             fontSize: screenWidth * 0.05,
//                             color: Colors.white,
//                           ),
//                           labelText: "Password",
//                           labelStyle: TextStyle(
//                             fontSize: screenWidth * 0.06,
//                             fontFamily: "Sweety",
//                           ),
//                           prefixIcon: const Icon(
//                             Icons.password_sharp,
//                             color: Colors.black,
//                           ),
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               // setState(() {
//                               //   eye_pressed = !eye_pressed;
//                               //   pass_eye = eye_pressed
//                               //       ? MdiIcons.eyeCheck
//                               //       : MdiIcons.eyeLock;
//                               //   pass = eye_pressed
//                               //       ? data["password"]
//                               //       : "*********";
//                               // });
//                             },
//                             icon: Icon(pass_eye),
//                           )),
//                       obscureText: true,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius:
//                       BorderRadius.circular(screenWidth * 0.05),
//                       color: Colors.black12,
//                     ),
//                     child: TextFormField(
//                       controller: _confirmPpasswordController,
//                       onSaved: (value) {
//                         _confirmPass = value!;
//                       },
//                       decoration: InputDecoration(
//                           enabledBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.transparent,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Color.fromRGBO(1, 126, 120, 1.0),
//                                 width: 2),
//                             borderRadius:
//                             BorderRadius.circular(screenWidth * 0.05),
//                           ),
//                           hintText: 'Confirm Password',
//                           hintStyle: TextStyle(
//                             overflow: TextOverflow.fade,
//                             fontFamily: 'Amperzand',
//                             fontSize: screenWidth * 0.05,
//                             color: Colors.white,
//                           ),
//                           labelText: "Password",
//                           labelStyle: TextStyle(
//                             fontSize: screenWidth * 0.06,
//                             fontFamily: "Sweety",
//                           ),
//                           prefixIcon: const Icon(
//                             Icons.password_sharp,
//                             color: Colors.black,
//                           ),
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               // setState(() {
//                               //   eye_pressed = !eye_pressed;
//                               //   pass_eye = eye_pressed
//                               //       ? MdiIcons.eyeCheck
//                               //       : MdiIcons.eyeLock;
//                               //   pass = eye_pressed
//                               //       ? data["password"]
//                               //       : "*********";
//                               // });
//                             },
//                             icon: Icon(pass_eye),
//                           )),
//                       obscureText: true,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     width: currentWidth * 0.6,
//                     height: currentHeight * 0.13,
//                     child: Builder(builder: (context) {
//                       return ElevatedButton(
//                         onPressed: () async {
//                           if (_globalKey.currentState!.validate()) {
//                             if (_password == _confirmPass) {
//
//                               try {
//                                 _globalKey.currentState!.save();
//                                 print("on buttun");
//                                 final authResult =
//                                     await _auth.SignUp(_email!, _password!);
//                                 Fluttertoast.showToast(
//                                     msg: "Registered Successfully",
//                                     toastLength: Toast.LENGTH_SHORT,
//                                     gravity: ToastGravity.TOP,
//                                     timeInSecForIosWeb: 1,
//                                     backgroundColor: KMainColor,
//                                     textColor: Colors.white,
//                                     fontSize: 16.0);
//                                 _signUp(context);
//                                 // _store.addUser(Users(
//                                 //     name: _name,
//                                 //     phone: _phone,
//                                 //     email: _email,
//                                 //     password: _password));
//                                 // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile(userId: userId)));
//                               } catch (e) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     backgroundColor: KMainColor,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(20),
//                                           topRight: Radius.circular(20)),
//                                     ),
//                                     content: Text(
//                                       e.toString(),
//                                     ),
//                                   ),
//                                 );
//                               }
//                             } else {
//                               print('error');
//                             }
//                             // print(_email);
//                             // print(_password);
//                             // print(_confirmPass);
//                           }
//                         },
//                         child: Text(
//                           'Register',
//                           style: TextStyle(
//                             fontSize: 20,
//                           ),
//                         ),
//                         style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStatePropertyAll<Color>(KMainColor),
//                             shape: MaterialStateProperty.all<
//                                     RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(24.0),
//                                     side: BorderSide(color: Colors.white)))),
//                       );
//                     }),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Have an Account?',
//                         style: TextStyle(fontSize: 15),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).push(
//                               MaterialPageRoute(builder: (context) => Login()));
//                         },
//                         child: Text(
//                           'Sign in',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: KMainColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_demo/screens/Initial_page.dart';
import 'package:flutter_demo/screens/home.dart';
import 'package:flutter_demo/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/profile.dart';
import 'package:flutter_demo/services/fireStore.dart';
import '../constants.dart';
import '../models/Products.dart';
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
  final List<Products> cartProduct = [];
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
      // 'cartProduct': [],
      // 'favProduct': [],
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
