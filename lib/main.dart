import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/view/screens/get_started_screen.dart';
import 'cubits/get_weather_cubit.dart';
import 'my_bloc_observer.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => GetWeatherCubit())],
      child: ScreenUtilInit(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          home: GetStartedScreen(),
        ),
      ),
    );
  }
}
