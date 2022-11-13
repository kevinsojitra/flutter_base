import 'package:flutter/material.dart';

import 'package:flutter_base/flutter_base.dart';
import 'home.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Base(child: Home()),
    );
  }
}
