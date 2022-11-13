import 'package:flutter/material.dart';

extension GoTo on BuildContext {
  //PUSH
  Future<T?> push<T>(Widget child) {
    return Navigator.push<T>(
        this,
        MaterialPageRoute<T>(
          builder: (context) => child,
        ));
  }

  //REPLACE
  pushReplacement(Widget child) {
    Navigator.pushReplacement(
        this,
        MaterialPageRoute(
          builder: (context) => child,
        ));
  }

  //PUSH AND REPLACE
  pushAndRemoveUntil(Widget child) {
    Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (context) => widget),
        (Route<dynamic> route) => false);
  }

  //POP
  pop({Object? value}) {
    Navigator.of(
      this,
      rootNavigator: true,
    ).pop(value);
  }
}
