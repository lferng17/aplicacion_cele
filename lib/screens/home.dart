import 'dart:math';

import 'package:aplicacion_cele/models/student_model.dart';
import 'package:aplicacion_cele/screens/teacher/login_teacher.dart';
import 'package:aplicacion_cele/screens/waitingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
    final codeField = Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "Código de Actividad",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none),
        autofocus: false,
        controller: codeController,
        keyboardType: TextInputType.number,
        // validator: (value) {}
        onSaved: (value) {
          codeController.text = value!;
        },
        textInputAction: TextInputAction.next,
      ),
    );

    // name field
    final nameField = Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
      child: TextFormField(
        autofocus: false,
        controller: nameController,
        // validator: (value) {}
        onSaved: (value) {
          nameController.text = value!;
        },
        decoration: InputDecoration(
            hintText: "Alias",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none),

        textInputAction: TextInputAction.done,
      ),
    );

    // access button
    final accessButton = Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color.fromARGB(255, 135, 207, 122)),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          String email = nameController.text +
              codeController.text +
              (Random().nextInt(90) + 10).toString() +
              "@appcele.com";
          String password = nameController.text + codeController.text;
          signUpStudent(email, password);
        },
        child: Text(
          "Acceder",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ),
    );

    return Scaffold(
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
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Acceder",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Universidad de León', speed: const Duration(milliseconds: 250)),                       
                      ],
                      totalRepeatCount: 4,
                      pause: const Duration(milliseconds: 2000),
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
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(62, 159, 29, 0.294),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              codeField,
                              nameField,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        accessButton,
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "¿Eres profesor/tutor?",
                          style: TextStyle(color: Colors.grey),
                        ),
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

  void signUpStudent(String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore()})
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });

    //Tras 1 segundo llama a la funcion signInStudent
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
