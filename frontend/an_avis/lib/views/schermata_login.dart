import 'dart:developer';

import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class SchermataLogin extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn() async {
    try {
      await _auth.signInAnonymously();
    } catch (e) {
    }
  }   



  Widget build(BuildContext context) {
    
  }

}