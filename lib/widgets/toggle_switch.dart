import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_on_off_pwm/bloc/on_off_cubit/on_off_cubit.dart';
import 'package:led_on_off_pwm/utilties/constants.dart';

class ToggleSwitch extends StatelessWidget {
   const ToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnOffCubit, OnOffState>(
      builder: (context, state) {
        return Container(
          width: 200.0,
          height: 150.0,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: state.isOn ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.isOn ? Constants.kOn: Constants.kOff,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Switch(
                value: state.isOn,
                onChanged: (value) {
                  context.read<OnOffCubit>().toggleSwitch();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}