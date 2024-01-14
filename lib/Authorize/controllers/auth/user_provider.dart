import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/Authorize/db/db_helper.dart';
import 'package:todo/utilties/user_model.dart';

final userProvider = StateNotifierProvider<UserState, List<UserModel>>(
  (ref) {
    return UserState();
  },
);

class UserState extends StateNotifier<List<UserModel>> {
  UserState() : super([]);

  void refresh() async {
    final data = await DbHelper.getUser();

    state = data.map((e) => UserModel.fromJson(e)).toList();
  }
}
