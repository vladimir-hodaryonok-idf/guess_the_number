import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/constants/init_values.dart';
import 'package:presentation/src/game_bloc/bloc.dart';
import 'package:presentation/src/game_bloc/bloc_tile.dart';
import 'package:presentation/src/game_bloc/show_snack_bar_event.dart';

abstract class GameBloc extends Bloc<BlocTile> {
  factory GameBloc(
    GenerateGuessNumberUseCase generateGuessNumber,
    MakeAttemptUseCase makeAttempt,
    GlobalKey<FormState> formKey,
  ) =>
      GameBlocImpl(
        makeAttempt,
        generateGuessNumber,
        formKey,
      );

  void newGame();

  void makeAttempt();

  void onTextChange(String text);

  GlobalKey<FormState> get formKey;
}

class GameBlocImpl extends BlocImpl<BlocTile> implements GameBloc {
  final GenerateGuessNumberUseCase _generateGuessNumberUseCase;
  final MakeAttemptUseCase _makeAttemptUseCase;
  final GlobalKey<FormState> formKey;
  int? _suggestedNumber;

  GameBlocImpl(
    this._makeAttemptUseCase,
    this._generateGuessNumberUseCase,
    this.formKey,
  ) : super(BlocTile.init());

  @override
  void initState() {
    super.initState();
    emit(tile, false);
  }

  @override
  void onTextChange(String text) {
    _setSuggestedNumber(int.tryParse(text));
    _validate();
    formKey.currentState?.validate();
  }

  void _validate() {
    if (_suggestedNumber == null) return;
    final isValid =
        _suggestedNumber! > maxGuessNumber || _suggestedNumber!.isNegative;
    emit(tile.copyWith(validateResult: isValid ? 'Incorrect input' : null));
  }

  @override
  void makeAttempt() {
    if (_suggestedNumber == null) {
      emit(tile.copyWith(validateResult: 'Incorrect input'));
      formKey.currentState?.validate();
      return;
    }
    _emitNewState();
    _showUiEvent();
  }

  void _emitNewState() {
    final result = _makeAttemptUseCase(_createAttemptParams());
    if (result is LoseAttempt)
      emit(tile.copyWith(state: BlocTileState.lose));
    else if (result is WinAttempt)
      emit(tile.copyWith(state: BlocTileState.win));
    else if (result is FailAttempt)
      emit(
        tile.copyWith(
          state: BlocTileState.gameInProgress,
          attemptsRemain: result.attemptsRemain,
        ),
      );
  }

  void _showUiEvent() {
    if (tile.state == BlocTileState.newGame)
      emitUiEvent(NewGameMessage());
    else if (tile.state == BlocTileState.gameInProgress)
      emitUiEvent(AttemptsRemainMessage(tile.attemptsRemain));
    else if (tile.state == BlocTileState.lose)
      emitUiEvent(LoseMessage());
    else if (tile.state == BlocTileState.win) emitUiEvent(WinMessage());
  }

  AttemptParams _createAttemptParams() {
    return AttemptParams(
      guessNumber: tile.guessedNumber,
      suggestedNumber: _suggestedNumber ?? blocTileInitValue,
      attemptsRemain: tile.attemptsRemain,
    );
  }

  void newGame() {
    formKey.currentState?.reset();
    _emitNewGameState();
    _showUiEvent();
  }

  void _emitNewGameState() {
    final guessedNumber = _generateGuessNumberUseCase();
    emit(
      tile.copyWith(
        state: BlocTileState.newGame,
        attemptsRemain: initialAttempts,
        guessedNumber: guessedNumber,
      ),
    );
  }

  void _setSuggestedNumber(int? number) => _suggestedNumber = number;
}
