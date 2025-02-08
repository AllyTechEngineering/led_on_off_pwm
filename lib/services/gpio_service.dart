import 'dart:async';

import 'package:dart_periphery/dart_periphery.dart';
import 'package:flutter/material.dart';

class GpioService {
  static final GpioService _instance = GpioService._internal();
  static bool directionState = true; //true = forward, false = backward
  static bool gpioToggleState = true;
  static bool gpioInputState = false;
  static bool isInputDetected = false;
  static bool isPolling = false;
  static bool currentInputState = false;
  Timer? _pollingTimer;
  static Duration pollingDuration = const Duration(milliseconds: 1000);
  late GPIO gpio5;
  late GPIO gpio6;
  late GPIO gpio26;

  factory GpioService() {
    return _instance;
  }

  GpioService._internal() {
    try {
      gpio5 = GPIO(5, GPIOdirection.gpioDirOut, 0);
      gpio6 = GPIO(6, GPIOdirection.gpioDirOut, 0);
      gpio26 = GPIO(26, GPIOdirection.gpioDirIn, 0);
      debugPrint('Initial GpioService GPIO 5: ${gpio5.getGPIOinfo()}');
      debugPrint('Initial GpioService GPIO 6: ${gpio6.getGPIOinfo()}');
      debugPrint('Initial GpioService GPIO 26: ${gpio26.getGPIOinfo()}');
    } catch (e) {
      debugPrint('Error initializing GpioService: $e');
    }
  }

  void initializeGpioService() {
    gpio5.write(true);
    gpio6.write(false);
    try {
      debugPrint('Initial GpioService Info: , ${gpio5.getGPIOinfo()}');
      debugPrint('Initial GpioService Info: ${gpio6.getGPIOinfo()}');
    } catch (e) {
      debugPrint('Error initializing GpioService: $e');
    }
  } //initializeGpioService

  //GPIO Input
  void startInputPolling(Function(bool) onData) {
    if (isPolling) return;
    isPolling = true;
    _pollingTimer = Timer.periodic(pollingDuration, (_) {
      currentInputState = gpio26.read();
      if (currentInputState != isInputDetected) {
        isInputDetected = currentInputState;
        onData(isInputDetected);
      }
    });
  } //startInputPolling

  void stopInputPolling() {
    _pollingTimer?.cancel();
    isPolling = false;
  }

  // GPIO Output
  void toggleGpioState() {
    gpioToggleState = !gpioToggleState;
    if (!gpioToggleState) {
      gpio5.write(false);
      gpio6.write(false);
    } else {
      gpio5.write(true);
      gpio6.write(true);
    }
  } //toggleGpioState

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
  } //pwmMotorServiceDirection
} //GpioService
