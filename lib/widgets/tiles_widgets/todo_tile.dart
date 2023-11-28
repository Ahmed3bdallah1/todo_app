import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/widgets/reused/app_style.dart';
import 'package:todo/widgets/reused/reusable_text.dart';


//todo tile in the expansion tile

class TodoTile extends StatelessWidget {
  const TodoTile(
      {super.key,
      this.color,
      this.title,
      this.description,
      this.start,
      this.end,
      this.editWidget,
      this.delete, this.switcher});

  final Color? color;
  final String? title;
  final String? description;
  final String? start;
  final String? end;
  final Widget? editWidget;
  final Widget? switcher;
  final void Function()? delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.all(8.h),
        margin: EdgeInsets.all(8.h),
        width: Constants.kWidth,
        decoration: BoxDecoration(
            color: Constants.kBlueLight.withOpacity(.2),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              height: 90,
              width: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  //dynamic color later
                  color: color ?? Constants.kRed),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  // width: Constants.kWidth*.50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: title ?? "todo name",
                          textStyle: appStyle(
                              15, Constants.kLight, FontWeight.bold)),
                      const SizedBox(height: 5),
                      ReusableText(
                          text: description ?? "todo description",
                          textStyle: appStyle(
                              9, Constants.kLight, FontWeight.normal)),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: Constants.kWidth * .3,
                              height: 25.h,
                              // color: Constants.kLight.withOpacity(.3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: .6),
                              ),
                              child: Center(
                                  child: ReusableText(
                                      text: '$start - $end',
                                      textStyle: appStyle(
                                          12,
                                          Constants.kBlack,
                                          FontWeight.normal)))),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              SizedBox(
                                child: editWidget,
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: delete,
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Constants.kLight,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8,),
            Container(
              padding: EdgeInsets.only(bottom: 0.h),
              child: switcher,
            )
          ],
        ),
      ),
    );
  }
}
