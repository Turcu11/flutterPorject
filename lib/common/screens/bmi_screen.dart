import 'package:flutter/material.dart';
import '../strings/strings.dart' as strings;

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  String _measuringSystem = 'Metric'; // Initial value to avoid null
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _massController = TextEditingController();

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
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Metric'),
                  Radio<String>(
                    value: 'Metric',
                    groupValue: _measuringSystem,
                    onChanged: (String? value) {
                      setState(() {
                        _measuringSystem = value!;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Text('Imperial'),
                  Radio<String>(
                    value: 'Imperial',
                    groupValue: _measuringSystem,
                    onChanged: (String? value) {
                      setState(() {
                        _measuringSystem = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Height'),
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
                  Text(_measuringSystem == 'Metric' ? 'cm' : 'in'),
                  const SizedBox(
                    height: 30,
                  ),
                  
                  const Text('Wheight'),
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
                  Text(_measuringSystem == 'Metric' ? 'kg' : 'lb'),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
