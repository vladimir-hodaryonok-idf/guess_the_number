import 'package:flutter/material.dart';
import 'package:presentation/src/game_bloc/bloc_tile.dart';
import 'package:presentation/src/game_bloc/game_bloc.dart';

const maxGuessNumber = 10;

class GameForm extends StatelessWidget {
  final BlocTile tile;
  final GameBloc bloc;

  const GameForm({
    Key? key,
    required this.tile,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: bloc.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Guess the number (0..10)'),
          if (tile.state == BlocTileState.win) const Text('Correct!'),
          if (tile.state == BlocTileState.lose) const Text('YOU LOSE!!!'),
          createTextFormField(bloc),
          Buttons(
            tile: tile,
            bloc: bloc,
          ),
        ],
      ),
    );
  }

  Padding createTextFormField(GameBloc bloc) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
        onChanged: bloc.onTextChange,
        validator: (_) => bloc.tile.validateResult,
        maxLength: 2,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Guess the number',
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    Key? key,
    required this.tile,
    required this.bloc,
  }) : super(key: key);

  final BlocTile tile;
  final GameBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: tile.isNewGameBtnEnabled ? bloc.newGame : null,
          child: const Text('New Game'),
        ),
        TextButton(
          onPressed: tile.isMakeATryBtnEnabled ? bloc.makeAttempt : null,
          child: const Text('Make a try'),
        ),
      ],
    );
  }
}
