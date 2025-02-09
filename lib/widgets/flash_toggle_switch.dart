import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_on_off_pwm/bloc/flash_cubit/flash_cubit.dart';
import 'package:led_on_off_pwm/utilties/constants.dart';

class FlashToggleSwitch extends StatelessWidget {
  const FlashToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlashCubit, FlashState>(
      builder: (context, state) {
        return Container(
          width: Constants.kWidth,
          height: Constants.kHeight,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: state.isFlashing ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.isFlashing
                    ? '${Constants.kLabel} Flashing'
                    : '${Constants.kLabel} Off',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                value: state.isFlashing,
                onChanged: (_) {
                  context.read<FlashCubit>().toggleFlashing();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
