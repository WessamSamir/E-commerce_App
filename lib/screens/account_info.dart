import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: ()
          {
            print("clicked");
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.cyan,
          ),
        ),
        actions:
        [
          IconButton(
            onPressed: () {
              print('clicked');
            },
            icon: Icon(
              Icons.settings,
              color: Colors.cyan,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          backgroundColor: KMainColor,
                          radius: 60.0,
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.white,
                          ),
                          // backgroundImage: AssetImage(
                          //     'images/image.jpg'
                          // ),

                        ),
                        CircleAvatar(
                          backgroundColor: Colors.cyan,
                          radius: 20.0,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.remove_red_eye),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Location',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (){},
                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.white)
                                  )
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (){},
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Colors.cyan),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  )
                              )
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
