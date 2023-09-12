// COLORS
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktok_clone/controllers/auth_controllers.dart';
import 'package:flutter_tiktok_clone/views/screens/add_screen.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
const whiteColor = Colors.white;
const blueColor = Colors.blue;

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

var authController = AuthController.instance;

const pages = [
  Text('Home'),
  Text('Search'),
  AddVideoScreen(),
  Text('Message'),
  Text('Profile'),
];
