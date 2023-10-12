import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Authorize/controllers/auth/auth_repo.dart';

final authControllerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthController(authRepo: authRepo);
});

class AuthController {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  void verifiedOtp(
      {required BuildContext context,
      required String smsId,
      required String smsCode,
      required bool mounted}) {
    authRepo.verifiedOtp(
        context: context, smsId: smsId, smsCode: smsCode, mounted: mounted);
  }

  void sendSms({
    required BuildContext context,
    required String phone,
  }) {
    print("sended");
    authRepo.sendOtp(context: context, phoneNumber: phone);

  }
}
