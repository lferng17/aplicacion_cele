import 'dart:ffi';

import 'package:aplicacion_cele/screens/home.dart';
import 'package:aplicacion_cele/screens/questions/pendones/question_01.dart';
import 'package:aplicacion_cele/screens/questions/renubero/question_01.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../models/activity_model.dart';
import '../models/student_model.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({Key? key}) : super(key: key);

  @override
  _WaitingPageState createState() => _WaitingPageState();

}

class _WaitingPageState extends State<WaitingPage> {

  // user
  StudentModel loggedInStudent = StudentModel();

  // activity
  ActivityModel currentActivity = ActivityModel();


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
    Timer(const Duration(seconds: 1), () {
      // Navegar a otra página después de 1 segundo
      redirectToQuestion(context); // Cambia el número de pregunta según sea necesario
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );
  }

  Future<void> redirectToQuestion(BuildContext context) async {
  try {
    //Del código introducido, sacar el string questions de la base de datos
    String activityCode = loggedInStudent.activityCode.toString();
    DocumentSnapshot activitySnapshot = await FirebaseFirestore.instance
        .collection('activities')
        .doc(activityCode)
        .get();
    setState(() {
      currentActivity = ActivityModel.fromMap(activitySnapshot.data());
    });
    if (currentActivity.questions != "") {
      // Redirige a la clase correspondiente según el tema de la pregunta
      String questionClassName = currentActivity.questions.toString();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => getQuestionClass(questionClassName)),
      );
    } else {
      // La pregunta no se encontró en Firebase
      const AlertDialog(title: Text('La pregunta no existe en Firebase.'));
    }
  } catch (e) {
    const AlertDialog(title: Text('Error al redirigir a la pregunta'));
  }
}

Widget getQuestionClass(String questionClassName) {
  switch (questionClassName) {
    case "renubero":
      return Question01();
    case "pendon":
      return Question01Pendon();
    default:
      return Home();
  }
}



}
