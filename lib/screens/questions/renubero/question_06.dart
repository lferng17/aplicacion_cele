import 'package:aplicacion_cele/screens/questions/renubero/resultadosRenubero.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/student_model.dart';

class Question06 extends StatefulWidget {
  const Question06({Key? key}) : super(key: key);

  @override
  _Question06State createState() => _Question06State();
}

class _Question06State extends State<Question06> {
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

  //Puntos
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
        title: const Text('Pregunta 06/06'),
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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    question,
                    style: const TextStyle(color: Colors.white, fontSize: 22),
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
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  const Text(
                                    'Reñubero es el señor de ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(
                                      lluviasOptions,
                                      selectedLluviasOption,
                                      'las lluvias', (value) {
                                    setState(() {
                                      selectedLluviasOption = value;
                                    });
                                  }),
                                  const Text(
                                    ' y ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  buildDropdowns(
                                      tormentasOptions,
                                      selectedTormentasOption,
                                      'las tormentas', (value) {
                                    setState(() {
                                      selectedTormentasOption = value;
                                    });
                                  }),
                                  const Text(
                                    ' . Es un ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(
                                      personajeOptions,
                                      selectedPersonajeOption,
                                      'personaje', (value) {
                                    setState(() {
                                      selectedPersonajeOption = value;
                                    });
                                  }),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  buildDropdowns(
                                      ancianoOptions,
                                      selectedAncianoOption,
                                      'anciano', (value) {
                                    setState(() {
                                      selectedAncianoOption = value;
                                    });
                                  }),
                                  const Text(
                                    ' , ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(
                                      malhumoradoOptions,
                                      selectedMalhumoradoOption,
                                      'malhumorado', (value) {
                                    setState(() {
                                      selectedMalhumoradoOption = value;
                                    });
                                  }),
                                  const Text(
                                    ' , ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: const <Widget>[
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
                                      humanosOptions,
                                      selectedHumanosOption,
                                      'los humanos', (value) {
                                    setState(() {
                                      selectedHumanosOption = value;
                                    });
                                  }),
                                  const Text(
                                    ' . Aunque la mayoría le ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: const <Widget>[
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
                                      leyendasOptions,
                                      selectedLeyendasOption,
                                      'leonesas', (value) {
                                    setState(() {
                                      selectedLeyendasOption = value;
                                    });
                                  }),
                                  const Text(
                                    ' tiene también otros nombres',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  const Text(
                                    'como ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(
                                      nombresOptions,
                                      selectedNombresOption,
                                      'Nubero, Renubero o Riñobero', (value) {
                                    setState(() {
                                      selectedNombresOption = value;
                                    });
                                  }),
                                  const Text(
                                    ' .',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: const <Widget>[
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
                                  const Text(
                                    'tormentas y por eso es muy ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(
                                      poderosoOptions,
                                      selectedPoderosoOption,
                                      'poderoso', (value) {
                                    setState(() {
                                      selectedPoderosoOption = value;
                                    });
                                  }),
                                  const Text(
                                    ' .',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: const <Widget>[
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
                                      bastonOptions,
                                      selectedBastonOption,
                                      'bastón de madera', (value) {
                                    setState(() {
                                      selectedBastonOption = value;
                                    });
                                  }),
                                  const Text(
                                    ' con el que inicia las',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: const <Widget>[
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
                                      accionesOptions,
                                      selectedAccionesOption,
                                      'rayos, truenos y chaparrones', (value) {
                                    setState(() {
                                      selectedAccionesOption = value;
                                    });
                                  }),
                                  const Text(
                                    ' . Por eso',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: const <Widget>[
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
                                  buildDropdowns(
                                      exclamacionOptions,
                                      selectedExclamacionOption,
                                      '¡¡Rayos y centellas, luz de las estrellas!!',
                                      (value) {
                                    setState(() {
                                      selectedExclamacionOption = value;
                                    });
                                  }),
                                ],
                              ),
                              Row(
                                children: const <Widget>[
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
                                  const Text(
                                    'tormenta, aguza ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(oidoOptions,
                                      selectedOidoOption, 'el oído', (value) {
                                    setState(() {
                                      selectedOidoOption = value;
                                    });
                                  }),
                                  const Text(
                                    ' ... quizá lo',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  const Text(
                                    'escuches ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  buildDropdowns(hablarOptions,
                                      selectedHablarsOption, 'hablar', (value) {
                                    setState(() {
                                      selectedHablarsOption = value;
                                    });
                                  }),
                                  const Text(
                                    ' ... ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
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
                              calcularPuntos();
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResultadosRenubero(),
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
      String? correctOption, Function(String?) onChanged) {
    final isCorrectOption = selectedOption == correctOption;

    //Puntos: selecciona mal, -1 puntos. Selecciona bien, +2 puntos.

    return DropdownButton<String>(
      value: selectedOption,
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(
            option,
            style: TextStyle(
                color: isCorrectOption ? Colors.green[600] : Colors.black),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      iconEnabledColor: Colors.green[600],
      style: const TextStyle(color: Colors.black, fontSize: 16),
    );
  }

  void calcularPuntos() {
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
