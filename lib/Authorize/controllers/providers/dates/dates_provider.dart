import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dates_provider.g.dart';


@riverpod
class DateState extends _$DateState{

  @override
  String build(){
    return "";
  }

  void setState(String newState){
    state=newState;
  }
}
@riverpod
class StartTimeState extends _$StartTimeState{

  @override
  String build(){
    return "";
  }

  void setState(String newState){
    state=newState;
  }

  List<int> dates(DateTime start){
    DateTime now=DateTime.now();

    Duration duration = start.difference(now);
    int days=duration.inDays;
    int hours=duration.inHours%24;
    int mins=duration.inMinutes%60;
    int seconds=duration.inSeconds%60;
    return [days,hours,mins,seconds];
  }
}

@riverpod
class FinishTimeState extends _$FinishTimeState{

  @override
  String build(){
    return "";
  }

  void setState(String newState){
    state=newState;
  }
}