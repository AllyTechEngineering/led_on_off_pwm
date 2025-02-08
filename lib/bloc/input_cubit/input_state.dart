part of 'input_cubit.dart';

class InputState extends Equatable {
  final bool isInputDetected;

  const InputState({required this.isInputDetected});

  InputState copyWith({bool? isInputDetected}) {
    return InputState(isInputDetected: isInputDetected ?? this.isInputDetected);
  }

  @override
  List<Object?> get props => [isInputDetected];

  @override
  String toString() => 'InputState(isInputDetected: $isInputDetected)';
}
