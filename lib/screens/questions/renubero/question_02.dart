import 'package:aplicacion_cele/screens/questions/renubero/question_03.dart';
import 'package:flutter/material.dart';

class Question02 extends StatefulWidget {
  const Question02({Key? key}) : super(key: key);

  @override
  _Question02State createState() => _Question02State();
}

class _Question02State extends State<Question02> {
  // Pregunta
  String question =
      '¿Qué podría exclamar un bombero cuando algo no le sale bien?\n'
      'Piensa en dos versos que rimen, Como hace el Reñubero:\n'
      '¡¡Rayos y centellas, luz de las estrellas!!';

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta 02/06'),
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
                      style: TextStyle(color: Colors.white, fontSize: 18),
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
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              Stepper(
                                steps: [
                                  Step(
                                      title: Text('Un bombero diría:'),
                                      content: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Escribe aquí',
                                        ),
                                      )),
                                  Step(
                                      title: Text('¿Y un informático?'),
                                      content: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Escribe aquí',
                                        ),
                                      )),
                                  Step(
                                      title: Text('¿Y un profesor?'),
                                      content: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Escribe aquí',
                                        ),
                                      )),
                                  Step(
                                      title: Text('¿Y un estudiante?'),
                                      content: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Escribe aquí',
                                        ),
                                      )),
                                  Step(
                                      title: Text('¿Y un policía?'),
                                      content: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Escribe aquí',
                                        ),
                                      )),
                                  Step(
                                      title: Text('¿Y un carpintero?'),
                                      content: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: 'Escribe aquí',
                                        ),
                                      )),
                                ],
                                onStepTapped: (int newIndex) {
                                  setState(() {
                                    _currentStep = newIndex;
                                  });
                                },
                                currentStep: _currentStep,
                                onStepContinue: () {
                                  setState(() {
                                    if (_currentStep < 5) {
                                      _currentStep++;
                                    }
                                  });
                                },
                                onStepCancel: () {
                                  setState(() {
                                    if (_currentStep != 0) {
                                      setState(() {
                                        _currentStep -= 1;
                                      });
                                    }
                                  });
                                },
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
                                    builder: (context) => Question03(),
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
}
