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
      setState(() {
        this.students = students;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //Imprimir la lista de todos los estudiantes
    students.forEach((element) {
      print(element.alias);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados'),
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
                      'Resultados Actividad ${loggedInStudent.activityCode}',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(students[index].alias!),
                      subtitle: Text(students[index].activityCode!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados Actividad ${loggedInStudent.activityCode}'),
        centerTitle: true,
        backgroundColor: Colors.green[600],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Resultados de la actividad',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(students[index].alias!),
                      subtitle: Text(students[index].activityCode!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
