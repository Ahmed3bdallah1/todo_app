import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dates_provider.g.dart';

@riverpod
class DateState extends _$DateState {
  @override
  String build() {
    return "";
  }

  void setState(String newState) {
    state = newState;
  }
}

@riverpod
class StartTimeState extends _$StartTimeState {
  @override
  String build() {
    return "";
  }

  void setState(String newState) {
    state = newState;
  }

  int inSecondsNotificationDate(DateTime start) {
    DateTime now = DateTime.now();

    Duration duration = start.difference(now);
    // int days = duration.inDays;
    // int hours = duration.inHours % 24;
    int mins = duration.inMinutes;
    // int seconds = duration.inSeconds;
    print(mins.toString());
    return mins;
  }
}

@riverpod
class FinishTimeState extends _$FinishTimeState {
  @override
  String build() {
    return "";
  }

  void setState(String newState) {
    state = newState;
  }
}
