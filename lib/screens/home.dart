import 'dart:math';

import 'package:aplicacion_cele/screens/teacher/login_teacher.dart';
import 'package:aplicacion_cele/screens/waitingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
 
  // form key
  final _formKey = GlobalKey<FormState>();

  // Editing controller
  final TextEditingController codeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    // code field
    final codeField = TextFormField(
      autofocus: false,
      controller: codeController,
      keyboardType: TextInputType.number,
      // validator: (value) {}
      onSaved: (value) {
        codeController.text = value!;
      },
      
      textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.code),
      )

    );

    // name field
    final nameField = TextFormField(
      autofocus: false,
      controller: nameController,
      // validator: (value) {}
      onSaved: (value) {
        nameController.text = value!;
      },
      
      textInputAction: TextInputAction.done,

    );

    // access button
    final accessButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),

        onPressed: () {
          addStudent();
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WaitingPage())
        );
        },
        child: Text("Acceder",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold
          )
        ),
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  codeField,
                  nameField,
                  accessButton,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("¿Eres profesor/tutor?"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginTeacher()));
                        },
                        child: Text(
                          "Acceder",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),      
          ),
        ),
      )
    );
  }



  void addStudent(){

    // el studentID está formado por el nombre + el código de la actividad + un número aleatorio de 2 cifras
    String studentID = nameController.text + codeController.text + (Random().nextInt(90)+10).toString();

    FirebaseFirestore.instance.collection('students').doc(studentID).set({
      'alias': nameController.text,
      'activityCode': codeController.text,
      'points': 0,
      'studentID': studentID,
    });


  }



}