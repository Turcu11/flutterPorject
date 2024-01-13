import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../strings/strings.dart' as strings;

class BaiScreen extends StatefulWidget {
  const BaiScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BaiScreenState createState() => _BaiScreenState();
}

class _BaiScreenState extends State<BaiScreen> {
  String _measuringSystem = 'Metric'; // Initial value to avoid null
  String _userGender = 'Male'; // Initial value to avoid null
  String _userAge = '20-39'; // Initial value to avoid null
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();
  String _baiResult = '';
  String _baiInterpretation = '';

  void generateMaleInterpretation(double bai) {
    if (_userAge == '20-39') {
      if (bai < 8) {
        _baiInterpretation = 'Underweight';
      } else if (bai >= 8 && bai < 21) {
        _baiInterpretation = 'Normal';
      } else if (bai >= 21 && bai < 26) {
        _baiInterpretation = 'Overweight';
      } else if (bai >= 26 && bai < 31) {
        _baiInterpretation = 'Obese';
      } else if (bai >= 31) {
        _baiInterpretation = 'Extremely Obese';
      }
    } else if (_userAge == '40-59') {
      if (bai < 11) {
        _baiInterpretation = 'Underweight';
      } else if (bai >= 11 && bai < 23) {
        _baiInterpretation = 'Normal';
      } else if (bai >= 23 && bai < 29) {
        _baiInterpretation = 'Overweight';
      } else if (bai >= 29 && bai < 35) {
        _baiInterpretation = 'Obese';
      } else if (bai >= 35) {
        _baiInterpretation = 'Extremely Obese';
      }
    } else if (_userAge == '60-79') {
      if (bai < 13) {
        _baiInterpretation = 'Underweight';
      } else if (bai >= 13 && bai < 25) {
        _baiInterpretation = 'Normal';
      } else if (bai >= 25 && bai < 31) {
        _baiInterpretation = 'Overweight';
      } else if (bai >= 31 && bai < 37) {
        _baiInterpretation = 'Obese';
      } else if (bai >= 37) {
        _baiInterpretation = 'Extremely Obese';
      }
    }
  }

  void generateFemaleInterpretation(double bai) {
    if (_userAge == '20-39') {
      if (bai < 21) {
        _baiInterpretation = 'Underweight';
      } else if (bai >= 21 && bai < 33) {
        _baiInterpretation = 'Normal';
      } else if (bai >= 33 && bai < 39) {
        _baiInterpretation = 'Overweight';
      } else if (bai >= 39 && bai < 43) {
        _baiInterpretation = 'Obese';
      } else if (bai >= 43) {
        _baiInterpretation = 'Extremely Obese';
      }
    } else if (_userAge == '40-59') {
      if (bai < 23) {
        _baiInterpretation = 'Underweight';
      } else if (bai >= 23 && bai < 35) {
        _baiInterpretation = 'Normal';
      } else if (bai >= 35 && bai < 41) {
        _baiInterpretation = 'Overweight';
      } else if (bai >= 41 && bai < 45) {
        _baiInterpretation = 'Obese';
      } else if (bai >= 45) {
        _baiInterpretation = 'Extremely Obese';
      }
    } else if (_userAge == '60-79') {
      if (bai < 25) {
        _baiInterpretation = 'Underweight';
      } else if (bai >= 25 && bai < 38) {
        _baiInterpretation = 'Normal';
      } else if (bai >= 38 && bai < 43) {
        _baiInterpretation = 'Overweight';
      } else if (bai >= 43 && bai < 47) {
        _baiInterpretation = 'Obese';
      } else if (bai >= 47) {
        _baiInterpretation = 'Extremely Obese';
      }
    }
  }

  double calculateMetricBAI(double height, double hip) {
    double heightInMeters = height / 100;
    return (hip / (math.pow(heightInMeters, 1.5))) - 18;
  }

  double calculateImperialBAI(double height, double hip) {
    height = height * 2.54;
    hip = hip * 2.54;
    double heightInMeters = height / 100;
    return (hip / (math.pow(heightInMeters, 1.5))) - 18;
  }

  void calculateBMI() {
    String heightText = _heightController.text;
    String hipText = _hipController.text;

    if (heightText.isEmpty || hipText.isEmpty) {
      _baiResult = 'Please enter both height and hips.';
    } else if (!isNumeric(heightText) || !isNumeric(hipText)) {
      _baiResult = 'Please enter valid numbers.';
    } else {
      double height = double.parse(heightText);
      double hip = double.parse(hipText);
      double bai;

      if (_measuringSystem == 'Metric') {
        bai = calculateMetricBAI(height, hip);
        if(_userGender == 'Male'){
          generateMaleInterpretation(bai);
        }
      } else {
        bai = calculateImperialBAI(height, hip);
      }

      _baiResult = 'Your BAI is ${bai.toStringAsFixed(2)}%';
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
              strings.baiTitle,
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
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
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
                        ],
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Column(
                        children: <Widget>[
                          const Text(strings.baiPleaseSelectAge),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(strings.baiAge20to39),
                          Radio<String>(
                            value: strings.baiAge20to39,
                            groupValue: _userAge,
                            onChanged: (String? value) {
                              setState(() {
                                _userAge = value!;
                              });
                            },
                          ),
                          const Text(strings.baiAge40to59),
                          Radio<String>(
                            value: strings.baiAge40to59,
                            groupValue: _userAge,
                            onChanged: (String? value) {
                              setState(() {
                                _userAge = value!;
                              });
                            },
                          ),
                          const Text(strings.baiAge60to79),
                          Radio<String>(
                            value: strings.baiAge60to79,
                            groupValue: _userAge,
                            onChanged: (String? value) {
                              setState(() {
                                _userAge = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Column(
                        children: <Widget>[
                          const Text(strings.male),
                          Radio<String>(
                            value: strings.male,
                            groupValue: _userGender,
                            onChanged: (String? value) {
                              setState(() {
                                _userGender = value!;
                              });
                            },
                          ),
                          const Text(strings.female),
                          Radio<String>(
                            value: strings.female,
                            groupValue: _userGender,
                            onChanged: (String? value) {
                              setState(() {
                                _userGender = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
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
                              width: 80,
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
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                          width: 50,
                        ),
                        Column(
                          children: <Widget>[
                            const Text(
                              strings.hips,
                              style: TextStyle(fontSize: 28.0),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextField(
                                controller: _hipController,
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
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  'Result: ',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _baiResult,
                  style: const TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  onPressed: () => calculateBMI(),
                  icon: const Icon(Icons.calculate),
                  label: const Text("Calculate BAI"),
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
                  mainAxisSize: MainAxisSize
                      .min, //this is here to make my column fit inside the alert dialog
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
