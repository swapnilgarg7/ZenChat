import 'package:firebase_auth/firebase_auth.dart';
import 'package:zenchat/services/databaseService.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login

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

  // reset the password
}
