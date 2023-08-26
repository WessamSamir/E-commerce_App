import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/Users.dart';
import 'package:flutter_demo/screens/profile.dart';

class FirestoreExample extends StatefulWidget {

  const FirestoreExample({super.key});

  @override
  _FirestoreExampleState createState() => _FirestoreExampleState();
}

class _FirestoreExampleState extends State<FirestoreExample> {
  CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: data["name"]
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: data["password"]
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
