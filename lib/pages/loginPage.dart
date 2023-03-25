import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenchat/pages/registerPage.dart';
import '../Helper/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  String email = "";
  String password = "";
  bool _isLoading = false;
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Colors.teal[700],
                    child: Center(
                      // image to be add
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/LogoLogin.png"),
                              fit: BoxFit.scaleDown),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 18),
                            Text(
                              "Login",
                              style: GoogleFonts.merriweather(
                                textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.1,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                'Sign in to continue',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.teal[300],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Email
                            TextFormField(
                              controller: _emailTextController,
                              validator: (value) => Validator.validateEmail(
                                  email: _emailTextController.text),
                              decoration: InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1.0,
                                  ),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                            ),
                            const SizedBox(height: 15),
                            // Password
                            TextFormField(
                              controller: _passwordTextController,
                              validator: (value) => Validator.validatePassword(
                                  password: _passwordTextController.text),
                              obscureText: passwordVisible,
                              decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(
                                  Icons.password_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(passwordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined),
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  color: Theme.of(context).primaryColor,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1.0,
                                  ),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                            SizedBox(height: 18),
                            // Log in button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Log in",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            // Anonymous option
                            const SizedBox(height: 13),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Go Anonymous",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            // forget password option
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forget Password ?",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 13),
                            // Register the account
                            const SizedBox(
                              height: 10,
                            ),
                            Text.rich(
                              TextSpan(
                                  text: "Don't have an account? ",
                                  style: const TextStyle(
                                      color: Colors.teal, fontSize: 14),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "Register here",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegisterPage(),
                                              ),
                                            );
                                          })
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
