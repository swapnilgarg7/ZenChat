import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zenchat/pages/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(milliseconds: 2500), (() async {
      Navigator.pushReplacementNamed(context, MainScreen.routeName);
    }));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return Scaffold(
      body: Container(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Text(
              'ZenChat',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 60,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
