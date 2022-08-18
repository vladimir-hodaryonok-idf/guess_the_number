import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_the_number/domain/use_cases/generate_guess_number.dart';
import 'package:guess_the_number/domain/use_cases/is_attempts_remain.dart';
import 'package:guess_the_number/domain/use_cases/make_attempt.dart';
import 'package:guess_the_number/presentation/bloc/game_bloc.dart';
import 'package:guess_the_number/presentation/pages/widgets/game_field.dart';

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
          isAttemptsOver: IsAttemptsOver(),
          generateGuessNumber: GenerateGuessNumberUseCase(),
          makeAttempt: MakeAttemptUseCase(),
        ),
        child: const GameField(),
      ),
    );
  }
}
