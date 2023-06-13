import 'package:aplicacion_cele/screens/questions/renubero/question_04.dart';
import 'package:flutter/material.dart';

import '../../../models/student_model.dart';

class Question03 extends StatefulWidget {
  const Question03({Key? key}) : super(key: key);

  @override
  _Question03State createState() => _Question03State();
}

class _Question03State extends State<Question03> {
  // user
  StudentModel loggedInStudent = StudentModel();
  // Pregunta
  String question = 'El Reñubero es...';
  // Respuestas
  String res1 = 'Una persona que vive en algún pueblo de León';
  String res2 = 'Un personaje joven y alegre que vive en las nubes';
  String res3 =
      'Un personaje anciano, poderoso y malhumorado que vive en las nubes';
  String res4 = 'Un personaje anciano, alegre y poderoso que vive en las nubes';
  String res5 =
      'Una persona anciana, poderosa y malhumorada que vive en la montaña de León';

  List<String> selectedAnswers = [];
  List<String> correctAnswers = ['Un personaje anciano, poderoso y malhumorado que vive en las nubes'];
  bool showResults = false;
  bool isCorrectionEnabled =
      true; //Variable para bloquear las respuestas despues de corregir

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta 03/06'),
        centerTitle: true,
        backgroundColor: Colors.green[600],
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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      question,
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: <Widget>[
                              buildAnswerOption(res1),
                              buildAnswerOption(res2),
                              buildAnswerOption(res3),
                              buildAnswerOption(res4),
                              buildAnswerOption(res5),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green[500]!),
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                showResults = true;
                                isCorrectionEnabled =
                                    false; //Bloquear respuestas
                              });
                            },
                            child: Text(
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
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 50,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green[600]!),
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Question04(),
                                  ),
                                );
                              });
                            },
                            child: Text(
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
        backgroundColor = Colors.white;
      } else {
        borderColor = Colors.black26;
        backgroundColor = Colors.white;
      }
    } else {
      borderColor = isSelected ? Colors.green : Colors.black26;
      backgroundColor = isSelected ? Colors.green[50]! : Colors.white;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
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
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  iconData,
                  color: borderColor,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    answer,
                    maxLines: null,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
