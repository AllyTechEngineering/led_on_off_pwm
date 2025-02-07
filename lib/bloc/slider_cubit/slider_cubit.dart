import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:led_on_off_pwm/services/pwm_service.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  final PwmService pwmService;

  SliderCubit(this.pwmService) : super(const SliderState()) {
    pwmService.initializePwmService();
  }

  void updateDutyCycle(int newDutyCycle) {
    emit(state.copyWith(pwmData: newDutyCycle));
    pwmService.updatePwmDutyCycle(newDutyCycle);
  }
}
