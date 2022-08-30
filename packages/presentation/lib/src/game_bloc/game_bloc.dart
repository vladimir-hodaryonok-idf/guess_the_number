import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/src/constants/init_values.dart';
import 'package:presentation/src/game_bloc/bloc.dart';
import 'package:presentation/src/game_bloc/bloc_tile.dart';
import 'package:presentation/src/game_bloc/show_snack_bar_event.dart';

@injectable
abstract class GameBloc extends Bloc {
  @factoryMethod
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

  Function()? onNewGamePressed();

  Function()? onMakeAttemptPressed();

  void onTextChange(String text);

  String? validate(String? text);

  GlobalKey<FormState> get formKey;
}

class GameBlocImpl extends BlocImpl implements GameBloc {
  final GenerateGuessNumberUseCase _generateGuessNumberUseCase;
  final MakeAttemptUseCase _makeAttemptUseCase;
  final GlobalKey<FormState> formKey;
  int _suggestedNumber = blocTileInitValue;

  GameBlocImpl(
    this._makeAttemptUseCase,
    this._generateGuessNumberUseCase,
    this.formKey,
  );

  @override
  void initState() {
    super.initState();
    emit(tile);
  }

  @override
  Function()? onMakeAttemptPressed() =>
      tile.state == BlocTileState.gameInProgress ||
              tile.state == BlocTileState.newGame
          ? _makeAttempt
          : null;

  @override
  Function()? onNewGamePressed() =>
      tile.state != BlocTileState.gameInProgress &&
              tile.state != BlocTileState.newGame
          ? _newGame
          : null;

  @override
  void onTextChange(String text) {
    formKey.currentState?.validate() ?? false
        ? _setSuggestedNumber(int.tryParse(text) ?? 0)
        : null;
  }

  @override
  String? validate(String? text) => (text != null &&
          ((int.tryParse(text) ?? -1) > maxGuessNumber ||
              (int.tryParse(text) ?? -1) < 0))
      ? 'Incorrect input'
      : null;

  void _makeAttempt() {
    if ((formKey.currentState?.validate() ?? false) == false) return;
    _emitNewState();
    _showUiEvent();
  }

  void _emitNewState() {
    final result = _makeAttemptUseCase(_createAttemptParams());
    if (result is LoseAttempt)
      emit(tile.copyWith(BlocTileState.lose));
    else if (result is WinAttempt)
      emit(tile.copyWith(BlocTileState.win));
    else if (result is FailAttempt)
      emit(
        tile.copyWith(
          BlocTileState.gameInProgress,
          result.attemptsRemain,
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
      suggestedNumber: _suggestedNumber,
      attemptsRemain: tile.attemptsRemain,
    );
  }

  void _newGame() {
    formKey.currentState?.reset();
    _emitNewGameState();
    _showUiEvent();
  }

  void _emitNewGameState() {
    final guessedNumber = _generateGuessNumberUseCase();
    emit(
      tile.copyWith(
        BlocTileState.newGame,
        initialAttempts,
        guessedNumber,
      ),
    );
  }

  void _setSuggestedNumber(int number) => _suggestedNumber = number;
}
