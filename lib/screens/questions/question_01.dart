import 'package:aplicacion_cele/screens/questions/question_02.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/student_model.dart';

class Question01 extends StatefulWidget {
  const Question01({Key? key}) : super(key: key);

  @override
  _Question01State createState() => _Question01State();
}

class _Question01State extends State<Question01> {
  // user
  StudentModel loggedInStudent = StudentModel();
  // Pregunta
  String question = 'A Reñubero también le llaman...';
  // Respuestas
  String renubon = 'Renubón';
  String nubero = 'Nubero';
  String renubero = 'Renubero';
  String nubarron = 'Nubarrón';
  String rinobero = 'Riñobero';
  String renueva = 'Renueva';

  List<String> selectedAnswers = [];
  List<String> correctAnswers = ['Nubero', 'Renubero', 'Riñobero'];
  bool showResults = false;
  bool isCorrectionEnabled =
      true; //Variable para bloquear las respuestas despues de corregir

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido: ' + loggedInStudent.alias.toString(),
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              question,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                buildAnswerOption(renubon),
                buildAnswerOption(nubero),
                buildAnswerOption(renubero),
                buildAnswerOption(nubarron),
                buildAnswerOption(rinobero),
                buildAnswerOption(renueva),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showResults = true;
                  isCorrectionEnabled = false; //Bloquear respuestas
                });
              },
              child: Text('Corregir'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Question02(),
                    ),
                  );
                });
              },
              child: Text('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAnswerOption(String answer) {
    bool isSelected = selectedAnswers.contains(answer);
    bool isCorrect = correctAnswers.contains(answer);

    Color borderColor;
    IconData? iconData;

    if (showResults) {
      if (isSelected && isCorrect) {
        borderColor = Colors.green;
        iconData = Icons.check;
      } else if (isSelected && !isCorrect) {
        borderColor = Colors.red;
        iconData = Icons.cancel;
      } else if (!isSelected && isCorrect) {
        borderColor = Colors.green;
      } else {
        borderColor = Colors.black26;
      }
    } else {
      borderColor = isSelected ? Colors.green : Colors.black26;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          onTap: () {
            if (isCorrectionEnabled) {
              setState(() {
                if (isSelected) {
                  selectedAnswers.remove(answer);
                } else {
                  selectedAnswers.add(answer);
                }
              });
            }
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  iconData,
                  color: borderColor,
                ),
                SizedBox(width: 8.0),
                Text(
                  answer,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
