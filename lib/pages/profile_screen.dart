// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
        Text('Profile Screen'),
        // Image(image: image, width: 75, height: 75),
        Text('Name'),
        Text('Gender'),
        Text('Email'),
        ElevatedButton(
          child: Text('SHOW SUBSCRIPTIONS'),
          onPressed: () => subscription(context),
        ),
      ],
    ));
  }
}
