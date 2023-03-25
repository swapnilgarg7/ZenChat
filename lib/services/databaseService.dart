import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String? uid;
  DataBaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  // updating the user data
  Future updateUserData(
      String name, String email, String gender, DateTime time) async {
    return await userCollection.doc(uid).set({
      "fullName": name,
      "email": email,
      "gender": gender,
      "dateOfBirth": time,
      "uid": uid,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
