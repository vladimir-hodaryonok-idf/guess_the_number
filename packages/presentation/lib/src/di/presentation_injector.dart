import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/src/game_bloc/game_bloc.dart';

Future<void> initPresentationModule() async {
  initMainPageModule();
}

void initMainPageModule() {
  // for reviewers...
  // i decided to use singleton to avoid pass a GameBloc instance
  // to widget constructors, which lay lower on widget tree
  // same for Global key
  GetIt.I.registerLazySingleton<GameBloc>(
    () => GameBloc(
      GetIt.I.get<GenerateGuessNumberUseCase>(),
      GetIt.I.get<MakeAttemptUseCase>(),
    ),
  );
  GetIt.I.registerLazySingleton<GlobalKey<FormState>>(
    () => GlobalKey<FormState>(),
  );
}
