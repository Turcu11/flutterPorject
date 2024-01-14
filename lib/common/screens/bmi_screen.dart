import 'package:flutter/material.dart';
import '../strings/strings.dart' as strings;

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  String _measuringSystem = strings.metric; // Initial value to avoid null
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _bmiResult = '';
  String _bmiInterpretation = '';

  void generateBMIInterpretation(double bmi) {
    if (bmi < 18.5) {
      _bmiInterpretation = strings.underweight;
    } else if (bmi < 25) {
      _bmiInterpretation = strings.normal;
    } else if (bmi < 30) {
      _bmiInterpretation = strings.overweight;
    } else {
      _bmiInterpretation = strings.obese;
    }
  }

  double calculateMetricBMI(double height, double weight) {
    return ((weight / height / height) * 10000);
  }

  double calculateImperialBMI(double height, double weight) {
    return (weight / (height * height)) * 703;
  }

  void calculateBMI() {
    String heightText = _heightController.text;
    String weightText = _weightController.text;

    if (heightText.isEmpty || weightText.isEmpty) {
      _bmiResult = strings.alertEnterHeightAndWeight;
    } else if (!isNumeric(heightText) || !isNumeric(weightText)) {
      _bmiResult = strings.alertEnterValidNumbers;
    } else {
      double height = double.parse(heightText);
      double weight = double.parse(weightText);
      double bmi;

      if (_measuringSystem == strings.metric) {
        bmi = calculateMetricBMI(height, weight);
      } else {
        bmi = calculateImperialBMI(height, weight);
      }
      generateBMIInterpretation(bmi);

      _bmiResult = 'Your BMI is ${bmi.toStringAsFixed(2)}';
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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      strings.bmiTitle,
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
                          height: 40,
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
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
                                      _measuringSystem == strings.metric
                                          ? strings.cm
                                          : strings.inches,
                                      style: const TextStyle(fontSize: 22.0),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                  width: 50,
                                ),
                                Column(
                                  children: <Widget>[
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
                                      _measuringSystem == strings.metric
                                          ? strings.kg
                                          : strings.lb,
                                      style: const TextStyle(fontSize: 22.0),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      strings.result,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _bmiResult,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _bmiInterpretation,
                      style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(250, 60),
                      ),
                      onPressed: () => calculateBMI(),
                      icon: const Icon(Icons.calculate),
                      label: const Text("Calculate BMI",
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.help),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                insetPadding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                title: const Text(strings.resultInterpretation),
                content: const SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, //this is here to make my column fit inside the alert dialog
                    children: <Widget>[
                      Text(strings.bmiDefinition),
                      Text("\n"),
                      Text(strings.bmiInterpretation),
                    ],
                  ),
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
