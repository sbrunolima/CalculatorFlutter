import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import './buttons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestions = '';
  var userAnswer = '';

  final List<String> buttons = [
    'AC',
    'DEL',
    ' ',
    '÷',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '  ',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 48, 44, 44),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userQuestions,
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return MyButtons(
                      Colors.green,
                      Colors.white,
                      buttons[index],
                      () {
                        setState(() {
                          userQuestions = '';
                          userAnswer = '';
                        });
                      },
                    );
                  } else if (index == 1) {
                    return MyButtons(
                      Colors.red,
                      Colors.white,
                      buttons[index],
                      () {
                        setState(() {
                          userQuestions = userQuestions.substring(
                              0, userQuestions.length - 1);
                        });
                      },
                    );
                  } else if (index == buttons.length - 1) {
                    return MyButtons(
                      Colors.orange,
                      Colors.white,
                      buttons[index],
                      () {
                        setState(() {
                          equalsPressed();
                        });
                      },
                    );
                  } else {
                    return MyButtons(
                      isOperator(buttons[index]) ? Colors.orange : Colors.black,
                      isOperator(buttons[index]) ? Colors.white : Colors.white,
                      buttons[index],
                      () {
                        setState(() {
                          userQuestions += buttons[index];
                        });
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == ' ' || x == '÷' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equalsPressed() {
    String finalQuestion = userQuestions;
    finalQuestion = finalQuestion.replaceAll('x', '#');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cModel = ContextModel();
    double evalue = exp.evaluate(EvaluationType.REAL, cModel);

    userAnswer = evalue.toString();
  }
}
