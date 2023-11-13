import 'package:flutter/material.dart';

import 'package:tembo_nida_sdk/tembo_nida_sdk.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (_) {
      return Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () {
             startVerificationProcess(context);
            },
            child: const Text("Start NIDA Verification"),
          ),
        ),
      );
    });
  }
}
