import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/student_model.dart';

class Question02Pendon extends StatefulWidget {
  const Question02Pendon({Key? key}) : super(key: key);

  @override
  _Question02PendonState createState() => _Question02PendonState();
}

class _Question02PendonState extends State<Question02Pendon> {
  // user
  StudentModel loggedInStudent = StudentModel();

  // Pregunta
  String question =
      'Toca en cada una de las partes del pendón para leer su explicación.';


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
          loggedInStudent = StudentModel.fromMap(value.data()!);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregunta 02/05'),
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
                width: double.infinity,
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
                          child: GestureDetector(
                            onTapDown: (TapDownDetails details) {
                              // Coordenadas del toque
                              double x = details.localPosition.dx;
                              double y = details.localPosition.dy;

                              // Tamaño de la imagen 
                              double imageWidth = 400;
                              double imageHeight = 330;

                              // Calcula la parte de la imagen seleccionada
                              double selectedPartX = x / imageWidth;
                              double selectedPartY = y / imageHeight;

                              // Verifica la parte seleccionada y muestra la información correspondiente
                              if (selectedPartX < 0.5 && selectedPartX > 0.2 && selectedPartY < 0.3) {
                                showInfoDialog(
                                    context, 'Cruz', 'Representan la tradición y la historia de la región de León, añadiendo un elemento distintivo al diseño del estandarte.');
                              } else if (selectedPartX >= 0.5 && selectedPartX <= 0.8 &&
                                  selectedPartY < 0.5 && selectedPartY > 0.3) {
                                showInfoDialog(
                                    context, 'Paño', 'Confeccionado en tela de alta calidad, muestra diseños representativos con escudos heráldicos y símbolos tradicionales, reflejando la identidad local.');
                              } else if (selectedPartX < 0.2 &&
                                  selectedPartY >= 0.5) {
                                showInfoDialog(
                                    context, 'Mástil', 'Largo y resistente, proporciona soporte y estabilidad al pendón, permitiendo que se exhiba con orgullo en desfiles y eventos. ');
                              }
                            },
                            child: Image.asset(
                              'assets/partesPendon.jpg', // Ruta de la imagen en la carpeta "assets"
                              width: 400,
                              height: 330,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
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
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Question02Pendon(),
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


  void showInfoDialog(BuildContext context, String titulo, String info) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          titulo,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          info,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cerrar',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    },
  );
}


}
