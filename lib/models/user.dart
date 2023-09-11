import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String profilePhoto;
  String email;
  String uid;

  User({required this.name, required this.profilePhoto, required this.uid, required this.email});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'profilePhoto': profilePhoto,
      'email': email,
      'uid': uid,
    };
  }

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      name: snapshot['name'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      email: snapshot['email'],
    );
  }
}
