import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/student_model.dart';

class Question04Pendon extends StatefulWidget {
  const Question04Pendon({Key? key}) : super(key: key);

  @override
  _Question04PendonState createState() => _Question04PendonState();
}

class _Question04PendonState extends State<Question04Pendon> {
  // user
  StudentModel loggedInStudent = StudentModel();

  // Pregunta
  String question =
      'Imagina que tienes que diseñar\nel pendón de tu pueblo/ciudad.\nElige de cada una de sus partes\nla opción que más te guste';

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
        title: const Text('Pregunta 04/05'),
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
                        Container(
                          height: 200,
                          margin: const EdgeInsets.all(10),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              addImage('assets/pendones/PendonUña.png'),
                              addImage('assets/pendones/PendonGenicera.png'),
                              addImage('assets/pendones/PendonCaboalles.png'),
                              addImage('assets/pendones/PendonLugueros.png'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 200,
                          margin: const EdgeInsets.all(10),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              addImage('assets/pendones/PendonUña.png'),
                              addImage('assets/pendones/PendonGenicera.png'),
                              addImage('assets/pendones/PendonCaboalles.png'),
                              addImage('assets/pendones/PendonLugueros.png'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 200,
                          margin: const EdgeInsets.all(10),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              addImage('assets/pendones/PendonUña.png'),
                              addImage('assets/pendones/PendonGenicera.png'),
                              addImage('assets/pendones/PendonCaboalles.png'),
                              addImage('assets/pendones/PendonLugueros.png'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: <Widget>[],
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
                                    builder: (context) => Question04Pendon(),
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

  Widget addImage(String image) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          image,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
