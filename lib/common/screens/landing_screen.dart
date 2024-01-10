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
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                label: const Text(strings.getStarted)),
          ),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
