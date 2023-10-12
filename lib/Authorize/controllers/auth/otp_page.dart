import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:todo/Authorize/controllers/auth/auth_controller.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/widgets/reused/app_style.dart';
import 'package:todo/widgets/reused/reusable_text.dart';

class OtpPage extends ConsumerWidget {
  const OtpPage({super.key, required this.phone, required this.smsCodeId});

  final String phone;
  final String smsCodeId;

  void verifiction(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifiedOtp(
          context: context,
          smsId: smsCodeId,
          smsCode: smsCode,
          mounted: true,
        );
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/otp.png',
                  height: 250,
                  color: Constants.kBlueLight.withOpacity(.4),
                ),
                ReusableText(
                    text: 'put your OTP below',
                    textStyle: appStyle(15,
                        Constants.kBlueLight.withOpacity(.4), FontWeight.bold)),
                const SizedBox(
                  height: 20,
                ),
                Pinput(
                  length: 6,
                  showCursor: true,
                  onSubmitted: (value) {
                    if (value.length == 6) {
                      return verifiction(context, ref, value);
                    }
                  },
                  onCompleted: (value) {
                    if (value.length == 6) {
                      return verifiction(context, ref, value);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
