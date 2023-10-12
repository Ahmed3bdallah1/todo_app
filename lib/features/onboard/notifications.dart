import 'package:flutter/material.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/widgets/reused/app_style.dart';
import 'package:todo/widgets/reused/reusable_text.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key, this.load});
  final String? load;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: Constants.kWidth,
              height: Constants.kHeight * .6,
              decoration: BoxDecoration(
                color: Constants.kBlueDark.withOpacity(.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: "Reminder",
                        textStyle: appStyle(30, Colors.white, FontWeight.bold)),
                    const SizedBox(height: 10),
                    Container(
                      width: Constants.kWidth,
                      height: 30,
                      padding: const EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                          color: Constants.kBlueLight.withOpacity(.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ReusableText(
                              text: "Today's tasks",
                              textStyle:
                                  appStyle(15, Colors.white, FontWeight.bold)),
                          const SizedBox(width: 15),
                          ReusableText(
                              text: "From: start - to: end",
                              textStyle: appStyle(
                                  12, Colors.white, FontWeight.normal)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    ReusableText(
                        text: "Title:",
                        textStyle: appStyle(15, Colors.white, FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(
                      'aa',
                      maxLines: 1,
                      style: appStyle(12, Colors.white, FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              right: 30,
              top: -30,
              child: Image.asset('assets/bell2.png', width: 70)),
          Positioned(
              bottom: -Constants.kHeight * .2,
              child: Image.asset(
                'assets/reminder-2.png',
                color: Colors.white.withOpacity(.5),
                width: Constants.kWidth,
              )),
        ],
      ),
    );
  }
}
