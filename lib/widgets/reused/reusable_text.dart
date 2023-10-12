import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText({super.key, required this.text, required this.textStyle});

  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.end,
      softWrap: false,
      overflow: TextOverflow.fade,
      style: textStyle,
    );
  }
}
