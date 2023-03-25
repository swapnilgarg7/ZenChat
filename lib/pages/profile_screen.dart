// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          });
        } else {
          // user data not found, set default values
          setState(() {
            name = "Anonymous";
            email = userEmail;
            gender = "Unknown";
          });
        }
      }
    } catch (e) {
      // Error occured while fetching the data
      setState(() {
        name = "Anonymous";
        email = "UnknownEmail@anonymous.com";
        gender = "unknown";
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
          children: <Widget>[],
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
              color: Theme.of(context).accentColor,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
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
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Gender: $gender',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Email: $email',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: Colors.grey[700],
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
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal[700],
                onPrimary: Colors.white,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () => subscription(context),
              child: const Text(
                "Go Premium Now!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
