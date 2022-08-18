import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_the_number/presentation/bloc/game_bloc.dart';
import 'package:guess_the_number/presentation/bloc/state.dart';
import 'package:guess_the_number/presentation/pages/widgets/game_form.dart';

const attemptsCount = 3;

class GameField extends StatelessWidget {
  const GameField({Key? key}) : super(key: key);

  void _showEndGameMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showAttemptsRemain(BuildContext context, int guessAttemptsCount) {
    final message = guessAttemptsCount == attemptsCount
        ? 'Game started!'
        : 'Attempts left: $guessAttemptsCount';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<GameBloc, GameState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case WinState:
                _showEndGameMessage(context, (state as WinState).message);
                break;
              case LoseState:
                _showEndGameMessage(context, (state as LoseState).message);
                break;
              case GameInProgressState:
                _showAttemptsRemain(
                    context, (state as GameInProgressState).guessAttempts);
                break;
            }
          },
          builder: (context, state) => GameForm(state: state)),
    );
  }
}
