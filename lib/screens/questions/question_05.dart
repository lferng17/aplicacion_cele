import 'package:flutter/material.dart';

import '../../models/student_model.dart';

class Question05 extends StatefulWidget {
  const Question05({Key? key}) : super(key: key);

  @override
  _Question05State createState() => _Question05State();
}

class _Question05State extends State<Question05> {
  // user
  StudentModel loggedInStudent = StudentModel();

  // Opciones
  List<String> lluviasOptions = ['los cielos', 'las lluvias', 'la tierra'];
  final List<String> tormentasOptions = [
    'los chillidos',
    'los ruidos',
    'las tormentas'
  ];
  final List<String> personajeOptions = ['persona', 'personaje'];
  final List<String> ancianoOptions = ['anciano', 'joven', 'de mediana edad'];
  final List<String> malhumoradoOptions = ['alegre', 'malhumorado'];
  final List<String> entablarOptions = [
    'los animales',
    'los humanos',
    'las plantas'
  ];
  final List<String> leyendasOptions = [
    'leyendas africanas',
    'leyendas aragonesas',
    'leyendas leonesas'
  ];
  final List<String> nombresOptions = [
    'Nubarrón, Nubero o Nubecita',
    'Renovar, Renubero o Nibelungo',
    'Nubero, Renubero o Riñobero'
  ];
  final List<String> poderOptions = ['poderoso', 'frágil', 'fuerte', 'endeble'];
  final List<String> bastonOptions = [
    'bastón de hierro',
    'bastón de plástico',
    'bastón de madera'
  ];
  final List<String> accionesOptions = [
    'mareas y sunamis',
    'sequías y hambrunas',
    'rayos, truenos y chaparrones'
  ];
  final List<String> exclamacionOptions = [
    '¡¡Rayos y centellas, luz de las estrellas!!',
    '¡¡Rayos, truenos y venenos!!',
    '¡¡Rayos y centellas, llueven botellas!!'
  ];
  final List<String> aguzaOptions = ['la vista', 'el oído', 'el tacto'];
  final List<String> escuchesOptions = ['silbar', 'cantar', 'hablar'];

  String? selectedLluviasOption,
      selectedTormentasOption,
      selectedPersonajeOption,
      selectedAncianoOption,
      selectedMalhumoradoOption,
      selectedEntablarOption,
      selectedLeyendasOption,
      selectedNombresOption,
      selectedPoderOption,
      selectedBastonOption,
      selectedAccionesOption,
      selectedExclamacionOption,
      selectedAguzaOption,
      selectedEscuchesOption;
  String question = 'Demuestra lo que conoces sobre el Reñubero';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta 4'),
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
                  Text(
                    question,
                    style: TextStyle(color: Colors.white, fontSize: 22),
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
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Reñubero es el señor de ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(
                                      lluviasOptions, selectedLluviasOption,
                                      (value) {
                                    setState(() {
                                      selectedLluviasOption = value;
                                    });
                                  }),
                                  Text(
                                    ' y ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  buildDropdowns(
                                      tormentasOptions, selectedTormentasOption,
                                      (value) {
                                    setState(() {
                                      selectedTormentasOption = value;
                                    });
                                  }),
                                  Text(
                                    ' . Es un ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(
                                      personajeOptions, selectedPersonajeOption,
                                      (value) {
                                    setState(() {
                                      selectedPersonajeOption = value;
                                    });
                                  }),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  buildDropdowns(
                                      ancianoOptions, selectedAncianoOption,
                                      (value) {
                                    setState(() {
                                      selectedAncianoOption = value;
                                    });
                                  }),
                                  Text(
                                    ' , ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(malhumoradoOptions,
                                      selectedMalhumoradoOption, (value) {
                                    setState(() {
                                      selectedMalhumoradoOption = value;
                                    });
                                  }),
                                  Text(
                                    ' , ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    'cabezota y no le gusta entablar amistad con ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
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
                              setState(() {});
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
                                    builder: (context) => Question05(),
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

  Widget buildDropdowns(List<String> options, String? selectedOption,
      Function(String?) onChanged) {
    return DropdownButton<String>(
      value: selectedOption,
      items: options
          .map((option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ))
          .toList(),
      onChanged: onChanged,
      iconEnabledColor: Colors.green[600],
      style: TextStyle(color: Colors.black, fontSize: 16),
    );
  }
}
