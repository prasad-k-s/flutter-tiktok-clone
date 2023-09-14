import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  // ignore: prefer_typing_uninitialized_variables
  final datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;
  Comment({
    required this.username,
    required this.datePublished,
    required this.comment,
    required this.id,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': comment,
        'datePublished': datePublished,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'id': id,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      username: snapshot['username'],
      comment: snapshot['comment'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      id: snapshot['id'],
    );
  }
}
