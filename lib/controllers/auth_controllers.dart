import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_tiktok_clone/constants.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage.ref().child('profilePics').child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void register(String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image != null) {}

      UserCredential credential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    String downloadUrl=  await _uploadToStorage(image!);
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
  }
}
