import 'package:presentation/src/constants/init_values.dart';

enum BlocTileState { initial, gameInProgress, win, lose }

class BlocTile {
  final int guessedNumber;
  final int suggestedNumber;
  final int attemptsRemain;
  final BlocTileState state;

  BlocTile(
      {required this.attemptsRemain,
      required this.suggestedNumber,
      required this.guessedNumber,
      required this.state});

  factory BlocTile.init() => BlocTile(
        attemptsRemain: initialAttempts,
        suggestedNumber: blocTileInitValue,
        guessedNumber: blocTileInitValue,
        state: BlocTileState.initial,
      );

  BlocTile copyWith([
    BlocTileState? state,
    int? guessedNumber,
    int? suggestedNumber,
    int? attemptsRemain,
  ]) =>
      BlocTile(
        attemptsRemain: attemptsRemain ?? this.attemptsRemain,
        suggestedNumber: suggestedNumber ?? this.suggestedNumber,
        guessedNumber: guessedNumber ?? this.guessedNumber,
        state: state ?? this.state,
      );
}
