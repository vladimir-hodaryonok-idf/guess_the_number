import 'package:equatable/equatable.dart';

const guessNumberInitializer = -1;
const guessAttemptsInitializer = 0;

abstract class GameState extends Equatable {}

class InitState extends GameState {
  final int guessNumber = guessNumberInitializer;

  final int guessAttempts = guessAttemptsInitializer;

  @override
  List<Object?> get props => [guessNumber, guessAttempts];
}

class GameInProgressState extends GameState {
  final int guessNumber;

  final int guessAttempts;

  GameInProgressState({
    required this.guessNumber,
    required this.guessAttempts,
  });

  GameInProgressState copyWith({required int guessAttempts}) =>
      GameInProgressState(
        guessNumber: guessNumber,
        guessAttempts: guessAttempts,
      );

  @override
  List<Object?> get props => [guessAttempts, guessNumber];
}

class LoseState extends GameState {
  final String message = 'YOU LOSE!';

  @override
  List<Object?> get props => [message];
}

class WinState extends GameState {
  final String message = 'Correct!';

  @override
  List<Object?> get props => [message];
}
