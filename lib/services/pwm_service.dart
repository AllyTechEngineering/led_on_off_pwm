import 'package:dart_periphery/dart_periphery.dart';
import 'package:flutter/foundation.dart';

class PwmService {
  static final PwmService _instance = PwmService._internal();
  late PWM pwm0;
  static bool systemOnOffState = true;
  int setPwmPeriod = 10000000; //10000000ns = 100Hz freq, 1000000ns = 1000 Hz

  factory PwmService() {
    return _instance;
  }

  PwmService._internal() {
    try {
      pwm0 = PWM(2, 0);
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
      // debugPrint('In PwmService enable: ${pwm.getEnabled()}');
    }
    if (systemOnOffState) {
      pwm0.enable();
      // pwm1.enable();
      // pwm2.enable();
      // pwm3.enable();
      // debugPrint('In PwmService enable: ${pwm.getEnabled()}');
    }
  }
} // End of class PwmService
