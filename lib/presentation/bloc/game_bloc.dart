import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_the_number/domain/models/attempt_params.dart';
import 'package:guess_the_number/domain/use_cases/generate_guess_number.dart';
import 'package:guess_the_number/domain/use_cases/is_attempts_remain.dart';
import 'package:guess_the_number/domain/use_cases/make_attempt.dart';
import 'package:guess_the_number/presentation/bloc/events.dart';
import 'package:guess_the_number/presentation/bloc/state.dart';

const maxAttempts = 3;
const initIsGuessTrue = false;
const suggestedNumberInit = -1;

class GameBloc extends Bloc<GameEvent, GameState> {
  final GenerateGuessNumberUseCase generateGuessNumber;
  final MakeAttemptUseCase makeAttempt;
  final IsAttemptsOver isAttemptsOver;
  int _suggestedNumber = suggestedNumberInit;

  GameBloc({
    required this.makeAttempt,
    required this.generateGuessNumber,
    required this.isAttemptsOver,
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
    final attemptParams = _createAttemptParams(currentState.guessNumber);
    if (makeAttempt(attemptParams)) return WinState();
    if (isAttemptsOver(currentState.guessAttempts)) return LoseState();
    return currentState.copyWith(guessAttempts: currentState.guessAttempts - 1);
  }

  AttemptParams _createAttemptParams(int guessNumber) => AttemptParams(
        guessNumber: guessNumber,
        suggestedNumber: _suggestedNumber,
      );
}
