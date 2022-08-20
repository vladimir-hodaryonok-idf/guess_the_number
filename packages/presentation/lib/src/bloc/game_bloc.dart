import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/src/bloc/state.dart';
import 'package:presentation/src/bloc/events.dart';

const maxAttempts = 3;
const initIsGuessTrue = false;
const suggestedNumberInit = -1;

class GameBloc extends Bloc<GameEvent, GameState> {
  final GenerateGuessNumberUseCase generateGuessNumber;
  final MakeAttemptUseCase makeAttempt;

  int _suggestedNumber = suggestedNumberInit;

  GameBloc({
    required this.makeAttempt,
    required this.generateGuessNumber,
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
    final params = _createAttemptParams();
    final attemptResult = makeAttempt(params);
    switch (attemptResult.runtimeType) {
      case LoseAttempt:
        return LoseState();
      case WinAttempt:
        return WinState();
      case FailAttempt:
        return currentState.copyWith(
            guessAttempts: (attemptResult as FailAttempt).attemptsRemain);
    }
    return InitState();
  }

  AttemptParams _createAttemptParams() {
    final currentState = (state as GameInProgressState);
    return AttemptParams(
      guessNumber: currentState.guessNumber,
      suggestedNumber: _suggestedNumber,
      attemptsRemain: currentState.guessAttempts,
    );
  }
}
