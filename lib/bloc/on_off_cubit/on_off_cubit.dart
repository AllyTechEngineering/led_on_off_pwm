import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:led_on_off_pwm/services/gpio_service.dart';
import 'package:led_on_off_pwm/services/pwm_service.dart';
part 'on_off_state.dart';

class OnOffCubit extends Cubit<OnOffState> {
  final PwmService pwmService;
  final GpioService gpioService;

  OnOffCubit(this.gpioService, this.pwmService) : super(const OnOffState()){
    gpioService.initializeGpioService();
  }

  void toggleSwitch() {
    pwmService.pwmSystemOnOff();
    gpioService.toggleGpioState();
    emit(state.copyWith(isOn: !state.isOn));
  }
}