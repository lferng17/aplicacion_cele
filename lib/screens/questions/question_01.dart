import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_cele/screens/waitingPage.dart';

import '../../models/student_model.dart';

class Question01 extends StatefulWidget {
  const Question01({Key? key}) : super(key: key);

  @override
  _Question01State createState() => _Question01State();

}

class _Question01State extends State<Question01> {


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
        title: Text('Pregunta 01'),
      ),
      body: Center(
        child: Text(
          'Bienvenido: ',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
  
 
  
}