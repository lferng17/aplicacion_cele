import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/student_model.dart';

class Question01Pendon extends StatefulWidget {
  const Question01Pendon({Key? key}) : super(key: key);

  @override
  _Question01PendonState createState() => _Question01PendonState();
}

class _Question01PendonState extends State<Question01Pendon> {
  // user
  StudentModel loggedInStudent = StudentModel();


  @override
  void initState() {
    super.initState();
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection('students')
          .doc(currentUser.email)
          .get()
          .then((value) {
        setState(() {
          loggedInStudent = StudentModel.fromMap(value.data());
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta 01/05'),
        centerTitle: true,
        backgroundColor: Colors.green[600],
      ),
      body: Container(
        
      ),
    );
  }

}
