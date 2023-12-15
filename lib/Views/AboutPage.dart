import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("About")),
      body: const Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                  "Welcome to Dylan Hallila's Star Wars app, a mobile application that makes use of the SWAPI to display information about any Star Wars character of your choice. Finding stats about your favorite characters has never been easier. Simply log in and make your selection, and be transported to a galaxy far, far away.\n\nDeveloped by Dylan Hallila for CMSC 2204.",
                  style: TextStyle(fontSize: 25)))
        ],
      ),
    );
  }
}
