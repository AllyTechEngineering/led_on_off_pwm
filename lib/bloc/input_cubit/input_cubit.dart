import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:led_on_off_pwm/services/gpio_service.dart';
part 'input_state.dart';

class InputCubit extends Cubit<InputState> {
  final GpioService gpioService;

  InputCubit(this.gpioService)
    : super(const InputState(isInputDetected: false)) {
    _initialize();
  }

  void _initialize() {
    gpioService.startInputPolling((isInputDetected) {
      emit(state.copyWith(isInputDetected: isInputDetected));
    });
  }

  void stopPolling() {
    gpioService.stopInputPolling();
  }
}
