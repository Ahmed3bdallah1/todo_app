import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Authorize/controllers/auth/user_controller.dart';
import 'package:todo/features/onboard/dashboard_home.dart';
import 'package:todo/features/onboard/onboard_screen.dart';

import '../../../utilties/user_model.dart';

class AuthCheck extends ConsumerWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userProvider.notifier).refresh();
    List<UserModel> users = ref.watch(userProvider);
    return users.isEmpty ? const OnBoard() : const HomeScreen();
  }
}
