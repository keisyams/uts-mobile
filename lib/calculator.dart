import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<Calculator> {
  String _displayText = '';
  String _result = '';
  double _firstNumber = 0;
  double _secondNumber = 0;
  String? _operator;

  void _inputNumber(String number) {
    setState(() {
      _displayText += number;
    });
  }

  void _inputOperator(String operator) {
    setState(() {
      _firstNumber = double.tryParse(_displayText) ?? 0;
      _displayText = '';
      _operator = operator;
    });
  }

  void _calculateResult() {
    setState(() {
      _secondNumber = double.tryParse(_displayText) ?? 0;
      switch (_operator) {
        case '+':
          _result = (_firstNumber + _secondNumber).toString();
          break;
        case '-':
          _result = (_firstNumber - _secondNumber).toString();
          break;
        case '*':
          _result = (_firstNumber * _secondNumber).toString();
          break;
        case '/':
          _result = _secondNumber != 0
              ? (_firstNumber / _secondNumber).toString()
              : 'Error';
          break;
        default:
          _result = 'Error';
      }
      _displayText = _result;
      _operator = null;
    });
  }

  void _clear() {
    setState(() {
      _displayText = '';
      _result = '';
      _firstNumber = 0;
      _secondNumber = 0;
      _operator = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Tombol "Back"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _displayText.isNotEmpty ? _displayText : '0',
              style: const TextStyle(fontSize: 48),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildButton('7', _inputNumber),
                _buildButton('8', _inputNumber),
                _buildButton('9', _inputNumber),
                _buildButton('/', _inputOperator),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildButton('4', _inputNumber),
                _buildButton('5', _inputNumber),
                _buildButton('6', _inputNumber),
                _buildButton('*', _inputOperator),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildButton('1', _inputNumber),
                _buildButton('2', _inputNumber),
                _buildButton('3', _inputNumber),
                _buildButton('-', _inputOperator),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildButton('0', _inputNumber),
                _buildButton('C', (_) => _clear()),
                _buildButton('=', (_) => _calculateResult()),
                _buildButton('+', _inputOperator),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, Function(String) onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(label),
      child: Text(label, style: const TextStyle(fontSize: 24)),
    );
  }
}
