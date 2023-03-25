import 'package:firebase_auth/firebase_auth.dart';
import 'package:zenchat/Helper/sharedPreference.dart';
import 'package:zenchat/services/databaseService.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future loginInUserWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // register
  Future registerUserWithEmailAndPassword(String name, String email,
      String password, String gender, DateTime time) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        // call our database service to update the user data
        DataBaseService(uid: user.uid)
            .updateUserData(name, email, gender, time);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // sign out
  Future signOut() async {
    try {
      await SharedPreferenceFucntion.saveUserLoggedInStatus(false);
      await SharedPreferenceFucntion.saveUserEmailSF("");
      await SharedPreferenceFucntion.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

  // reset the password
  Future resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else {
        return 'An error occurred while resetting password. Please try again later.';
      }
    } catch (e) {
      return 'An error occurred while resetting password. Please try again later.';
    }
  }
}
