// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zenchat/Helper/sharedPreference.dart';
import 'package:zenchat/pages/loginPage.dart';
import 'package:zenchat/pages/registerPage.dart';
import 'package:zenchat/pages/reset_password.dart';
import 'package:zenchat/services/authService.dart';
import 'package:zenchat/services/databaseService.dart';
import 'package:path_provider/path_provider.dart';
import 'subs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // function to get subscription
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
  File? _imageFile;
  final picker = ImagePicker();
  bool _isanonymous = false;
  AuthService authService = AuthService();

  // function to show the bottom sheet dialog for changing or removing image
  Future<void> _showOptionsDialog() async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Change Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  final PickedFile =
                      await picker.getImage(source: ImageSource.gallery);
                  if (PickedFile != null) {
                    setState(() {
                      _imageFile = File(PickedFile.path);
                    });

                    // Save the image to the documents directory
                    final directory = await getApplicationDocumentsDirectory();
                    final imagePath = '${directory.path}/profile_image.jpg';
                    await _imageFile!.copy(imagePath);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Remove Photo'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _imageFile = null;
                  });
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // call the gettingUserData function to fetch user data
    gettingUserData();
    _loadImage();
  }

  // function to upload the image
  Future<void> _loadImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/profile_image.jpg';
    final imageFile = File(imagePath);
    if (imageFile.existsSync()) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  // function to get the user data
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
                              title: const Text("Get Registered"),
                              content: const Text("Are you sure to register?"),
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
                      "Get Registered",
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
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                _showOptionsDialog();
              },
              child: Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : AssetImage('assets/profile.png')
                          as ImageProvider<Object>,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [
                        Text(
                          '$name',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Gender: $gender',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Email: $email',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
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
