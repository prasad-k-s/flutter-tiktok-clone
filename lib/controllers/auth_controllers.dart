import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok_clone/constants.dart';
import 'package:flutter_tiktok_clone/models/user.dart' as model;
import 'package:flutter_tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:flutter_tiktok_clone/views/screens/home_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;

  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage.value;
  bool isImagePicked = false;
  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar(
        'Profile Picture',
        'Profile picture selected successfully',
        icon: const Icon(
          Icons.done,
          color: Colors.green,
          size: 35,
        ),
      );
      isImagePicked = true;
      _pickedImage = Rx<File?>(
        File(
          pickedImage.path,
        ),
      );
    } else {
      isImagePicked = false;
      Get.snackbar(
        'Profile Picture',
        'Something went wrong',
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 35,
        ),
      );
    }
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage.ref().child('profilePics').child(
          firebaseAuth.currentUser!.uid,
        );
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void register(String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image != null) {
        UserCredential credential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          profilePhoto: downloadUrl,
          uid: credential.user!.uid,
          email: email,
        );
        await firestore.collection('users').doc(credential.user!.uid).set(user.toJson());
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please enter all the fileds',
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.message!,
      );
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar(
          'Error Logging in',
          'Something went wrong',
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error Logging in',
        e.message!,
      );
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
