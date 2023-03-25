// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'subs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void subscription(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return show_subscription();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Lottie.network(
            'https://assets3.lottiefiles.com/packages/lf20_WKdnG2.json',
            repeat: false),
        Text(
          "Name : ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Gender : ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Email : ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal[700],
            onPrimary: Colors.white,
          ),
          child: Text('SHOW SUBSCRIPTIONS'),
          onPressed: () => subscription(context),
        ),
      ],
    ));
  }
}
