import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/game_bloc/bloc_screen.dart';
import 'package:presentation/src/game_bloc/bloc_tile.dart';
import 'package:presentation/src/game_bloc/game_bloc.dart';
import 'package:presentation/src/pages/widgets/game_form.dart';

class GameField extends BlocScreen {
  const GameField({Key? key}) : super(key: key);

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends BlocScreenState<GameField, GameBloc> {
  _GameFieldState()
      : super(
          GameBloc(
            GenerateGuessNumberUseCase(),
            MakeAttemptUseCase(),
          ),
        );

  void _showEndGameMessage(String message) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }

  void _showAttemptsRemain(int guessAttemptsCount, BlocTileState state) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final message = state == BlocTileState.gameInProgress
            ? 'Game started!'
            : 'Attempts left: $guessAttemptsCount';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<BlocTile>(
        stream: bloc.dataStream,
        builder: (context, snapshot) {
          final tile = snapshot.data;
          if (tile == null) return Center(child: CircularProgressIndicator());
          if (tile.state == BlocTileState.win)
            _showEndGameMessage('Correct!');
          else if (tile.state == BlocTileState.lose)
            _showEndGameMessage('You Lose!');
          else if (tile.state == BlocTileState.gameInProgress)
            _showAttemptsRemain(tile.attemptsRemain, tile.state);
          return GameForm(
            tile: tile,
            bloc: bloc,
          );
        },
      ),
    );
  }
}
