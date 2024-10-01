import 'package:flutter/material.dart';

class KitchenCompanionApp extends StatelessWidget {
  const KitchenCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitchen Companion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: Scaffold(),
    );
  }
}
