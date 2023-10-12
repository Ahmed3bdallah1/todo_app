import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'expansion_provider.g.dart';


@riverpod
class Expansion extends _$Expansion{

  @override
  bool build(){
    return false;
  }

  void setState(bool newState){
    state=newState;
  }
}


@riverpod
class Expansion2 extends _$Expansion2{

  @override
  bool build(){
    return false;
  }

  void setState(bool newState){
    state=newState;
  }
}

@riverpod
class Expansion3 extends _$Expansion3{

  @override
  bool build(){
    return false;
  }

  void setState(bool newState){
    state=newState;
  }
}