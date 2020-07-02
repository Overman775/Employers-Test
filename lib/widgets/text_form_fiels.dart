import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicTextFormDecorator extends StatelessWidget {
  final String label;
  final Widget child;

  const NeumorphicTextFormDecorator({this.label, this.child, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null) TextFieldLabel(label),
        Neumorphic(
          margin: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(context),
            boxShape: const NeumorphicBoxShape.stadium(),
          ),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
          child: child,
        )
      ],
    );
  }
}

class TextFieldLabel extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry padding;

  const TextFieldLabel(
    this.label, {
    Key key,
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: NeumorphicTheme.defaultTextColor(context),
        ),
      ),
    );
  }
}
