import 'dart:math';

import 'package:aplicacion_cele/models/student_model.dart';
import 'package:aplicacion_cele/screens/teacher/login_teacher.dart';
import 'package:aplicacion_cele/screens/waitingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
        ));

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
          String email = nameController.text +
              codeController.text +
              (Random().nextInt(90) + 10).toString() +
              "@gmail.com";
          String password = nameController.text + codeController.text;
          signUpStudent(email, password);
        },
        child: Text("Acceder",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginTeacher()));
                          },
                          child: Text(
                            "Acceder",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void signUpStudent(String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore()})
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });

    //Tras 4 segundos llama a la funcion signInStudent
    Future.delayed(const Duration(seconds: 1), () {
      signInStudent(email, password);
    });

  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our student model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    StudentModel studentModel = StudentModel();

    // writing all the values
    studentModel.alias = nameController.text;
    studentModel.activityCode = codeController.text;
    studentModel.points = "0";
    studentModel.inventedEmail = user!.email;
    studentModel.uid = user.uid;

    await firebaseFirestore
        .collection("students")
        .doc(user.email)
        .set(studentModel.toMap());

    Fluttertoast.showToast(msg: "Cuenta creada correctamente");

  }

  // Login function
  void signInStudent(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
              Fluttertoast.showToast(msg: "Student Login successful"),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => WaitingPage()))
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }

  
}
