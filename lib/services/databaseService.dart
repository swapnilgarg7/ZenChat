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
      "profilePic": "",
      "uid": uid,
    });
  }

  // updating the user's profile picture url
  Future updateProfilePicture(String email, String imageUrl) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = snapshot.docs.first;
      return await userCollection.doc(documentSnapshot.id).update({
        "profilePic": imageUrl,
      });
    } else {
      throw Exception("User not found");
    }
  }

  // getting the user's profile picture url from email
  Future<String?> getUserProfilePictureFromEmail(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = snapshot.docs.first;
      return documentSnapshot.get("profilePic");
    } else {
      return null;
    }
  }

  // remove the image
  Future<void> removeProfilePictureByEmail(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = snapshot.docs.first;
      return await userCollection.doc(documentSnapshot.id).update({
        "profilePic": FieldValue.delete(),
      });
    } else {
      throw Exception("User not found");
    }
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // getting the gender using email id
  Future<String?> getGenderFromEmail(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = snapshot.docs.first;
      return documentSnapshot.get("gender");
    } else {
      return null;
    }
  }
}
