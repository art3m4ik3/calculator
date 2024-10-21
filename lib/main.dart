import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  final String title = 'Калькулятор';

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _operation = "";
  String _currentInput = "";
  double _firstNumber = 0;
  double _secondNumber = 0;

  void _onPressedButton(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _operation = "";
        _currentInput = "";
        _firstNumber = 0;
        _secondNumber = 0;
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        if (_currentInput.isNotEmpty) {
          _operation = buttonText;
          _firstNumber = double.parse(_currentInput);
          _currentInput = "";
        } else if (_output != "0") {
          _firstNumber = double.parse(_output);
          _operation = buttonText;
        }
      } else if (buttonText == "=") {
        if (_operation.isNotEmpty && _currentInput.isNotEmpty) {
          _secondNumber = double.parse(_output);

          switch (_operation) {
            case "+":
              _output = (_firstNumber + _secondNumber).toString();
              break;
            case "-":
              _output = (_firstNumber - _secondNumber).toString();
              break;
            case "*":
              _output = (_firstNumber * _secondNumber).toString();
              break;
            case "/":
              _output = (_firstNumber / _secondNumber).toString();
              break;
          }

          _firstNumber = double.parse(_output);
          _operation = "";
          _currentInput = "";
        }
      } else {
        if (_currentInput == "0") {
          _currentInput = buttonText;
        } else {
          _currentInput += buttonText;
        }

        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return FilledButton(
      onPressed: () => _onPressedButton(buttonText),
      child: Text(buttonText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Column(
          children: [
            Text(_output),
            Column(
              children: [
                Row(children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/")
                ]),
                Row(children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*")
                ]),
                Row(children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("+")
                ]),
                Row(children: [
                  _buildButton("C"),
                  _buildButton("0"),
                  _buildButton("="),
                  _buildButton("-")
                ])
              ],
            )
          ],
        ));
  }
}
