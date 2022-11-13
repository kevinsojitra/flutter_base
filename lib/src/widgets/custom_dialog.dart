import 'package:flutter/material.dart';

class CustomProgressDialog  extends StatelessWidget {

  const CustomProgressDialog({
    Key? key,
    required this.child,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.shape,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// The duration of the animation to show when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to 100 milliseconds.
  final Duration insetAnimationDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to [Curves.fastOutSlowIn].
  final Curve insetAnimationCurve;

  /// {@template flutter.material.dialog.shape}
  /// The shape of this dialog's border.
  ///
  /// Defines the dialog's [Material.shape].
  ///
  /// The default shape is a [RoundedRectangleBorder] with a radius of 2.0.
  /// {@endtemplate}
  final ShapeBorder? shape;

  Color _getColor(BuildContext context) {
    return Theme.of(context).dialogBackgroundColor;
  }

  static const RoundedRectangleBorder _defaultDialogShape =
  RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)));

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets +
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
        duration: insetAnimationDuration,
        curve: insetAnimationCurve,
        child: MediaQuery.removeViewInsets(
          removeLeft: true,
          removeTop: true,
          removeRight: true,
          removeBottom: true,
          context: context,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Material(
                elevation: 24.0,
                color: _getColor(context),
                type: MaterialType.card,
                shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
