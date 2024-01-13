import 'package:flutter/material.dart';
import '../strings/strings.dart' as strings;

class WhtrScreen extends StatefulWidget {
  const WhtrScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WhtrScreenState createState() => _WhtrScreenState();
}

class _WhtrScreenState extends State<WhtrScreen> {
  String _measuringSystem = 'Metric'; // Initial value to avoid null
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  String _bmiResult = '';

  double calculateMetricWHtR(double height, double waist) {
    return (waist / height);
  }

  double calculateImperialWHtR(double height, double waist) {
    height = height * 2.54;
    waist = waist * 2.54;
    return (waist / height);
  }

  void calculateBMI() {
    String heightText = _heightController.text;
    String waistText = _waistController.text;

    if (heightText.isEmpty || waistText.isEmpty) {
      _bmiResult = 'Please enter both height and waist.';
    } else if (!isNumeric(heightText) || !isNumeric(waistText)) {
      _bmiResult = 'Please enter valid numbers.';
    } else {
      double height = double.parse(heightText);
      double waist = double.parse(waistText);
      double whtr;

      if (_measuringSystem == 'Metric') {
        whtr = calculateMetricWHtR(height, waist);
      } else {
        whtr = calculateImperialWHtR(height, waist);
      }

      _bmiResult = 'Your WHtR is ${whtr.toStringAsFixed(2)}';
    }

    setState(() {});
  }

  bool isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              strings.whtrTitle,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 35,
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
                  height: 55,
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
                  strings.waist,
                  style: TextStyle(fontSize: 28.0),
                ),
                const SizedBox(
                  width: 50,
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _waistController,
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
                  label: const Text("Calculate WHtR"),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.help),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                insetPadding: const EdgeInsets.all(120),
                title: const Text(strings.resultInterpretation),
                content: const Column(
                  mainAxisSize: MainAxisSize.min, //this is here to make my column fit inside the alert dialog
                  children: <Widget>[
                    Text(strings.whtrDefinition),
                    Text("\n"),
                    Text(strings.whtrInterpretation),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
