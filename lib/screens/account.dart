import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/services/store.dart';
import 'package:flutter_demo/models/Users.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  late final Store userData;
  late final Users user;
  String? name;

  Future _getDataFromDatabase() async
  {
    await userData.userCollection.doc(FirebaseAuth.instance.currentUser?.uid)
        .get().then((snapshot)async
        {
          if(snapshot.exists)
            {
              setState(() {
                // user.name = snapshot.data()!["name"];
              });
            }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            // initialValue: user.name,
          ),
          TextFormField(
            // initialValue: user.phone,
          ),
          TextFormField(
            // initialValue: user.email,
          ),
          TextFormField(
            // initialValue: user.password,
          ),

          // StreamBuilder(
          //     stream: userData.userCollection.snapshots(),
          //     builder: (context, snapshot){
          //       List<Row> userWidgets = [];
          //       if(snapshot.hasData)
          //         {
          //           final users = snapshot.data?.docs.reversed.toList();
          //           for(var user in users!)
          //             {
          //               final userWidget = Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(user["name"]),
          //                   Text(user["phone"]),
          //                   Text(user["email"]),
          //                   Text(user["password"]),
          //                 ],
          //               );
          //               userWidgets.add(userWidget);
          //             }
          //         }
          //       // return Expanded(
          //       //     child: ListView(
          //       //       children: userWidgets,
          //       //     )
          //       // );
          //     }
          // ),
        ],
      ),
    );
  }
}
