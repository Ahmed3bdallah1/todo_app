import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/widgets/reused/app_style.dart';
import 'package:todo/widgets/reused/reusable_text.dart';

import '../../Authorize/controllers/providers/todo/todo_tile_provider.dart';

class Titles extends StatelessWidget {
  const Titles(
      {super.key, required this.text, required this.text2, this.color});

  final String text;
  final String text2;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Constants.kWidth,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  dynamic color= ref.read(todoStateProvider.notifier).getDynamicColor();
                  return Container(
                    height: 90,
                    width: 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        //dynamic color later
                        color: color),
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                      text: text,
                      textStyle:
                          appStyle(20, Constants.kBlack, FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  ReusableText(
                      text: text2,
                      textStyle:
                          appStyle(10, Constants.kBlack, FontWeight.normal)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
