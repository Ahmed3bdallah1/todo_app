import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/widgets/reused/app_style.dart';
import 'package:todo/widgets/reused/reusable_text.dart';

showAlertDialog({
  required BuildContext context,
  required String message,
  String? text,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: ReusableText(
            text: message,
            textStyle: appStyle(16, Colors.black, FontWeight.bold),
          ),
          contentPadding: const EdgeInsets.only(left: 10, right: 20, top: 10),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  text ?? 'ok',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        );
      });
}
