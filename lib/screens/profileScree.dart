import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  ProfileScreen({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: data['name'],
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              initialValue: data['email'],
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            // Add more text form fields to display other profile data as needed
          ],
        ),
      ),
    );
  }
}