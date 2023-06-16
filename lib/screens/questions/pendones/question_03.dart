import 'package:aplicacion_cele/screens/questions/pendones/question_04.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/student_model.dart';

class Question03Pendon extends StatefulWidget {
  const Question03Pendon({Key? key}) : super(key: key);

  @override
  _Question03PendonState createState() => _Question03PendonState();
}

class _Question03PendonState extends State<Question03Pendon> {
  //Question
  String question = 'Busca las parejas de pendones iguales';

  //Juego
  Game juego = Game();

  //game stats
  int tries = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    juego.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregunta 03/05'),
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
                ],
              ),
            ),
            const SizedBox(height: 5),
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
                          height: 10,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width / 3 * 3.5,
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                                itemCount: juego.gameImg!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 20.0,
                                ),
                                padding: const EdgeInsets.all(20.0),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        //incrementing the clicks
                                        tries++;
                                        juego.gameImg![index] =
                                            juego.cards_list[index];
                                        juego.matchCheck.add(
                                            {index: juego.cards_list[index]});
                                      });
                                      if (juego.matchCheck.length == 2) {
                                        if (juego.matchCheck[0].values.first ==
                                            juego.matchCheck[1].values.first) {
                                          print("true");
                                          //incrementing the score
                                          score += 100;
                                          juego.matchCheck.clear();
                                        } else {
                                          print("false");

                                          Future.delayed(
                                              const Duration(milliseconds: 500), () {
                                            setState(() {
                                              juego.gameImg![juego.matchCheck[0]
                                                      .keys.first] =
                                                  juego.hiddenCardpath;
                                              juego.gameImg![juego.matchCheck[1]
                                                      .keys.first] =
                                                  juego.hiddenCardpath;
                                              juego.matchCheck.clear();
                                            });
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                          image:
                                              AssetImage(juego.gameImg![index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                        const SizedBox(
                          height: 20,
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
}

class Game {

  List<String>? gameImg; 

  final String hiddenCardpath = "assets/pendones/interrogacion.jpeg";
  List<String> cards_list = [
    "assets/pendones/PendonGenicera.png",
    "assets/pendones/PendonLugueros.png",
    "assets/pendones/PendonGenicera.png",
    "assets/pendones/PendonCaboalles.png",
    "assets/pendones/PendonUña.png",
    "assets/pendones/PendonPedrosadelRey.png",
    "assets/pendones/PendonSantaColomba.png",
    "assets/pendones/PendonLugueros.png",
    "assets/pendones/PendonSantaColomba.png",
    "assets/pendones/PendonUña.png",
    "assets/pendones/PendonCaboalles.png",
    "assets/pendones/PendonPedrosadelRey.png",
  ];
  final int cardCount = 12;
  List<Map<int, String>> matchCheck = [];

  void initGame() {
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
    cards_list.shuffle();
  }

}
