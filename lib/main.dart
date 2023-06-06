import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalculatorApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  var firstNum = '0.0';
  var secondNum = '0.0';
  var input = '';
  var output = '';
  var operation = '';
  var outputSize = 34.0;
  bool hideInput = false;
  var outputOpacity = 0.7;
  bool lightTheme = false;

  onButtonPressed(value) {
    if (value == 'C') {
      input = '';
      output = '';
    } else if (value == '⌫') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('×', '*');
        userInput = userInput.replaceAll('÷', '/');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toStringAsFixed(5);
        if (output.endsWith('.00000')) {
          output = output.substring(0, output.length - 6);
        }
        input = output;
        hideInput = true;
        outputSize = 50;
        outputOpacity = 1.0;
      }
    } else {
      input += value.toString();
      hideInput = false;
      outputSize = 34.0;
      outputOpacity = 0.7;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightTheme
          ? const Color.fromARGB(255, 225, 225, 225)
          : const Color.fromRGBO(25, 25, 25, 1),
      body: SafeArea(
        child: Column(children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      lightTheme = !lightTheme;
                    });
                  },
                  icon: lightTheme
                      ? const Icon(
                          CupertinoIcons.sun_max_fill,
                          color: Color.fromARGB(255, 109, 109, 109),
                          size: 32,
                        )
                      : const Icon(
                          CupertinoIcons.sun_max_fill,
                          color: Color.fromARGB(207, 217, 217, 217),
                          size: 32,
                        )),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsetsDirectional.only(bottom: 30),
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? "" : input,
                    style: TextStyle(
                        fontSize: 48,
                        color: lightTheme ? Colors.black : Colors.white),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                        fontSize: outputSize,
                        color: lightTheme
                            ? Colors.black.withOpacity(outputOpacity)
                            : Colors.white.withOpacity(outputOpacity)),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                normalbutton(
                    text: 'C',
                    tColor: highlightColor,
                    buttonBgColor:
                        lightTheme ? operatorColorLt : operatorColor),
                normalbutton(
                    text: '%',
                    tColor: highlightColor,
                    buttonBgColor:
                        lightTheme ? operatorColorLt : operatorColor),
                normalbutton(
                    text: '⌫',
                    tColor: highlightColor,
                    buttonBgColor:
                        lightTheme ? operatorColorLt : operatorColor),
                normalbutton(
                    text: '÷',
                    tColor: highlightColor,
                    buttonBgColor:
                        lightTheme ? operatorColorLt : operatorColor),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                normalbutton(
                    text: 7,
                    buttonBgColor: lightTheme ? buttonColorLt : buttonColor,
                    tColor: lightTheme ? Colors.black : Colors.white),
                normalbutton(
                    text: 8,
                    buttonBgColor: lightTheme ? buttonColorLt : buttonColor,
                    tColor: lightTheme ? Colors.black : Colors.white),
                normalbutton(
                    text: 9,
                    buttonBgColor: lightTheme ? buttonColorLt : buttonColor,
                    tColor: lightTheme ? Colors.black : Colors.white),
                normalbutton(
                    text: '×',
                    tColor: highlightColor,
                    buttonBgColor:
                        lightTheme ? operatorColorLt : operatorColor),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                normalbutton(
                    text: 4,
                    buttonBgColor: lightTheme ? buttonColorLt : buttonColor,
                    tColor: lightTheme ? Colors.black : Colors.white),
                normalbutton(
                    text: 5,
                    buttonBgColor: lightTheme ? buttonColorLt : buttonColor,
                    tColor: lightTheme ? Colors.black : Colors.white),
                normalbutton(
                    text: 6,
                    buttonBgColor: lightTheme ? buttonColorLt : buttonColor,
                    tColor: lightTheme ? Colors.black : Colors.white),
                normalbutton(
                    text: '-',
                    tColor: highlightColor,
                    buttonBgColor:
                        lightTheme ? operatorColorLt : operatorColor),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                normalbutton(
                    text: 1,
                    buttonBgColor: lightTheme ? buttonColorLt : buttonColor,
                    tColor: lightTheme ? Colors.black : Colors.white),
                normalbutton(
                    text: 2,
                    buttonBgColor: lightTheme ? buttonColorLt : buttonColor,
                    tColor: lightTheme ? Colors.black : Colors.white),
                normalbutton(
                    text: 3,
                    buttonBgColor: lightTheme ? buttonColorLt : buttonColor,
                    tColor: lightTheme ? Colors.black : Colors.white),
                normalbutton(
                    text: '+',
                    tColor: highlightColor,
                    buttonBgColor:
                        lightTheme ? operatorColorLt : operatorColor),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                normalbutton(
                    text: '00',
                    buttonBgColor: lightTheme ? buttonColorLt : buttonColor,
                    tColor: lightTheme ? Colors.black : Colors.white,
                    textSize: 16),
                normalbutton(
                    text: 0,
                    buttonBgColor: lightTheme ? buttonColorLt : buttonColor,
                    tColor: lightTheme ? Colors.black : Colors.white),
                normalbutton(
                    text: '.',
                    buttonBgColor: lightTheme ? buttonColorLt : buttonColor,
                    tColor: lightTheme ? Colors.black : Colors.white),
                normalbutton(
                    text: '=',
                    buttonBgColor: highlightColor,
                    tColor: lightTheme ? Colors.black : Colors.white),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget normalbutton(
      {text,
      buttonBgColor = buttonColor,
      tColor = Colors.white,
      double textSize = 20}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () => onButtonPressed(text),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(25),
              shape: const CircleBorder(eccentricity: 0),
              backgroundColor: buttonBgColor),
          child: Text(
            text.toString(),
            style: TextStyle(
              fontSize: textSize as double,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
