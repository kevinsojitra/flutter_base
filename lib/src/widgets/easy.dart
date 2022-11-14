part of '../core/show.dart';

class Easy extends StatefulWidget {
  const Easy({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<Easy> createState() => _EasyState();
}

class _EasyState extends State<Easy> {
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
