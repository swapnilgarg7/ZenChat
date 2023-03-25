// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class show_subscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('CHOOSE YOUR PLAN'),
        SizedBox(
          height: 10,
          width: double.infinity,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('400/WEEK'),
            ElevatedButton(
              child: Text('SUBSCRIBE'),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(
          height: 10,
          width: double.infinity,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('1500/MONTH'),
            ElevatedButton(
              child: Text('SUBSCRIBE'),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(
          height: 10,
          width: double.infinity,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('5000/QUARTER'),
            ElevatedButton(
              child: Text('SUBSCRIBE'),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
