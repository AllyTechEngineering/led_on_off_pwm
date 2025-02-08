import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_on_off_pwm/bloc/slider_cubit/slider_cubit.dart';
import 'package:led_on_off_pwm/services/pwm_service.dart';
import 'package:led_on_off_pwm/utilties/constants.dart';
import 'package:led_on_off_pwm/widgets/input_status_indicator.dart';
import 'package:led_on_off_pwm/widgets/slide_switch.dart';
import 'package:led_on_off_pwm/widgets/toggle_switch.dart';

class HomeScreen extends StatelessWidget {
  final Constants constants = Constants();
   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SliderCubit(PwmService()),
      child: Scaffold(
        appBar: AppBar(title: Text(Constants.kTitle), centerTitle: true),
        body: Center(
          child: SizedBox(
            width: 800, // Keep UI centered and constrained
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Vertical PWM Speed Slider (Left Side) with increased height
                SizedBox(
                  width: 100.0, // Keep slider narrow
                  height: 300.0, // Match the combined switch height
                  child:  SlideSwitch(vertical: true),
                ),

                // Space between slider and switches
                const SizedBox(width: 40),

                // Column for Direction and Power Switches (Right Side)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    ToggleSwitch(),
                    SizedBox(height: 20),
                    InputStatusIndicator(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
