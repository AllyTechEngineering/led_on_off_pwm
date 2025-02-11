import 'package:dart_periphery/dart_periphery.dart';
import 'package:flutter/foundation.dart';

// import 'package:led_on_off_pwm/services/gpio_service.dart';
// Must follow the how to enabl e PWM in the Raspberry Pi
// Located at the readme page.
class PwmService {
  static final PwmService _instance = PwmService._internal();
  late PWM pwm0;
  static bool systemOnOffState = true;

  factory PwmService() {
    return _instance;
  }

  PwmService._internal() {
    try {
      pwm0 = PWM(2, 0);
      // pwm0 = PWM(0,0); //Model 4
      // Model 5, pwm(2,0), pwm(2,1), pwm(2,2) or pwm(2,3) only these pins: 12, 13, 18 or 19
      // Model 4B, pwm(0,0) or pwm(0,1) only 2 of these pins: 12, 13, 18 or 19
      // Model 4B: pin assignment is set by the dtoverlay. Use sudo pinctrl to see which pins are assigned.
      debugPrint('PwmService Initialized: ${pwm0.getPWMinfo()}');
    } catch (e) {
      debugPrint('Error initializing PwmService: $e');
    }
  }
  void initializePwmService() {
    try {
      pwm0.setPeriodNs(10000000);
      pwm0.setDutyCycleNs(0);
      pwm0.enable();
      pwm0.setPolarity(Polarity.pwmPolarityNormal);
      debugPrint('PwmService configured successfully.');
    } catch (e) {
      debugPrint('PwmService initialization error: $e');
    }
  }

  void updatePwmDutyCycle(int updateDutyCycle) {
    // debugPrint(
    //     'In PwmService updatePwmDutyCycle systemOnOffSate: $systemOnOffState');
    if (systemOnOffState) {
      pwm0.setDutyCycleNs(updateDutyCycle * 100000);
      // pwm1.setDutyCycleNs(updateDutyCycle * 100000);
      // pwm2.setDutyCycleNs(updateDutyCycle * 100000);
      // pwm3.setDutyCycleNs(updateDutyCycle * 100000);
      debugPrint(
        'In PwmService updatePwmDutyCycle DutyCycleNs= ${pwm0.getDutyCycleNs()}',
      );
      debugPrint(
        'In PwmService updatePwmDutyCycle PWM Info: ${pwm0.getPWMinfo()}',
      );
    }
  }

  void pwmSystemOnOff() {
    systemOnOffState = !systemOnOffState;
    // debugPrint('In PwmService systemOnOffState: $systemOnOffState');
    if (!systemOnOffState) {
      pwm0.disable();
      // pwm1.disable();
      // pwm2.disable();
      // pwm3.disable();
      // GpioService().setLedState(false);
      // GpioService().setState("isPolling", false);
      // debugPrint('In PwmService enable: ${pwm.getEnabled()}');
    }
    if (systemOnOffState) {
      pwm0.enable();
      // pwm1.enable();
      // pwm2.enable();
      // pwm3.enable();
      // GpioService().setLedState(true);
      // GpioService().setState("isPolling", true);
      // debugPrint('In PwmService enable: ${pwm.getEnabled()}');
    }
  }

  //Disposal
  // Add all the enabled pwms to the dispose method
  void dispose() {
    pwm0.disable();
    pwm0.dispose();
    debugPrint('PWM resources released');
  }
} // End of class PwmService
