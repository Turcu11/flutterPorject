import 'package:flutter/material.dart';

import '../themes/themes.dart' as themes;
import '../strings/strings.dart' as strings;
import '../screens/bmi_screen.dart';
import '../screens/whtr_screen.dart';
import '../screens/bai_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routeName = '/main';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    BmiScreen(),
    WhtrScreen(),
    BaiScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<BottomNavigationBarItem> _bottomNavigationBarItems =
      <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.scale),
      label: strings.bodyMassIndex,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.height),
      label: strings.waistToHeightIndex,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.accessibility),
      label: strings.bodyAdiposityIndex,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Turcu BMI Calculator'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: themes.MyAppColors.contrastDarkBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}