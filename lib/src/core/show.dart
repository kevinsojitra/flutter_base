library flutter_base;

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:synchronized/synchronized.dart';

import '../widgets/custom_dialog.dart';

part '../widgets/easy.dart';

final LinkedHashMap<_EasyState, BuildContext> _contextMap =
    LinkedHashMap<_EasyState, BuildContext>();

typedef BuildContextPredicate = BuildContext Function(
  Iterable<BuildContext> list,
);

BuildContext _defaultContextPredicate(Iterable<BuildContext> list) {
  return list.first;
}

bool isProgressDismissed = true;
var lock = Lock();
//Alert Dialog
Future<bool?> showSKAlert(
  Widget msg, {
  Widget? title,
  Widget? confirmText,
  Widget? cancelText,
  bool isCancelable = true,
  BuildContext? context,
  BuildContextPredicate buildContextPredicate = _defaultContextPredicate,
}) {
  if (context == null) {
    _throwIfNoContext(_contextMap.values, 'showAlert');
  }
  context ??= buildContextPredicate(_contextMap.values);

  return showDialog<bool>(
    context: context,
    barrierDismissible: isCancelable,
    builder: (context) => AlertDialog(
      content: msg,
      title: title,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: confirmText ?? const Text("OK")),
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: cancelText ?? const Text("Cancel"))
      ],
    ),
  );
}

//Custom Dialog
Future<T?> showSKDialog<T>(
  Widget child, {
  bool isCancelable = true,
  BuildContext? context,
  BuildContextPredicate buildContextPredicate = _defaultContextPredicate,
}) {
  if (context == null) {
    _throwIfNoContext(_contextMap.values, 'showAlert');
  }
  context ??= buildContextPredicate(_contextMap.values);

  return showDialog<T>(
    context: context,
    barrierDismissible: isCancelable,
    builder: (context) => child,
  );
}

//Custom BOTTOM SHEET MODEL Dialog
Future<T?> showSKBottomSheetDialog<T>(
  Widget child, {
  bool isCancelable = true,
  BuildContext? context,
  RoundedRectangleBorder? shape,
  BuildContextPredicate buildContextPredicate = _defaultContextPredicate,
}) {
  if (context == null) {
    _throwIfNoContext(_contextMap.values, 'showAlert');
  }
  context ??= buildContextPredicate(_contextMap.values);

  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 100),
        curve: Curves.bounceOut,
        child: child,
      );
    },
    clipBehavior: Clip.hardEdge,
    shape: shape ??
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
  );
}

//PROGRESS DIALOG
showSKProgressDialog({
  BuildContext? context,
  RoundedRectangleBorder? shape,
  String? textToBeDisplayed,
  Color barrierColor = Colors.black12,
  BuildContextPredicate buildContextPredicate = _defaultContextPredicate,
}) {
  if (context == null) {
    _throwIfNoContext(_contextMap.values, 'showAlert');
  }
  context ??= buildContextPredicate(_contextMap.values);

  if (isProgressDismissed) {
    isProgressDismissed = false;
    showGeneralDialog<bool>(
      context: context,
      barrierColor: barrierColor,
      pageBuilder: (context, animation, secondaryAnimation) {
        return CustomProgressDialog(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withAlpha(20),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const CupertinoActivityIndicator(
                  radius: 15,
                ),
                textToBeDisplayed == null
                    ? const Padding(
                        padding: EdgeInsets.all(0),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          textToBeDisplayed,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ))
              ],
            ),
          ),
        );
      },
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 100),
    ).then(
      (dismissed) {
        isProgressDismissed = dismissed!;
      },
    );
  }
}

//DISMISS DIALOG
Future<void> dismissSKProgressDialog({
  BuildContext? context,
  BuildContextPredicate buildContextPredicate = _defaultContextPredicate,
}) async {
  if (context == null) {
    _throwIfNoContext(_contextMap.values, 'showAlert');
  }
  context ??= buildContextPredicate(_contextMap.values);

  await lock.synchronized(() async {
    if (isProgressDismissed) {
      return;
    }
    isProgressDismissed = true;
    Navigator.of(context!, rootNavigator: true).pop(true);
  });
}

void _throwIfNoContext(Iterable<BuildContext> contexts, String methodName) {
  if (contexts.isNotEmpty) {
    return;
  }
  final List<DiagnosticsNode> information = <DiagnosticsNode>[
    ErrorSummary('No Base widget found.'),
    ErrorDescription(
      '$methodName requires an Base widget ancestor '
      'for correct operation.',
    ),
    ErrorHint(
      'The most common way to add an Base to an application '
      'is to wrap a Base upon a WidgetsApp(MaterialApp/CupertinoApp).',
    ),
  ];
  throw FlutterError.fromParts(information);
}
