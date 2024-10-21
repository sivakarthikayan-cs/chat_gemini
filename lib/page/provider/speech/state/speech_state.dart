import 'package:equatable/equatable.dart';

enum SpeechStateConcreteState {
  initial,
  loading,
  success,
  failure,
  playing,
  stopped,
  paused,
  continued
}

class SpeechState extends Equatable {
  final SpeechStateConcreteState state;
  final Map<int, SpeechStateConcreteState>? currentState;

  const SpeechState({required this.state, this.currentState});

  const SpeechState.initial(
      {this.state = SpeechStateConcreteState.initial, this.currentState});

  SpeechState copyWith(
      {SpeechStateConcreteState? state,
      Map<int, SpeechStateConcreteState>? currentState}) {
    return SpeechState(
        state: state ?? this.state,
        currentState: currentState ?? this.currentState);
  }

  @override
  String toString() {
    return 'SpeechState(state:$state, CurrentState:$currentState )';
  }

  @override
  List<Object?> get props => [state, currentState];
}
