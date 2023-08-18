import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/account.dart';
import 'package:flutter_demo/screens/initial_page.dart';
import 'package:flutter_demo/screens/login.dart';
import 'package:flutter_demo/screens/sign.dart';
import 'package:flutter_demo/screens/sign_up.dart';
import 'package:flutter_demo/screens/welcome_screen.dart';
import 'package:flutter_demo/services/fireStore.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const myApp(),
  );
}


class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}





