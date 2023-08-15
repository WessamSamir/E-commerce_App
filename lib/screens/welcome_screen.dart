import 'package:flutter_demo/screens/login.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    final currentWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 40,),
                // Text(
                //     'App Name'
                // ),
                Image.asset('assets/images/online_shopping.png'),
                Text(
                  'Welcome to our application...',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15,),
                Text(
                  'Discover new local products, easy shopping, safe payment',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40,),
                Container(
                  width: currentWidth * 0.6,
                  height: currentHeight * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      'Get Started',
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
                                side: BorderSide(color: Colors.white)))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
