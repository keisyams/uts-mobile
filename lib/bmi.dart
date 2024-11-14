import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMI> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double? _bmi;
  String _category = '';
  Color _categoryColor = Colors.grey;

  void _calculateBMI() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double heightCm = double.tryParse(_heightController.text) ?? 0;
    final double heightM = heightCm / 100; // Convert cm to meters

    if (weight > 0 && heightM > 0) {
      setState(() {
        _bmi = weight / (heightM * heightM);
        _updateBMICategory();
      });
    }
  }

  void _updateBMICategory() {
    if (_bmi == null) return;
    if (_bmi! < 18.5) {
      _category = 'Underweight';
      _categoryColor = Colors.blue;
    } else if (_bmi! < 24.9) {
      _category = 'Normal';
      _categoryColor = Colors.green;
    } else if (_bmi! < 29.9) {
      _category = 'Overweight';
      _categoryColor = Colors.orange;
    } else {
      _category = 'Obesity';
      _categoryColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        elevation: 4,
        backgroundColor: Colors.blue.shade100,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade100,
              Colors.deepPurple.shade50,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  prefixIcon: Icon(Icons.line_weight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _heightController,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  prefixIcon: Icon(Icons.height),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Calculate'),
              ),
              const SizedBox(height: 20),
              if (_bmi != null)
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your BMI: ${_bmi!.toStringAsFixed(1)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getCategoryIcon(),
                              color: _categoryColor,
                              size: 28,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _category,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: _categoryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon() {
    switch (_category) {
      case 'Underweight':
        return Icons.sentiment_dissatisfied;
      case 'Normal':
        return Icons.sentiment_satisfied;
      case 'Overweight':
        return Icons.sentiment_neutral;
      case 'Obesity':
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.help_outline;
    }
  }
}
