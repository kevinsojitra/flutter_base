part of '../core/show.dart';

class Base extends StatefulWidget {
  const Base({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  @override
  void dispose() {
    _contextMap.remove(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    _contextMap[this] = ctx;
    return widget.child;
  }
}
