import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/widgets/reused/app_style.dart';
import 'package:todo/widgets/reused/reusable_text.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.kHeight,
      width: Constants.kWidth,
      color: Constants.kBlueDark.withOpacity(.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Image.asset('assets/list-icon-1423.png'),
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableText(
                  text: 'Todo app',
                  textStyle: appStyle(25, Constants.kBlueDark.withOpacity(.9),
                      FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              ReusableText(
                text: 'welcome to our app click skip to continue',
                textStyle: appStyle(12, Constants.kLight, FontWeight.normal),
              ),
            ],
          )
        ],
      ),
    );
  }
}
