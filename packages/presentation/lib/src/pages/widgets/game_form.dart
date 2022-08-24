import 'package:flutter/material.dart';
import 'package:presentation/src/game_bloc/bloc_tile.dart';
import 'package:presentation/src/game_bloc/events.dart';
import 'package:presentation/src/game_bloc/game_bloc.dart';

const maxGuessNumber = 10;

class GameForm extends StatelessWidget {
  final BlocTile tile;
  final GameBloc bloc;

  static final _formKey = GlobalKey<FormState>();

  const GameForm({
    Key? key,
    required this.tile,
    required this.bloc,
  }) : super(key: key);

  String? _validator(String? text) => (text != null &&
          ((int.tryParse(text) ?? -1) > maxGuessNumber ||
              (int.tryParse(text) ?? -1) < 0))
      ? 'Incorrect input'
      : null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Guess the number (0..10)'),
          tile.state == BlocTileState.win
              ? const Text('Correct!')
              : const SizedBox.shrink(),
          tile.state == BlocTileState.lose
              ? const Text('YOU LOSE!!!')
              : const SizedBox.shrink(),
          createTextFormField(bloc),
          Buttons(
            tile: tile,
            formKey: _formKey,
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
        onChanged: (text) {
          final int number = int.tryParse(text) ?? 0;
          bloc.add(SetSuggestedNumberEvent(number: number));
        },
        validator: _validator,
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
    required GlobalKey<FormState> formKey,
    required this.bloc,
  })  : _formKey = formKey,
        super(key: key);

  final BlocTile tile;
  final GlobalKey<FormState> _formKey;
  final GameBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: tile.state != BlocTileState.gameInProgress
              ? () {
                  _formKey.currentState?.reset();
                  bloc.add(NewGameEvent());
                }
              : null,
          child: const Text('New Game'),
        ),
        TextButton(
          onPressed: tile.state == BlocTileState.gameInProgress
              ? () {
                  _formKey.currentState?.validate() ?? false
                      ? bloc.add(MakeAttemptEvent())
                      : null;
                }
              : null,
          child: const Text('Make a try'),
        ),
      ],
    );
  }
}
