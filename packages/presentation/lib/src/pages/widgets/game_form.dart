import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/src/bloc/events.dart';
import 'package:presentation/src/bloc/game_bloc.dart';
import 'package:presentation/src/bloc/state.dart';
import 'package:presentation/src/constants/global.dart';

class GameForm extends StatelessWidget {
  final GameState state;
  static final _formKey = GlobalKey<FormState>();

  const GameForm({Key? key, required this.state}) : super(key: key);

  String? _validator(String? text) => (text != null &&
          ((int.tryParse(text) ?? -1) > maxGuessNumber ||
              (int.tryParse(text) ?? -1) < 0))
      ? 'Incorrect input'
      : null;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GameBloc>();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          state is WinState
              ? const Text('Correct!')
              : const Text('Guess the number (0..10)'),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              onChanged: (text) {
                final int number = int.tryParse(text) ?? 0;
                bloc.add(SetSuggestedNumber(number: number));
              },
              validator: _validator,
              maxLength: 2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Guess the number',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: state is WinState ||
                          state is LoseState ||
                          state is InitState
                      ? () {
                          _formKey.currentState?.reset();
                          bloc.add(NewGame());
                        }
                      : null,
                  child: const Text('New Game')),
              TextButton(
                  onPressed: state is GameInProgressState
                      ? () {
                          _formKey.currentState?.validate() ?? false
                              ? bloc.add(MakeAttempt())
                              : null;
                        }
                      : null,
                  child: const Text('Make a try')),
            ],
          )
        ],
      ),
    );
  }
}
