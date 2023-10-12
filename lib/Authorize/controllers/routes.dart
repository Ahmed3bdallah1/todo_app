import 'package:flutter/material.dart';
import 'package:todo/Authorize/controllers/auth/otp_page.dart';
import 'package:todo/features/onboard/login_page.dart';
import 'package:todo/features/onboard/onboard_screen.dart';
import 'package:todo/features/onboard/dashboard_home.dart';

class Routes {
  static const String home = "home_page";
  static const String otp = "otp";
  static const String login = "login";
  static const String onboard = "onboard";

  static Route<dynamic> onGenerated(RouteSettings settings) {
    switch (settings.name) {
      case onboard:
        return MaterialPageRoute(builder: (_) => const OnBoard());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case otp:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => OtpPage(
                  phone: args['phone'],
                  smsCodeId: args['smsCodeId'],
                ));

      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());


      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
