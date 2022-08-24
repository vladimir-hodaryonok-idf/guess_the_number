import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/src/bloc/game_bloc.dart';
import 'package:presentation/src/pages/widgets/game_field.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static const title = 'Guess the number';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: BlocProvider<GameBloc>(
        create: (_) => GameBloc(
          generateGuessNumber: GenerateGuessNumberUseCase(),
          makeAttempt: MakeAttemptUseCase(),
        ),
        child: const GameField(),
      ),
    );
  }
}
