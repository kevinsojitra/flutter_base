import 'package:example/nested.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/easy_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
            onPressed: () {
              context.push(const Nest());
            },
            icon: const Icon(Icons.add)),
      ),
    );
  }
}
