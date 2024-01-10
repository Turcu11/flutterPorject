import 'package:flutter/material.dart';
import '../strings/strings.dart' as strings;

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  String _measuringSystem = 'Metric'; // Initial value to avoid null
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _bmiResult = '';

  double calculateMetricBMI(double height, double weight) {
    return ((weight / height / height) * 10000);
  }

  double calculateImperialBMI(double height, double weight) {
    return (weight / (height * height)) * 703;
  }

  void calculateBMI() {
    double height = double.parse(_heightController.text);
    double weight = double.parse(_weightController.text);
    double bmi;

    if (_heightController.text.isEmpty || _weightController.text.isEmpty) {
      const snackBar =
          SnackBar(content: Text('Height and Weight must be greater than 0'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (_measuringSystem == 'Metric') {
      bmi = calculateMetricBMI(height, weight);
    } else {
      bmi = calculateImperialBMI(height, weight);
    }

    _bmiResult = 'Your BMI is ${bmi.toStringAsFixed(2)}';
    final snackBar =
        SnackBar(content: Text('Your BMI is ${bmi.toStringAsFixed(2)}'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              strings.bmiPrompt,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(strings.metric),
                Radio<String>(
                  value: strings.metric,
                  groupValue: _measuringSystem,
                  onChanged: (String? value) {
                    setState(() {
                      _measuringSystem = value!;
                    });
                  },
                ),
                const SizedBox(
                  width: 40,
                ),
                const Text(strings.imperial),
                Radio<String>(
                  value: strings.imperial,
                  groupValue: _measuringSystem,
                  onChanged: (String? value) {
                    setState(() {
                      _measuringSystem = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 75,
                ),
                const Text(
                  strings.height,
                  style: TextStyle(fontSize: 28.0),
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  _measuringSystem == strings.metric ? 'cm' : 'in',
                  style: const TextStyle(fontSize: 22.0),
                ),
                const SizedBox(
                  height: 30,
                  width: 30,
                ),
                const Text(
                  strings.weight,
                  style: TextStyle(fontSize: 28.0),
                ),
                const SizedBox(
                  width: 50,
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  _measuringSystem == strings.metric ? 'kg' : 'lb',
                  style: const TextStyle(fontSize: 22.0),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Result: ',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _bmiResult,
                  style: const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton.icon(
                    onPressed: () => calculateBMI(),
                    icon: const Icon(Icons.calculate),
                    label: const Text("Calculate BMI")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
