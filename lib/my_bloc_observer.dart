import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver{
  @override
  void onCreate(BlocBase bloc) {
    debugPrint("=======================onCreate: $bloc");
    super.onCreate(bloc);
  }
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint("=======================Bloc: $bloc");
    debugPrint("=======================Change: $change");
super.onChange(bloc, change);
  }
  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint("=======================Bloc: $bloc");
    debugPrint("=======================Event: $event");
    super.onEvent(bloc, event);
  }
  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint("=======================Bloc: $bloc");
    debugPrint("=======================Transition: $transition");
    super.onTransition(bloc, transition);
  }
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint("=======================Bloc=======================: $bloc");
    debugPrint("=======================Error======================= $error");
    debugPrint("=======================StackTrace======================= $stackTrace");
    super.onError(bloc, error, stackTrace);
  }
  @override
  void onClose(BlocBase bloc) {
    debugPrint("=======================onClose: $bloc");
    super.onClose(bloc);
  }

}