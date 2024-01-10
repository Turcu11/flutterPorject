import 'package:flutter/material.dart';

import '../strings/strings.dart' as strings;
import '../themes/themes.dart' as themes;
import '../screens/main_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themes.MyAppColors.darkBlue,
        title: const Text(strings.appTitle),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 100.0,
            )),
            SizedBox(
              height: 25.0,
            ),
            Text(
              strings.appWelcome,
              // ignore: deprecated_member_use
              textScaleFactor: 2,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: ElevatedButton.icon(
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(200, 50)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
                const Tooltip(
                  message: 'Go to the next screen',
                );
              },
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.red,
                size: 20.0,
              ),
              label: const Text(
                strings.getStarted,
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
