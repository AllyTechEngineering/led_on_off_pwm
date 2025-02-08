import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_on_off_pwm/bloc/flash_cubit/flash_cubit.dart';
import 'package:led_on_off_pwm/utilties/constants.dart';


class FlashSlideSwitch extends StatelessWidget {
  const FlashSlideSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlashCubit, FlashState>(
      builder: (context, state) {
        return SizedBox(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.isFlashing ? '${Constants.kLed} Flashing' : '${Constants.kLed} Off',
                style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
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
