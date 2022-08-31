import 'package:presentation/src/constants/init_values.dart';

enum BlocTileState { initial, newGame, gameInProgress, win, lose }

class BlocTile {
  final int guessedNumber;
  final int attemptsRemain;
  final BlocTileState state;
  final bool isNewGameBtnEnabled;
  final bool isMakeATryBtnEnabled;

  BlocTile({
    required this.attemptsRemain,
    required this.guessedNumber,
    required this.state,
  })  : isNewGameBtnEnabled = state == BlocTileState.gameInProgress ||
            state == BlocTileState.newGame,
        isMakeATryBtnEnabled = state != BlocTileState.gameInProgress &&
            state != BlocTileState.newGame;

  factory BlocTile.init() => BlocTile(
        attemptsRemain: initialAttempts,
        guessedNumber: blocTileInitValue,
        state: BlocTileState.initial,
      );

  BlocTile copyWith([
    BlocTileState? state,
    int? attemptsRemain,
    int? guessedNumber,
  ]) =>
      BlocTile(
        attemptsRemain: attemptsRemain ?? this.attemptsRemain,
        guessedNumber: guessedNumber ?? this.guessedNumber,
        state: state ?? this.state,
      );
}
