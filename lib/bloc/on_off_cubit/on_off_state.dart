part of 'on_off_cubit.dart';

class OnOffState extends Equatable {
  final bool isOn;

  const OnOffState({this.isOn = true});

  OnOffState copyWith({bool? isOn}) {
    return OnOffState(
      isOn: isOn ?? this.isOn,
    );
  }

  @override
  List<Object> get props => [isOn];

  @override
  String toString() => 'OnOffState(isOn: $isOn)';
}