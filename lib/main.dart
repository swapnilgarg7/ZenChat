import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zenchat/Helper/sharedPreference.dart';
import 'package:zenchat/pages/loginPage.dart';
import 'pages/main_screen.dart';
import 'pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool _isSignIn = false;
  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await SharedPreferenceFucntion.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZenChat',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.teal[700],
        accentColor: Colors.teal[50],
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          splash: Image.asset('assets/ZenChatLogo.png'),
          duration: 2000,
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: 200,
          backgroundColor: const Color(0xFF9EE3D6),
          nextScreen: _isSignIn ? const MainScreen() : const LoginPage()),
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
      },
    );
  }
}
