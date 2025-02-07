part of 'slider_cubit.dart';

class SliderState extends Equatable {
  final int pwmData;

  const SliderState({this.pwmData = 0});

  SliderState copyWith({int? pwmData}) {
    return SliderState(
      pwmData: pwmData ?? this.pwmData,
    );
  }

  @override
  List<Object> get props => [pwmData];

  @override
  String toString() => 'SliderState(pwmData: $pwmData)';
}