import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:led_on_off_pwm/services/gpio_service.dart';

part 'flash_state.dart';

class FlashCubit extends Cubit<FlashState> {
  final GpioService gpioService;

  FlashCubit(this.gpioService) : super(const FlashState());

  void toggleFlashing() {
    if (state.isFlashing) {
      gpioService.stopFlashingLed();
    } else {
      gpioService.startFlashingLed();
    }
    emit(state.copyWith(isFlashing: !state.isFlashing));
  }
}
