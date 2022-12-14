import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/src/game_bloc/game_bloc.dart';

Future<void> initPresentationModule() async {
  initMainPageModule();
}

void initMainPageModule() {
  GetIt.I.registerFactory<GameBloc>(
    () => GameBloc(
      GetIt.I.get<GenerateGuessNumberUseCase>(),
      GetIt.I.get<MakeAttemptUseCase>(),
      GetIt.I.get<GlobalKey<FormState>>(),
    ),
  );
  GetIt.I.registerFactory<GlobalKey<FormState>>(
    () => GlobalKey<FormState>(),
  );
}
