import 'package:aplicacion_cele/screens/questions/renubero/question_03.dart';
import 'package:flutter/material.dart';

class Question02 extends StatefulWidget {
  const Question02({Key? key}) : super(key: key);

  @override
  _Question02State createState() => _Question02State();
}

class _Question02State extends State<Question02> {
  // Pregunta
  String question = 'Coloca cada etiqueta en el \nrecipiente correspondiente:';

  // Etiquetas
  List<String> etiquetas = [
    'Provoca chaparrones inoportunos.',
    'Llena de agua ríos y pantanos.',
    'Domina las lluvias y las tempestades.',
    'Provoca terribles tormentas que\nhacen que se vaya la luz.',
    'Proporciona lluvias cálidas de\nprimavera que riegan los campos.',
    'Es un personaje malhumorado,\nrefunfuñón y cabezota.',
    'Oscurece el cielo con nubarrones\nnegros.',
    'Le gusta aguar la fiesta a los humanos.',
    'Le gustan los árboles y, en general,\ncuida de la naturaleza.',
    'Llena los ríos de agua para que los\nanimales puedan beber.',
    '✅ ¡Genial! ✅'
  ];

  List<String> etiquetasAceptadasTop = [];
  List<String> etiquetasAceptadasBottom = [];

  int currentEtiquetaIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregunta 02/06'),
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
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  width: 350,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    color: Colors.green[400],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Cosas Buenas del Reñubero',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              _buildDragTargetTop(),
                              const SizedBox(
                                height: 20,
                              ),
                              _buildDraggable(),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Container(
                                  width: 350,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    color: Colors.red[300],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Cosas Malas del Reñubero',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              _buildDragTargetBottom(),
                            ],
                          ),
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
                                    builder: (context) => Question03(),
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

  Widget _buildDraggable() {
    return Draggable<String>(
      data: etiquetas[currentEtiquetaIndex],
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.lightBlue[500],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 310,
          height: 60,
          child: Center(
            child: Text(
              etiquetas[currentEtiquetaIndex],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      feedback: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.lightBlue[400],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 300,
          height: 60,
          child: Center(
            child: Text(
              etiquetas[currentEtiquetaIndex],
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      childWhenDragging: Container(
        color: Colors.white,
        width: 300,
        height: 60,
      ),
    );
  }

  Widget _buildDragTargetTop() {
    return DragTarget<String>(
      onAccept: (data) => setState(() {
        currentEtiquetaIndex++;
        etiquetasAceptadasTop.add(data);
      }),
      builder: (context, candidateData, rejectedData) => Container(
        width: 350,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: Colors.green[400],
        ),
        child: Align(
          alignment: Alignment.center,
          child: ListView.separated(
            padding: const EdgeInsets.all(6),
            itemCount: etiquetasAceptadasTop.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 5),
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Text(
                  etiquetasAceptadasTop[index],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      onWillAccept: (data) {
        // Verificar si el dragtarget acepta la etiqueta
        return [1, 2, 4, 8, 9].contains(etiquetas.indexOf(data!));
      },
    );
  }

  Widget _buildDragTargetBottom() {
    return DragTarget<String>(
      onAccept: (data) => setState(() {
        currentEtiquetaIndex++;
        etiquetasAceptadasBottom.add(data);
      }),
      builder: (context, candidateData, rejectedData) => Container(
        width: 350,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: Colors.red[300],
        ),
        child: Align(
          alignment: Alignment.center,
          child: ListView.separated(
            padding: const EdgeInsets.all(6),
            itemCount: etiquetasAceptadasBottom.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 5),
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Text(
                  etiquetasAceptadasBottom[index],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      onWillAccept: (data) {
        return [0, 3, 5, 6, 7].contains(etiquetas.indexOf(data!));
      },
    );
  }
}
