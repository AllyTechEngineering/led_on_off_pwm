import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_on_off_pwm/bloc/flash_cubit/flash_cubit.dart';
import 'package:led_on_off_pwm/bloc/input_cubit/input_cubit.dart';
import 'package:led_on_off_pwm/bloc/on_off_cubit/on_off_cubit.dart';
import 'package:led_on_off_pwm/bloc/slider_cubit/slider_cubit.dart';
import 'package:led_on_off_pwm/screens/home_screen.dart';
import 'package:led_on_off_pwm/services/gpio_service.dart';
import 'package:led_on_off_pwm/services/pwm_service.dart';

void main() {
  final PwmService pwmService = PwmService();
  final GpioService gpioService = GpioService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SliderCubit(pwmService)),
        BlocProvider(create: (context) => OnOffCubit(gpioService, pwmService)),
        BlocProvider(create: (context) => InputCubit(gpioService)),
        BlocProvider(create: (context) => FlashCubit( gpioService)),
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
      debugShowCheckedModeBanner: false,
      title: 'LED Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  HomeScreen(),
    );
  }
}
