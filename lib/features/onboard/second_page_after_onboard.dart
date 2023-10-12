import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/Authorize/controllers/routes.dart';
import 'package:todo/utilties/constants.dart';

import '../../widgets/reused/app_style.dart';
// import '../../widgets/reused/reusable_text.dart';
import 'login_page.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

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
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () {
              print("pressed");
              Navigator.pushReplacementNamed(context, Routes.login);
            },
            child: Container(
              height: Constants.kHeight * .08,
              width: Constants.kWidth * .9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white)),
              child: Center(
                  child: Text(
                'login via mobile phone',
                style: appStyle(16, Colors.white, FontWeight.normal),
              )),
            ),
          )
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     ReusableText(
          //         text: 'Todo app',
          //         textStyle: appStyle(25, Constants.kBlueDark.withOpacity(.9),
          //             FontWeight.bold)),
          //     const SizedBox(
          //       height: 10,
          //     ),
          //     ReusableText(
          //       text: 'welcome to our app click skip to continue',
          //       textStyle: appStyle(12, Constants.kLight, FontWeight.normal),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
