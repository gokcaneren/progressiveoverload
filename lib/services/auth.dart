import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:progressive_overload/constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (user.user!.emailVerified) {
      return user.user;
    } else {
      return null;
    }
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> createPerson(
      String userName, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore.collection("Person").doc(user.user!.uid).set({
      'userName': userName,
      'email': email,
      'bench': 20,
      'benchGoal': 20,
      'bbPress': 20,
      'bbPressGoal': 20,
      'deadlift': 20,
      'deadliftGoal': 20,
      'bbRow': 20,
      'bbRowGoal': 20,
      'squat': 20,
      'squatGoal': 20,
      'height': 0,
      'weight': 0,
    });

    try {
      await user.user?.sendEmailVerification();
      return user.user;
    } catch (e) {
      print("An error occured while trying to send email verification");
      print(e);
    }

  }
  
  

}
