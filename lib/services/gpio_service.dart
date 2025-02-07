import 'package:dart_periphery/dart_periphery.dart';
import 'package:flutter/material.dart';

class GpioService {
  static bool directionState = true; //true = forward, false = backward
  static bool gpioToggleState = true;
  static GPIO gpio5 = GPIO(5, GPIOdirection.gpioDirOut, 0);
  static GPIO gpio6 = GPIO(6, GPIOdirection.gpioDirOut, 0);

  void initializeGpioService() {
    gpio5.write(true);
    gpio6.write(false);
    try {
      debugPrint(
        'Initial GpioService Info: , ${GpioService.gpio5.getGPIOinfo()}',
      );
      debugPrint(
        'Initial GpioService Info: ${GpioService.gpio6.getGPIOinfo()}',
      );
    } catch (e) {
      debugPrint('Error initializing GpioService: $e');
    }
  } //initializeGpioService

  void toggleGpioState() {
    gpioToggleState = !gpioToggleState;
    if (!gpioToggleState) {
      gpio5.write(false);
      // gpio6.write(false);
    } else {
      gpio5.write(true);
      // gpio6.write(true);
    }
  }

  void pwmMotorServiceDirection() {
    // debugPrint('Changing motor direction...');

    // Set both GPIOs to true before changing direction
    gpio5.write(true);
    gpio6.write(true);
    // debugPrint('GPIO5 and GPIO6 set to true (Brake)');

    // Delay 500ms to allow safe direction change
    Future.delayed(const Duration(milliseconds: 500), () {
      directionState = !directionState;

      if (!directionState) {
        gpio5.write(false);
        gpio6.write(true);
        // debugPrint('Direction changed: Reverse');
      } else {
        gpio5.write(true);
        gpio6.write(false);
        // debugPrint('Direction changed: Forward');
      }
    });
  }
} //GpioService
