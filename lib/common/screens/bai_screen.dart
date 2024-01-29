// Importing necessary libraries and packages
import 'package:flutter/material.dart';
import 'dart:math' as math;

// Importing custom strings
import '../strings/strings.dart' as strings;

// BaiScreen is a StatefulWidget, which means it can maintain state that can change over time.
class BaiScreen extends StatefulWidget {
  // Constructor for the BaiScreen widget. The 'key' argument is optional and is used for identifying widgets in 
  // Flutter's widget tree. It is passed to the superclass constructor.
  const BaiScreen({Key? key}) : super(key: key);

  // The createState method is called when Flutter needs to create a new mutable state for this widget.
  @override
  _BaiScreenState createState() => _BaiScreenState();
}

// _BaiScreenState is the mutable state for a BaiScreen widget.
class _BaiScreenState extends State<BaiScreen> {
  // _measuringSystem, _userGender, and _userAge are strings that store the current measuring system, user gender, 
  // and user age. They are initially set to avoid null.
  String _measuringSystem = 'Metric';
  String _userGender = 'Male';
  String _userAge = '20-39';

  // _heightController and _hipController are text editing controllers that control the text in a TextField.
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();

  // _baiResult and _baiInterpretation are strings that store the result and interpretation of the BAI calculation.
  String _baiResult = '';
  String _baiInterpretation = '';

  // generateMaleInterpretation is a method that generates a BAI interpretation based on a given BAI for male users.
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

  // calculateMetricBAI is a method that calculates the Body Adiposity Index (BAI) using the metric system.
  double calculateMetricBAI(double height, double hip) {
    // Convert height from cm to meters
    double heightInMeters = height / 100;
    // Calculate BAI using the formula: (hip / (height ^ 1.5)) - 18
    return (hip / (math.pow(heightInMeters, 1.5))) - 18;
  }

  // calculateImperialBAI is a method that calculates the BAI using the imperial system.
  double calculateImperialBAI(double height, double hip) {
    // Convert height and hip from inches to cm
    height = height * 2.54;
    hip = hip * 2.54;
    // Convert height from cm to meters
    double heightInMeters = height / 100;
    // Calculate BAI using the formula: (hip / (height ^ 1.5)) - 18
    return (hip / (math.pow(heightInMeters, 1.5))) - 18;
  }

  // calculateBMI is a method that calculates the BAI and generates the interpretation.
  void calculateBMI() {
    // Get the text from the height and hip TextFields
    String heightText = _heightController.text;
    String hipText = _hipController.text;

    // Check if either of the TextFields is empty
    if (heightText.isEmpty || hipText.isEmpty) {
      _baiResult = 'Please enter both height and hips.';
    } 
    // Check if the entered values are valid numbers
    else if (!isNumeric(heightText) || !isNumeric(hipText)) {
      _baiResult = 'Please enter valid numbers.';
    } 
    else {
      // Parse the height and hip values to double
      double height = double.parse(heightText);
      double hip = double.parse(hipText);
      double bai;

      // Calculate BAI based on the selected measuring system
      if (_measuringSystem == 'Metric') {
        bai = calculateMetricBAI(height, hip);
        // Generate BAI interpretation based on the user's gender
        if (_userGender == 'Male') {
          generateMaleInterpretation(bai);
        } else {
          generateFemaleInterpretation(bai);
        }
      } else {
        bai = calculateImperialBAI(height, hip);
        // Generate BAI interpretation based on the user's gender
        if (_userGender == 'Male') {
          generateMaleInterpretation(bai);
        } else {
          generateFemaleInterpretation(bai);
        }
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
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
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
                            width: 30,
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
                            width: 30,
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
                      height: 40,
                    ),
                    SingleChildScrollView(
                      child: Column(
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
                                    _measuringSystem == strings.metric
                                        ? strings.cm
                                        : strings.inches,
                                    style: const TextStyle(fontSize: 22.0),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
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
                      _baiResult,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _baiInterpretation,
                      style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(250, 60),
                      ),
                      onPressed: () => calculateBMI(),
                      icon: const Icon(Icons.calculate),
                      label: const Text("Calculate BAI",
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
        child: const Icon(Icons.help_outline_outlined),
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
                      Text(strings.baiDefinition),
                      Text("\n"),
                      Text(strings.baiInterpretation),
                      Text(
                        strings.baiDisclaimer,
                        style: TextStyle(fontSize: 10.0),
                        textAlign: TextAlign.center,
                      ),
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
