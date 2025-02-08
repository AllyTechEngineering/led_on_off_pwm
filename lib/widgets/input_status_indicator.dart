import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_on_off_pwm/bloc/input_cubit/input_cubit.dart';

class InputStatusIndicator extends StatelessWidget {
  const InputStatusIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputCubit, InputState>(
      builder: (context, state) {
        bool isDetected = state.isInputDetected;
        return Container(
          width: 200.0,
          height: 150.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isDetected ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            isDetected ? "Input Detected True" : "Input Detected False",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
