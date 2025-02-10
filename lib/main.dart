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

  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding before using lifecycle observer

  runApp(MyApp(pwmService: pwmService, gpioService: gpioService));
}

class MyApp extends StatefulWidget {
  final PwmService pwmService;
  final GpioService gpioService;

  const MyApp({super.key, required this.pwmService, required this.gpioService});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.pwmService.dispose();
    widget.gpioService.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached || state == AppLifecycleState.inactive) {
      widget.pwmService.dispose();
      widget.gpioService.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SliderCubit(widget.pwmService)),
        BlocProvider(create: (context) => OnOffCubit(widget.gpioService, widget.pwmService)),
        BlocProvider(create: (context) => InputCubit(widget.gpioService)),
        BlocProvider(create: (context) => FlashCubit(widget.gpioService)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LED Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}