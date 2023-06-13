import 'dart:math';

import 'package:aplicacion_cele/screens/questions/renubero/question_06.dart';
import 'package:flutter/material.dart';

class Question05 extends StatefulWidget {
  const Question05({Key? key}) : super(key: key);

  @override
  _Question05State createState() => _Question05State();
}

class _Question05State extends State<Question05> {
  //Score
  final Map<String, bool> score = {};
  // Random seed
  int seed = Random().nextInt(100);
  //Question
  String question = 'Une el nombre de estos árboles o \n'
      'conjunto de árboles en castellano\n'
      'con su correspondiente en leonés:';

  // Choices for game
  final Map choices = {
    'Roble': {
      'text': 'Carbayu',
    },
    'Laurel': {
      'text': 'Llaurer',
    },
    'Hayedo': {
      'text': 'Faedo',
    },
    'Abedul': {
      'text': 'Bedul',
    },
    'Avellano': {
      'text': 'Ablanu',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta 05/06'),
        centerTitle: true,
        backgroundColor: Colors.green[600],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.green[600]!,
          Colors.green[300]!,
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
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 1),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: choices.keys.map((opcion) {
                                    return Column(
                                      children: [
                                        _buildDraggable(opcion),
                                        SizedBox(height: 5),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: choices.keys.map((opcion) {
                                    return Column(
                                      children: [
                                        _buildDragTarget(opcion),
                                        SizedBox(height: 5),
                                      ],
                                    );
                                  }).toList()
                                    ..shuffle(Random(seed)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
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
                                    builder: (context) => Question06(),
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

  Widget _buildDraggable(String opcion) {
    return Draggable<String>(
      data: opcion,
      child: _buildTextContainer(opcion),
      feedback: _buildTextContainer(opcion),
      childWhenDragging: Text(
        '',
        style: TextStyle(fontSize: 40),
      ),
    );
  }

  Widget _buildTextContainer(String opcion) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 140,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.green[600]!,
                width: 1.5,
              ),
            ),
        child: Text(
          score[opcion] == true ? '✅' : opcion,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildDragTarget(String opcion) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> incoming,
          List<dynamic> rejected) {
        if (score[opcion] == true) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.green[600]!,
                width: 1.5,
              ),
            ),
            height: 50,
            width: 160,
            child: Center(
              child: Text(
                '✅',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              color: Colors.green[400],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.green[600]!,
                width: 1.5,
              ),
            ),
            height: 50,
            width: 160,
            child: Center(
              child: Text(
                choices[opcion]['text'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
      },
      onWillAccept: (data) => data == opcion,
      onAccept: (data) {
        setState(() {
          score[opcion] = true;
        });
      },
      onLeave: (data) {},
    );
  }
}