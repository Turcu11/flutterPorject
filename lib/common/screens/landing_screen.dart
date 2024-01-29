// Importing necessary libraries and packages
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Importing custom strings and screens
import '../strings/strings.dart' as strings;
import '../screens/main_screen.dart';

// This is a stateless widget, meaning it describes part of the user interface which can depend on configuration 
// and state information but does not itself store any state.
class LandingScreen extends StatelessWidget {
  // Constructor for the LandingScreen widget. The 'key' argument is optional and is used for identifying widgets in 
  // Flutter's widget tree. It is passed to the superclass constructor.
  const LandingScreen({super.key});

  // The build method is called every time Flutter needs to render this widget.
  // It returns a Widget that describes what this widget's part of the user interface should look like given its 
  // current configuration and state.
  @override
  Widget build(BuildContext context) {
    // Scaffold is a widget from Material library that provides a default app bar, title, and a body property that 
    // holds the main widget tree. It can also include drawers, snack bars, and bottom sheets.
    return Scaffold(
      // AppBar is a widget that holds the toolbar and other widgets, such as a TabBar and a FlexibleSpaceBar.
      appBar: AppBar(
        // The leading widget is typically an Icon or an IconButton that the user can interact with.
        leading: const Icon(
          Icons.speed,
          color: Colors.red,
        ),
        // The title widget is typically a Text widget that contains a description of the current contents of the app bar.
        title: const Text(strings.appTitle),
        // Actions are identified as an array of widgets that are typically IconButtons representing common operations.
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.info_outline_rounded,
              color: Colors.red,
            ),
            // The onPressed function is called when the IconButton is pressed.
            onPressed: () {
              // showDialog function here is used to show an AlertDialog widget.
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(strings.about),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(strings.createdBy),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextButton(
                        onPressed: () async {
                          const urlString =
                              'https://www.linkedin.com/in/iosif-turcu-9353b6225/';
                          Uri url = Uri.parse(urlString);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw 'Could not launch $urlString';
                          }
                        },
                        child: const Text('Visit LinkedIn'),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(strings.creatorsMessage),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
                child: Icon(
              Icons.favorite,
              color: Colors.red,
              size: 100.0,
            )),
            const SizedBox(
              height: 25.0,
            ),
            const Text(
              strings.appWelcome,
              textAlign: TextAlign.center,
              // ignore: deprecated_member_use
              textScaleFactor: 2,
            ),
            const SizedBox(
              height: 25.0,
            ),
            Container(
              padding: const EdgeInsets.all(45.0),
              child: const Text(
                strings.appDescription,
                // ignore: deprecated_member_use
                textScaleFactor: 1.2,
                textAlign: TextAlign.center,
              ),
            )
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
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
                const Tooltip(
                  message: 'Start',
                );
              },
              icon: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.red,
                size: 28.0,
              ),
              label: Text(
                strings.getStarted,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color,
                ),
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
