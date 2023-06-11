import 'dart:math';

import 'package:flutter/material.dart';

class Question06 extends StatefulWidget {
  const Question06({Key? key}) : super(key: key);

  @override
  _Question06State createState() => _Question06State();
}

class _Question06State extends State<Question06> {
  //Score
  final Map<String, bool> score = {};
  // Random seed
  int seed = Random().nextInt(100);

  // Choices for game
  final Map choices = {
    'Roble': {
      'color': Colors.green,
      'text': 'Carbayu',
    },
    'Laurel': {
      'color': Colors.yellow,
      'text': 'Llaurer',
    },
    'Hayedo': {
      'color': Colors.red,
      'text': 'Faedo',
    },
    'Abedul': {
      'color': Colors.purple,
      'text': 'Bedul',
    },
    'Avellano': {
      'color': Colors.brown,
      'text': 'Ablanu',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pregunta 06/06'),
        centerTitle: true,
        backgroundColor: Colors.green[600],
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: choices.keys.map((opcion) {
                    return Column(
                      children: [
                        _buildDraggable(opcion),
                        SizedBox(
                            height: 5), 
                      ],
                    );
                  }).toList(),
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: choices.keys.map((opcion) {
                    return Column(
                      children: [
                        _buildDragTarget(opcion),
                        SizedBox(height: 5),
                      ],
                    );
                  }).toList()
                    ..shuffle(Random(seed)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDraggable(String opcion) {
    return Draggable<String>(
      data: opcion,
      child: _buildTextContainer(opcion),
      feedback: _buildTextContainer(opcion),
      childWhenDragging: Text(
        '',
        style: TextStyle(fontSize: 40),
      ),
    );
  }

  Widget _buildTextContainer(String opcion) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        padding: EdgeInsets.all(10),
        child: Text(
          score[opcion] == true ? '✅' : opcion,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildDragTarget(String opcion) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> incoming,
          List<dynamic> rejected) {
        if (score[opcion] == true) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.green[600]!,
                width: 1.5,
              ),
            ),
            height: 50,
            width: 200,
            child: Center(
              child: Text(
                '¡Correcto!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              color: Colors.green[400],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.green[600]!,
                width: 1.5,
              ),
            ),
            height: 50,
            width: 200,
            child: Center(
              child: Text(
                choices[opcion]['text'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
      },
      onWillAccept: (data) => data == opcion,
      onAccept: (data) {
        setState(() {
          score[opcion] = true;
        });
      },
      onLeave: (data) {},
    );
  }
}
