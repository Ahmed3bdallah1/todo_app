import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo/features/onboard/welcome_page.dart';
import 'package:todo/features/onboard/second_page_after_onboard.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/widgets/reused/reusable_text.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: pageController,
            children: const [
              WelcomePage(),
              PageTwo(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.linear);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.navigate_next_outlined,
                          size: 30,
                          color: Constants.kLight,
                        ),
                        ReusableText(
                            text: 'skip',
                            textStyle:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ],
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect: const WormEffect(
                        dotHeight: 10,
                        dotWidth: 12,
                        dotColor: Constants.kGreen),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
