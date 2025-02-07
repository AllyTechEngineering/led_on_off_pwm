import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_on_off_pwm/bloc/on_off_cubit/on_off_cubit.dart';
import 'package:led_on_off_pwm/bloc/slider_cubit/slider_cubit.dart';
import 'package:led_on_off_pwm/screens/home_screen.dart';
import 'package:led_on_off_pwm/services/pwm_service.dart';

void main() {
  final PwmService pwmService = PwmService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SliderCubit(pwmService)),
        BlocProvider(create: (context) => OnOffCubit(pwmService)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LED Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
