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
  String _whtrResult = '';
  String _whtrInterpretation = '';

  void generateWHtRInterpretation(double whtr) {
    if (whtr < 0.5) {
      _whtrInterpretation = 'Low risk';
    } else if (whtr < 0.6) {
      _whtrInterpretation = 'Moderate risk';
    } else {
      _whtrInterpretation = 'High risk';
    }
  }

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
      _whtrResult = 'Please enter both height and waist.';
    } else if (!isNumeric(heightText) || !isNumeric(waistText)) {
      _whtrResult = 'Please enter valid numbers.';
    } else {
      double height = double.parse(heightText);
      double waist = double.parse(waistText);
      double whtr;

      if (_measuringSystem == 'Metric') {
        whtr = calculateMetricWHtR(height, waist);
      } else {
        whtr = calculateImperialWHtR(height, waist);
      }
      generateWHtRInterpretation(whtr);

      _whtrResult = 'Your WHtR is ${whtr.toStringAsFixed(2)}';
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
                                Column(children: <Widget>[
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
                                    _measuringSystem == strings.metric
                                        ? strings.cm
                                        : strings.inches,
                                    style: const TextStyle(fontSize: 22.0),
                                  ),
                                ])
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
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _whtrResult,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _whtrInterpretation,
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
                      label: const Text("Calculate WHtR",
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
                insetPadding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                title: const Text(strings.resultInterpretation),
                content: const SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize
                        .min, //this is here to make my column fit inside the alert dialog
                    children: <Widget>[
                      Text(strings.whtrDefinition),
                      Text("\n"),
                      Text(strings.whtrInterpretation),
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
