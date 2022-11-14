import 'package:flutter/material.dart';
import 'package:flutter_base/easy_flutter.dart';
class Nest extends StatefulWidget {
  const Nest({Key? key}) : super(key: key);

  @override
  State<Nest> createState() => _NestState();
}

class _NestState extends State<Nest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: IconButton(onPressed: () {
          showSKProgressDialog();
           Future.delayed(const Duration(seconds: 5), () {
             dismissSKProgressDialog();
          });
        }, icon: const Icon(Icons.add,color: Colors.white,)),
      ),
    );
  }
}
