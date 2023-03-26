import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenchat/Helper/sharedPreference.dart';
import 'package:zenchat/pages/loginPage.dart';
import 'package:intl/intl.dart';
import 'package:zenchat/pages/main_screen.dart';
import 'package:zenchat/services/authService.dart';
import 'package:zenchat/widget/snackbar.dart';
import '../Helper/validator.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formkey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  String name = "";
  String email = "";
  String password = "";
  String gender = "Male";
  late DateTime _selectedDate;
  bool _isLoading = false;
  bool passwordVisible = true;
  var genderOptions = ['Male', 'Female', 'Others'];
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 100,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ))
          : SingleChildScrollView(
              child: Column(
                children: [
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
                            const SizedBox(height: 5),
                            Center(
                              child: Text(
                                "Create new Account",
                                style: GoogleFonts.merriweather(
                                  textStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width * 0.1,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Register the account
                            const SizedBox(
                              height: 10,
                            ),
                            Text.rich(
                              TextSpan(
                                  text: "Already Registered? ",
                                  style: const TextStyle(
                                      color: Colors.teal, fontSize: 14),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "Login in here",
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
                                                    const LoginPage(),
                                              ),
                                            );
                                          })
                                  ]),
                            ),
                            const SizedBox(height: 12),
                            // Name
                            TextFormField(
                              controller: _nameTextController,
                              validator: (value) => Validator.validateName(
                                  name: _nameTextController.text),
                              decoration: InputDecoration(
                                hintText: "Full Name",
                                prefixIcon: Icon(
                                  Icons.person_outline,
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
                                  name = val;
                                });
                              },
                            ),
                            const SizedBox(height: 15),
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
                            const SizedBox(height: 15),
                            // Gender
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                prefixIcon: Icon(
                                  Icons.transgender_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              value: gender,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              items: genderOptions.map((String genderOptions) {
                                return DropdownMenuItem(
                                  value: genderOptions,
                                  child: Text(genderOptions),
                                );
                              }).toList(),
                              onChanged: ((String? newValue) {
                                setState(() {
                                  gender = newValue!;
                                });
                              }),
                            ),
                            const SizedBox(height: 15),
                            // Date of Birth
                            DateTimeField(
                              decoration: InputDecoration(
                                labelText: 'Date of Birth',
                                prefixIcon: Icon(
                                  Icons.date_range_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              format: DateFormat('yyyy-MM-dd'),
                              onShowPicker: (context, currentValue) async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: currentValue ?? DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (date != null) {
                                  _selectedDate = date;
                                }
                                return date;
                              },
                              onChanged: (value) {
                                _selectedDate = value!;
                              },
                              onSaved: (value) {
                                _selectedDate = value!;
                              },
                            ),
                            const SizedBox(height: 25),
                            // Register button
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
                                onPressed: () {
                                  register();
                                },
                                child: const Text(
                                  "Sign up",
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
                    ),
                  )
                ],
              ),
            ),
    );
  }

  // register
  register() async {
    name = name[0].toUpperCase() + name.substring(1);
    if (formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailAndPassword(
              name, email, password, gender, _selectedDate)
          .then((value) async {
        if (value == true) {
          // saving the shared prefernce data
          await SharedPreferenceFucntion.saveUserLoggedInStatus(true);
          await SharedPreferenceFucntion.saveUserEmailSF(email);
          await SharedPreferenceFucntion.saveUserNameSF(name);

          // move to main screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );

          _emailTextController.clear();
          _nameTextController.clear();
          _passwordTextController.clear();
        } else {
          showSnackbar(context, Colors.redAccent, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
