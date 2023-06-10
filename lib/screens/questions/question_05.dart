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
  final List<String> humanosOptions = [
    'los animales',
    'los humanos',
    'las plantas'
  ];
  final List<String> leyendasOptions = ['africanas', 'aragonesas', 'leonesas'];
  final List<String> nombresOptions = [
    'Nubarrón, Nubero o Nubecita',
    'Renovar, Renubero o Nibelungo',
    'Nubero, Renubero o Riñobero'
  ];
  final List<String> poderosoOptions = [
    'poderoso',
    'frágil',
    'fuerte',
    'endeble'
  ];
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
  final List<String> oidoOptions = ['la vista', 'el oído', 'el tacto'];
  final List<String> hablarOptions = ['silbar', 'cantar', 'hablar'];

  String? selectedLluviasOption,
      selectedTormentasOption,
      selectedPersonajeOption,
      selectedAncianoOption,
      selectedMalhumoradoOption,
      selectedHumanosOption,
      selectedLeyendasOption,
      selectedNombresOption,
      selectedPoderosoOption,
      selectedBastonOption,
      selectedAccionesOption,
      selectedExclamacionOption,
      selectedOidoOption,
      selectedHablarsOption;
  String question = 'Demuestra lo que conoces sobre el Reñubero';

  // bool para correcciones
  bool showResults = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta 5'),
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
                          height: 10,
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
                                      lluviasOptions, selectedLluviasOption, 'las lluvias',
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
                                      tormentasOptions, selectedTormentasOption, 'las tormentas',
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
                                      personajeOptions, selectedPersonajeOption, 'personaje',
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
                                      ancianoOptions, selectedAncianoOption, 'anciano',
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
                                      selectedMalhumoradoOption, 'malhumorado', (value) {
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
                              Row(
                                children: <Widget>[
                                  buildDropdowns(
                                      humanosOptions, selectedHumanosOption, 'los humanos',
                                      (value) {
                                    setState(() {
                                      selectedHumanosOption = value;
                                    });
                                  }),
                                  Text(
                                    ' . Aunque la mayoría le ',
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
                                    'conocen como Reñubero, en las leyendas',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  buildDropdowns(
                                      leyendasOptions, selectedLeyendasOption, 'leonesas',
                                      (value) {
                                    setState(() {
                                      selectedLeyendasOption = value;
                                    });
                                  }),
                                  Text(
                                    ' tiene también otros nombres',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'como ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(
                                      nombresOptions, selectedNombresOption, 'Nubero, Renubero o Riñobero',
                                      (value) {
                                    setState(() {
                                      selectedNombresOption = value;
                                    });
                                  }),
                                  Text(
                                    ' .',
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
                                    'Domina las lluvias, las tempestades, las ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'tormentas y por eso es muy ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(
                                      poderosoOptions, selectedPoderosoOption, 'poderoso',
                                      (value) {
                                    setState(() {
                                      selectedPoderosoOption = value;
                                    });
                                  }),
                                  Text(
                                    ' .',
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
                                    'Siempre va acompañado de un viejo',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  buildDropdowns(
                                      bastonOptions, selectedBastonOption, 'bastón de madera',
                                      (value) {
                                    setState(() {
                                      selectedBastonOption = value;
                                    });
                                  }),
                                  Text(
                                    ' con el que inicia las',
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
                                    'tormentas, provoca ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  buildDropdowns(
                                      accionesOptions, selectedAccionesOption, 'rayos, truenos y chaparrones',
                                      (value) {
                                    setState(() {
                                      selectedAccionesOption = value;
                                    });
                                  }),
                                  Text(
                                    ' . Por eso',
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
                                    'su exclamación favorita es: ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  buildDropdowns(exclamacionOptions,
                                      selectedExclamacionOption, '¡¡Rayos y centellas, luz de las estrellas!!', (value) {
                                    setState(() {
                                      selectedExclamacionOption = value;
                                    });
                                  }),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    'Cuando veas nubarrones y empiece una',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'tormenta, aguza ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(
                                      oidoOptions, selectedOidoOption, 'el oído', (value) {
                                    setState(() {
                                      selectedOidoOption = value;
                                    });
                                  }),
                                  Text(
                                    ' ... quizá lo',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'escuches ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(
                                      hablarOptions, selectedHablarsOption, 'hablar',
                                      (value) {
                                    setState(() {
                                      selectedHablarsOption = value;
                                    });
                                  }),
                                  Text(
                                    ' ... ',
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
                              setState(() {
                                showResults = true;
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

  Widget buildDropdowns(List<String> options, String? selectedOption, String? correctOption,
      Function(String?) onChanged) {
    final isCorrectOption = selectedOption == correctOption;

    //Añadir puntos, ej: selecciona mal, -2 puntos. Selecciona bien, +5 puntos.

    return DropdownButton<String>(
      value: selectedOption,
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(
            option,
            style: TextStyle(
                color: isCorrectOption
                    ? Colors.green[600]
                    : Colors.black),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      iconEnabledColor: Colors.green[600],
      style: TextStyle(color: Colors.black, fontSize: 16),
    );
  }
}
