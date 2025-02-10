import 'package:flutter/material.dart';
import 'package:led_on_off_pwm/utilties/constants.dart';
import 'package:led_on_off_pwm/widgets/input_status_indicator.dart';
import 'package:led_on_off_pwm/widgets/slide_switch.dart';
import 'package:led_on_off_pwm/widgets/flash_toggle_switch.dart';
import 'package:led_on_off_pwm/widgets/toggle_switch.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Constants.kTitle), centerTitle: true),
      body: Center(
        child: SizedBox(
          width: Constants.kSizedBoxWidth, // Adjusted width to accommodate the new switch
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              // Left side: Flash LED switch
              FlashToggleSwitch(),

              const SizedBox(width: 20), // Space between sliders
              // Middle: Vertical PWM Speed Slider
              SizedBox(
                width: 100.0,
                height: 300.0,
                child: SlideSwitch(vertical: true),
              ),

              const SizedBox(width: 40), // Space between slider and switches
              // Right: Column for Direction and Power Switches
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleSwitch(),
                  SizedBox(height: 20),
                  InputStatusIndicator(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
