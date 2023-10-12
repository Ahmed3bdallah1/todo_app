import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:todo/Authorize/controllers/auth/auth_controller.dart';

// import 'package:todo/Authorize/controllers/auth/otp_page.dart';
import 'package:todo/Authorize/controllers/providers/code_provider.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/widgets/reused/app_style.dart';
import 'package:todo/widgets/reused/reusable_text.dart';
import 'package:todo/widgets/tiles_widgets/dialog.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  static const route = 'login_page';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends ConsumerState<LoginPage> {
  final numberController = TextEditingController();
  Country country = Country(
      phoneCode: '20',
      countryCode: 'eg',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'EGYPT',
      example: 'EGYPT',
      displayName: 'Egypt',
      displayNameNoCountryCode: 'EG',
      e164Key: '');

  sendCodeToUser() {
    if (numberController.text.isEmpty) {
      return showAlertDialog(
          context: context, message: "please enter your number");
    } else if (numberController.length <= 9) {
      return showAlertDialog(
          context: context, message: "please enter a valid number");
    } else {
      print("else");
      print("+${country.phoneCode}${numberController.text}");
      ref.read(authControllerProvider).sendSms(
          context: context,
          phone: "+${country.phoneCode}${numberController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Image.asset('assets/list-icon-1423.png', height: 250 ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                child: ReusableText(
                    text: 'Enter your number',
                    textStyle: appStyle(15, Constants.kLight, FontWeight.bold)),
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: numberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              countryListTheme: CountryListThemeData(
                                backgroundColor:
                                    Constants.kLight.withOpacity(.8),
                                bottomSheetHeight: Constants.kHeight * .7,
                              ),
                              onSelect: (code) {
                                setState(() {
                                  country = code;
                                });
                                ref
                                    .read(codeStateProvider.notifier)
                                    .setState(code.phoneCode);
                                // print(ref.read(codeStateProvider));
                              });
                        },
                        child: ReusableText(
                          text: '${country.flagEmoji} +${country.phoneCode}',
                          textStyle:
                              appStyle(15, Colors.white, FontWeight.normal),
                        ),
                      ),
                    ),
                    labelText: 'enter phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  sendCodeToUser();
                },
                child: Container(
                  height: Constants.kHeight * .08,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white)),
                  child: Center(
                    child: Text(
                      'send OTP code',
                      style: appStyle(16, Constants.kLight, FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                  "-please make sure that you are connected when press send otp",
                  style: appStyle(8, Colors.white, FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
