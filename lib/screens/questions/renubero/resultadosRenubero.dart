import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/student_model.dart';
import '../../home.dart';

class ResultadosRenubero extends StatefulWidget {
  const ResultadosRenubero({Key? key}) : super(key: key);

  @override
  _ResultadosRenuberoState createState() => _ResultadosRenuberoState();
}

class _ResultadosRenuberoState extends State<ResultadosRenubero> {
  // Variable de estado para controlar la carga de datos
  bool isLoading = true;
  // user
  StudentModel loggedInStudent = StudentModel();
  // Lista de estudiantes que han hecho la actividad
  List<StudentModel> students = [];

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

    //Sacar una lista de todos los estudiantes que han hecho la actividad "activityCode"
    FirebaseFirestore.instance
        .collection('students')
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<StudentModel> students = [];
      querySnapshot.docs.forEach((DocumentSnapshot document) {
        var data = document.data() as Map<String, dynamic>;
        var activityCode = data['activityCode'] as String?;
        if (activityCode != null &&
            activityCode == loggedInStudent.activityCode) {
          students.add(StudentModel.fromMap(data));
        }
      });

      // Ordenar la lista de estudiantes por la variable 'points'
      students.sort((a, b) {
        var pointsA = int.tryParse(a.points ?? '0') ?? 0;
        var pointsB = int.tryParse(b.points ?? '0') ?? 0;
        return pointsB.compareTo(pointsA);
      });

      setState(() {
        this.students = students;
        isLoading = false; // Ya se cargaron los datos
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
        centerTitle: true,
        backgroundColor: Colors.green[600],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.green[600]!,
              Colors.green[400]!,
              Colors.green[200]!
            ])),
            child: Column(
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
                          'Resultados Actividad ${loggedInStudent.activityCode}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(students[index].alias!),
                          subtitle: Text(students[index].points!),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.green[600]!,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ResultadosRenubero()));
                              });
                            },
                            child: const Text(
                              "Recargar",
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
                      const SizedBox(width: 10), // Espacio entre los botones
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.green[800]!,
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                signOut(context);
                              });
                            },
                            child: const Text(
                              "Salir",
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(), // Indicador de carga
            ),
        ],
      ),
    );
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }
}
