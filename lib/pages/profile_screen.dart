// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zenchat/Helper/sharedPreference.dart';
import 'package:zenchat/pages/loginPage.dart';
import 'package:zenchat/pages/registerPage.dart';
import 'package:zenchat/pages/reset_password.dart';
import 'package:zenchat/services/authService.dart';
import 'package:zenchat/services/databaseService.dart';
import 'package:lottie/lottie.dart';
import 'package:zenchat/Helper/sharedPreference.dart';
import 'package:zenchat/services/databaseService.dart';
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

  String name = "";
  String email = "";
  String gender = "";
  bool _isLoading = false;

  bool _isanonymous = false;
  AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // call the gettingUserData function to fetch user data
    gettingUserData();
  }

  Future<void> gettingUserData() async {
    // show loading indicator while fetching data
    setState(() {
      _isLoading = true;
    });

    try {
      // fetch the user email from shared preferences
      String? userEmail = await SharedPreferenceFucntion.getUserEmailFromSF();
      if (userEmail == null) {
        // user email not found

        email = "UnknonwnEmail@anonymous.com";
      } else {
        // user email found, fetch user data from database
        QuerySnapshot userData =
            await DataBaseService().gettingUserData(userEmail);
        if (userData.docs.isNotEmpty) {
          // user data found
          setState(() {
            name = userData.docs[0]['fullName'];
            email = userData.docs[0]['email'];
            gender = userData.docs[0]['gender'];

            _isanonymous = false;
          });
        } else {
          // user data not found, set default values
          setState(() {
            name = "Anonymous";
            email = userEmail;
            gender = "Unknown";

            _isanonymous = false;
          });
        }
      }
    } catch (e) {
      // Error occured while fetching the data
      setState(() {
        name = "Anonymous";
        email = "UnknownEmail@anonymous.com";
        gender = "unknown";
        _isanonymous = true;
      });
    } finally {
      // hide loading indicator
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 100,
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            _isanonymous
                ? ListTile(
                    onTap: () async {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Get Register"),
                              content:
                                  const Text("Are you sure to get register?"),
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await authService.signOut();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterPage()),
                                        (route) => false);
                                  },
                                  icon: const Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    leading: const Icon(
                      Icons.person_outline,
                      color: Colors.teal,
                    ),
                    title: const Text(
                      "Get Register",
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListTile(
                    onTap: () async {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Reset Password"),
                              content: const Text(
                                  "Are you sure to reset the password?"),
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await authService.signOut();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ResetPassword()),
                                        (route) => false);
                                  },
                                  icon: const Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    leading: const Icon(
                      Icons.password_rounded,
                      color: Colors.teal,
                    ),
                    title: const Text(
                      "Reset Password",
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("LogOut"),
                        content: const Text("Are you sure to logout?"),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await authService.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    });
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(
                Icons.exit_to_app_outlined,
                color: Colors.teal,
              ),
              title: const Text(
                "Log out",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_WKdnG2.json',
                repeat: false,
                height: 250,
                width: 250),
            Container(
              color: Theme.of(context).primaryColor,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [
                        Text(
                          'Name: $name',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Gender: $gender',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Email: $email',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => subscription(context),
                child: const Text(
                  "Go Premium Now!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
