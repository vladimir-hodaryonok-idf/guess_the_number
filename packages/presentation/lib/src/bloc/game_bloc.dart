import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/src/bloc/state.dart';

import 'events.dart';

const maxAttempts = 3;
const initIsGuessTrue = false;
const suggestedNumberInit = -1;

class GameBloc extends Bloc<GameEvent, GameState> {
  final GenerateGuessNumberUseCase generateGuessNumber;
  final MakeAttemptUseCase makeAttempt;
  final DecrementAttemptsUseCase decrementAttempts;
  int _suggestedNumber = suggestedNumberInit;

  GameBloc({
    required this.makeAttempt,
    required this.generateGuessNumber,
    required this.decrementAttempts,
  }) : super(InitState()) {
    on<MakeAttempt>((event, emit) => emit(_makeAttempt()));
    on<NewGame>((event, emit) => emit(_newGame));
    on<SetSuggestedNumber>((event, emit) => _suggestedNumber = event.number);
  }

  GameState get _newGame => GameInProgressState(
        guessNumber: generateGuessNumber(),
        guessAttempts: maxAttempts,
      );

  GameState _makeAttempt() {
    final currentState = (state as GameInProgressState);
    final AttemptParams attemptParams =
        _createAttemptParams(currentState.guessNumber);
    if (makeAttempt(attemptParams)) return WinState();
    final int? attemptsLeft = decrementAttempts(currentState.guessAttempts);
    return attemptsLeft == null
        ? LoseState()
        : currentState.copyWith(guessAttempts: attemptsLeft);
  }

  AttemptParams _createAttemptParams(int guessNumber) => AttemptParams(
        guessNumber: guessNumber,
        suggestedNumber: _suggestedNumber,
      );
}
