import 'package:flutter/material.dart';

void main() {
    runApp(const KitchenCompanionApp());
}

class KitchenCompanionApp extends StatelessWidget {
    const KitchenCompanionApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                    title: const Text('Kitchen Companion'),
                ),
                body: const Center(
                    child: Text(
                        'Hello World!',
                    ),
                )
            ),
        );
    }
}
