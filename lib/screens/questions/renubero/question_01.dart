import 'package:aplicacion_cele/screens/questions/renubero/question_02.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/student_model.dart';

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

  // Points
  int points = 0;

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
        title: const Text('Pregunta 01/06'),
        centerTitle: true,
        backgroundColor: Colors.green[600],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.green[600]!,
          Colors.green[400]!,
          Colors.green[200]!
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      question,
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: <Widget>[
                              buildAnswerOption(renubon),
                              buildAnswerOption(nubero),
                              buildAnswerOption(renubero),
                              buildAnswerOption(nubarron),
                              buildAnswerOption(rinobero),
                              buildAnswerOption(renueva),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green[500]!),
                          child: MaterialButton(
                            onPressed: showResults
                              ? null
                              : () {
                                  setState(() {
                                    showResults = true;
                                    isCorrectionEnabled = false; //Bloquear respuestas
                                    calcularPuntos();
                                  });
                                },// Si showResults es true, no se puede presionar el boton
                            child: const Text(
                              "Corregir",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        IgnorePointer(
                          ignoring: isCorrectionEnabled,
                          child: Opacity(
                            opacity: isCorrectionEnabled ? 0.5 : 1.0,
                            child: Container(
                              height: 50,
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green[600]!,
                              ),
                              child: MaterialButton(
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
                                child: const Text(
                                  "Siguiente",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAnswerOption(String answer) {
    bool isSelected = selectedAnswers.contains(answer);
    bool isCorrect = correctAnswers.contains(answer);

    Color borderColor;
    Color backgroundColor;
    IconData? iconData;

    if (showResults) {
      if (isSelected && isCorrect) {
        borderColor = Colors.green;
        backgroundColor = Colors.green[100]!;
        iconData = Icons.check;
      } else if (isSelected && !isCorrect) {
        borderColor = Colors.red;
        backgroundColor = Colors.red[100]!;
        iconData = Icons.cancel;
      } else if (!isSelected && isCorrect) {
        borderColor = Colors.green;
        backgroundColor = Colors.green[50]!;
      } else {
        borderColor = Colors.black26;
        backgroundColor = Colors.white;
      }
    } else {
      borderColor = isSelected ? Colors.green : Colors.black26;
      backgroundColor = isSelected ? Colors.green[50]! : Colors.white;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  iconData,
                  color: borderColor,
                ),
                const SizedBox(width: 8.0),
                Text(
                  answer,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calcularPuntos() {
    points = 0;

    for (int i = 0; i < selectedAnswers.length; i++) {
      //+6 puntos por cada respuesta correcta
      if (correctAnswers.contains(selectedAnswers[i])) {
        points = points + 6;
      }
      //-3 puntos por cada respuesta incorrecta
      else {
        points = points - 3;
      }
    }

    //+20 puntos si se seleccionan solo las 3 respuestas correctas
    if (selectedAnswers.length == 3 &&
        selectedAnswers.contains(rinobero) &&
        selectedAnswers.contains(nubero) &&
        selectedAnswers.contains(renubero)) {
      points = 20;
    }

    //Si es negativo, se pone en 0
    if (points < 0) {
      points = 0;
    }

    //Castear loggedInStudent.points a int
    int loggedInStudentPointsInt = int.parse(loggedInStudent.points!);

    //Suma los puntos calculados a loggedInStudent.points en Firebase
    loggedInStudent.points = (loggedInStudentPointsInt + points).toString();

    FirebaseFirestore.instance
        .collection('students')
        .doc(loggedInStudent.inventedEmail)
        .update({'points': loggedInStudent.points});
  }
}
