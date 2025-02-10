import 'dart:async';
import 'package:dart_periphery/dart_periphery.dart';
import 'package:flutter/material.dart';
import 'package:led_on_off_pwm/utilties/constants.dart';

class GpioService {
  static final GpioService _instance = GpioService._internal();
  static Duration pollingDuration = const Duration(milliseconds: Constants.kPollingDuration);
  Timer? _pollingTimer;
  Timer? _flashTimer;
  late GPIO gpio5; // Output GPIO
  late GPIO gpio6; // Output GPIO
  late GPIO gpio22;
  late GPIO gpio26; // Input GPIO
  late GPIO gpio27; // Relay GPIO

  // Use a map for managing boolean states
  final Map<String, bool> _gpioStates = {
    "directionState": true, // true = forward, false = backward
    "gpioToggleState": true,
    "isInputDetected": false,
    "isPolling": false,
    "currentInputState": false,
    "isFlashing": false,
  };

  factory GpioService() => _instance;

  GpioService._internal() {
    try {
      gpio5 = GPIO(5, GPIOdirection.gpioDirOut, 0);
      gpio6 = GPIO(6, GPIOdirection.gpioDirOut, 0);
      gpio22 = GPIO(22, GPIOdirection.gpioDirOut, 0); // UI state LED
      gpio26 = GPIO(26, GPIOdirection.gpioDirIn, 0); // Binary sensor input
      gpio27 = GPIO(27, GPIOdirection.gpioDirOut, 0); // Sensor state LED
      debugPrint('GPIO Service Initialized');
    } catch (e) {
      debugPrint('Error initializing GpioService: $e');
    }
  }

  // Getters for boolean states
  bool get directionState => _gpioStates["directionState"]!;
  bool get gpioToggleState => _gpioStates["gpioToggleState"]!;
  bool get isInputDetected => _gpioStates["isInputDetected"]!;
  bool get isPolling => _gpioStates["isPolling"]!;
  bool get currentInputState => _gpioStates["currentInputState"]!;
  bool get isFlashing => _gpioStates["isFlashing"]!;

  // Methods to modify state values
  void setState(String key, bool value) {
    _gpioStates[key] = value;
  }

  void initializeGpioService() {
    gpio5.write(false);
    gpio6.write(false);
    gpio22.write(false);
    gpio26.read();
    gpio27.write(false);
  }

  // GPIO Input Polling
  void startInputPolling(Function(bool) onData) {
    if (isPolling) return;
    setState("isPolling", true);

    _pollingTimer = Timer.periodic(pollingDuration, (_) {
      bool newState = gpio26.read();
      if (newState != isInputDetected) {
        setState("isInputDetected", newState);
        onData(newState);
      }
    });
  }

  void stopInputPolling() {
    _pollingTimer?.cancel();
    setState("isPolling", false);
  }

  // GPIO Output Control
  void toggleGpioState() {
    bool newState = !gpioToggleState;
    setState("gpioToggleState", newState);
    gpio5.write(newState);
    gpio6.write(newState);
  }

  void pwmMotorServiceDirection() {
    gpio5.write(true);
    gpio6.write(true);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState("directionState", !directionState);
      gpio5.write(!directionState);
      gpio6.write(directionState);
    });
  }

  // Sensor input LED control
  void setLedState(bool state) {
    gpio27.write(state);
    debugPrint('Relay GPIO 27 set to: $state');
  }

    // Flashing LED Control
  void startFlashingLed() {
    if (isFlashing) return;
    setState("isFlashing", true);

    _flashTimer = Timer.periodic(const Duration(milliseconds: Constants.kFlashRate), (_) {
      gpio22.write(!gpio22.read()); // Toggle LED state
    });
  }

  void stopFlashingLed() {
    setState("isFlashing", false);
    _flashTimer?.cancel();
    gpio22.write(false); // Ensure LED is off
  }
}
