import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:led_on_off_pwm/services/pwm_service.dart';
part 'on_off_state.dart';

class OnOffCubit extends Cubit<OnOffState> {
  final PwmService pwmService;

  OnOffCubit(this.pwmService) : super(const OnOffState());

  void toggleSwitch() {
    pwmService.pwmSystemOnOff();
    emit(state.copyWith(isOn: !state.isOn));
  }
}