import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo/Authorize/controllers/auth/otp_page.dart';
import 'package:todo/Authorize/controllers/routes.dart';
import 'package:todo/Authorize/db/db_helper.dart';
import 'package:todo/widgets/tiles_widgets/dialog.dart';

final authRepoProvider = Provider((ref) {
  return AuthRepo(auth: FirebaseAuth.instance);
});

class AuthRepo {
  final FirebaseAuth auth;

  AuthRepo({required this.auth});

  void verifiedOtp(
      {required BuildContext context,
      required String smsId,
      required String smsCode,
      required bool mounted}) async {
    try {
      final credential =
          PhoneAuthProvider.credential(verificationId: smsId, smsCode: smsCode);

      await auth.signInWithCredential(credential);
      if (!mounted) {
        return;
      }
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    } on FirebaseAuth catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void sendOtp(
      {required BuildContext context, required String phoneNumber}) async {
    try {


      print("entered");
       await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            if(e.code == 'invalid-phone-number') {
              showAlertDialog(context: context, message: e.toString());
            }else{
              print(e.toString());
              showAlertDialog(context: context, message: 'error');
            }
          },
          codeSent: (codeId, resendCode) {
            DbHelper.createUser(1);
            Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.otp,
                arguments: {
                  "phone": phoneNumber,
                  "smsCodeId": codeId,
                },
                (route) => false);
          },
          codeAutoRetrievalTimeout: (String smsCodeId) {});
    } on FirebaseAuth catch (e) {
      print(e.toString());
      showAlertDialog(context: context, message: e.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
