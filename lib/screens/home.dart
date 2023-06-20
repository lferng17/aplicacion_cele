import 'dart:math';

import 'package:aplicacion_cele/models/activity_model.dart';
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
      child: TextFormField(
        decoration: const InputDecoration(
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
      child: TextFormField(
        autofocus: false,
        controller: nameController,
        // validator: (value) {}
        onSaved: (value) {
          nameController.text = value!;
        },
        decoration: const InputDecoration(
            hintText: "Alias",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none),

        textInputAction: TextInputAction.done,
      ),
    );

    // access button
    final accessButton = Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.green[400]),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          String email = nameController.text +
              codeController.text +
              (Random().nextInt(90) + 10).toString() +
              "@appcele.com";
          String password = nameController.text + codeController.text;
          if(await checkActivityCode(codeController.text)){
            signUpStudent(email, password);
          }else{
            Fluttertoast.showToast(
                msg: "Código de actividad incorrecto",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          
        },
        child: const Text(
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
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Acceder",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  const SizedBox(
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
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              
            ),
            const SizedBox(height: 20),
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
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
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
                        const SizedBox(
                          height: 40,
                        ),
                        accessButton,
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
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
                          child: const Text(
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

  //Metodo que devuelve true si el código de la actividad existe
  Future<bool> checkActivityCode(String code) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('activities')
        .where('code', isEqualTo: code)
        .get();

    return querySnapshot.size > 0;
  } catch (e) {
    print('Error checking activity code: $e');
    return false;
  }
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

  }

  // Login function
  void signInStudent(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => WaitingPage()))
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }
}
