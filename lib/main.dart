import 'dart:math';
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
      backgroundColor: const Color.fromRGBO(25, 25, 25, 1),
      body: Column(children: [
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
                  style: const TextStyle(fontSize: 48, color: Colors.white),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  output,
                  style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(outputOpacity)),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
        Row(
          children: [
            normalbutton(
                text: 'C',
                tColor: highlightColor,
                buttonBgColor: operatorColor),
            normalbutton(
                text: '%',
                tColor: highlightColor,
                buttonBgColor: operatorColor),
            normalbutton(
                text: '⌫',
                tColor: highlightColor,
                buttonBgColor: operatorColor),
            normalbutton(
                text: '÷',
                tColor: highlightColor,
                buttonBgColor: operatorColor),
          ],
        ),
        Row(
          children: [
            normalbutton(text: 7),
            normalbutton(text: 8),
            normalbutton(text: 9),
            normalbutton(
                text: '×',
                tColor: highlightColor,
                buttonBgColor: operatorColor),
          ],
        ),
        Row(
          children: [
            normalbutton(text: 4),
            normalbutton(text: 5),
            normalbutton(text: 6),
            normalbutton(
                text: '-',
                tColor: highlightColor,
                buttonBgColor: operatorColor),
          ],
        ),
        Row(
          children: [
            normalbutton(text: 1),
            normalbutton(text: 2),
            normalbutton(text: 3),
            normalbutton(
                text: '+',
                tColor: highlightColor,
                buttonBgColor: operatorColor),
          ],
        ),
        Row(
          children: [
            normalbutton(text: '00'),
            normalbutton(text: 0),
            normalbutton(text: '.'),
            normalbutton(text: '=', buttonBgColor: highlightColor),
          ],
        ),
      ]),
    );
  }

  Widget normalbutton(
      {text, buttonBgColor = buttonColor, tColor = Colors.white}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
            onPressed: () => onButtonPressed(text),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                shape: const CircleBorder(eccentricity: 0),
                backgroundColor: buttonBgColor),
            child: Text(
              text.toString(),
              style: TextStyle(
                fontSize: 20,
                color: tColor,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
    );
  }
}
