import 'package:domain/domain.dart';
import 'package:presentation/src/constants/init_values.dart';
import 'package:presentation/src/game_bloc/bloc.dart';
import 'package:presentation/src/game_bloc/bloc_tile.dart';
import 'package:presentation/src/game_bloc/events.dart';

abstract class GameBloc extends Bloc {
  factory GameBloc(
    GenerateGuessNumberUseCase generateGuessNumber,
    MakeAttemptUseCase makeAttempt,
  ) =>
      GameBlocImpl(
        makeAttempt,
        generateGuessNumber,
      );

  void add(BlocEvent event);
}

class GameBlocImpl extends BlocImpl implements GameBloc {
  final GenerateGuessNumberUseCase _generateGuessNumberUseCase;
  final MakeAttemptUseCase _makeAttemptUseCase;
  int _suggestedNumber = blocTileInitValue;

  GameBlocImpl(
    this._makeAttemptUseCase,
    this._generateGuessNumberUseCase,
  ) {
    eventStream.listen(
      (event) {
        if (event is MakeAttemptEvent)
          _makeAttempt();
        else if (event is NewGameEvent)
          _newGame();
        else if (event is SetSuggestedNumberEvent)
          _setSuggestedNumber(event.number);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _updateData(tile);
  }

  void _updateData(BlocTile data) => emit(
        data.state,
        data.attemptsRemain,
        data.suggestedNumber,
        data.guessedNumber,
      );

  @override
  void add(BlocEvent event) => handleEvent(event);

  void _makeAttempt() {
    final result = _makeAttemptUseCase(_createAttemptParams());
    if (result is LoseAttempt)
      emit(BlocTileState.lose);
    else if (result is WinAttempt)
      emit(BlocTileState.win);
    else if (result is FailAttempt)
      emit(BlocTileState.gameInProgress, result.attemptsRemain);
  }

  AttemptParams _createAttemptParams() {
    return AttemptParams(
      guessNumber: tile.guessedNumber,
      suggestedNumber: _suggestedNumber,
      attemptsRemain: tile.attemptsRemain,
    );
  }

  void _newGame() {
    final guessedNumber = _generateGuessNumberUseCase();
    emit(BlocTileState.gameInProgress, initialAttempts, guessedNumber);
  }

  void _setSuggestedNumber(int number) => _suggestedNumber = number;
}
