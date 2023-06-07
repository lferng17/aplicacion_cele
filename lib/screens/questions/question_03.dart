import 'package:flutter/material.dart';

class Question03 extends StatefulWidget {
  const Question03({Key? key}) : super(key: key);

  @override
  _Question03State createState() => _Question03State();

}

class _Question03State extends State<Question03> {

  int _currentStep = 0;
  
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta 03'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                '¿Qué podría exclamar un bombero cuando algo no le sale bien?\n'
                'Piensa en dos versos que rimen\n'
                '(Como hace el Reñubero: ¡¡Rayos y centellas, luz de las estrellas!!)',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Stepper(
            steps: [
              Step(
                title: Text('Un bombero diría:'),
                content: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Escribe aquí',
                  ),
                )
              ),
              Step(
                title: Text('¿Y un informático?'),
                content: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Escribe aquí',
                  ),
                )
              ),
              Step(
                title: Text('¿Y un profesor?'),
                content: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Escribe aquí',
                  ),
                )
              ),
              Step(
                title: Text('¿Y un estudiante?'),
                content: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Escribe aquí',
                  ),
                )
              ),
              Step(
                title: Text('¿Y un policía?'),
                content: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Escribe aquí',
                  ),
                )
              ),
              Step(
                title: Text('¿Y un carpintero?'),
                content: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Escribe aquí',
                  ),
                )
              ),
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
                    _currentStep-=1;
                  });
                }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
