import 'package:dart_periphery/dart_periphery.dart';
import 'package:flutter/foundation.dart';

class PwmService {
  static PWM pwm0 = PWM(2, 0);
  // static PWM pwm1 = PWM(2, 1);
  // static PWM pwm2 = PWM(2, 2);
  // static PWM pwm3 = PWM(2, 3);

  static bool systemOnOffState = true;
  int setPwmPeriod = 10000000; //10000000ns = 100Hz freq, 1000000ns = 1000 Hz

  void initializePwmService() {
    try {
      // pwm = PWM(0, 1);
      debugPrint('Initial PwmService Info: ${pwm0.getPWMinfo()}');
    } catch (e) {
      debugPrint('Initial PwmService Error: $e');
    }
    try {
      pwm0.setPeriodNs(10000000);
      // pwm1.setPeriodNs(10000000);
      // pwm2.setPeriodNs(10000000);
      // pwm3.setPeriodNs(10000000);
      debugPrint('PwmService period Info: ${pwm0.getPeriodNs()}');
    } catch (e) {
      debugPrint('PwmService period Error: $e');
    }
    try {
      pwm0.setDutyCycleNs(0);
      // pwm1.setDutyCycleNs(0);
      // pwm2.setDutyCycleNs(0);
      // pwm3.setDutyCycleNs(0);
      debugPrint('PwmService Dutycycle Info: ${pwm0.getDutyCycleNs()}');
    } catch (e) {
      debugPrint('PwmService Dutycycle Error: $e');
    }
    try {
      pwm0.enable();
      // pwm1.enable();
      // pwm2.enable();
      // pwm3.enable();
      debugPrint('PwmService Enable Info: ${pwm0.getEnabled()}');
    } catch (e) {
      debugPrint('PwmService Enable Error: $e');
    }
    try {
      pwm0.setPolarity(Polarity.pwmPolarityNormal);
      // pwm1.setPolarity(Polarity.pwmPolarityNormal);
      // pwm2.setPolarity(Polarity.pwmPolarityNormal);
      // pwm3.setPolarity(Polarity.pwmPolarityNormal);
      // debugPrint('PwmService Polarity Info: ${pwm.getPolarity()}');
      // debugPrint('Final PwmService Info: ${pwm.getPWMinfo()}');
    } catch (e) {
      debugPrint('PwmService Polarity Error: $e');
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