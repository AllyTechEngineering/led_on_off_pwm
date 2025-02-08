part of 'flash_cubit.dart';

class FlashState extends Equatable {
  final bool isFlashing;

  const FlashState({this.isFlashing = false});

  FlashState copyWith({bool? isFlashing}) {
    return FlashState(
      isFlashing: isFlashing ?? this.isFlashing,
    );
  }

  @override
  List<Object> get props => [isFlashing];

  @override
  String toString() => 'FlashState(isFlashing: $isFlashing)';
}
