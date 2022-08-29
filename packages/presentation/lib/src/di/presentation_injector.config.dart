// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/domain.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../game_bloc/game_bloc.dart' as _i3;
import 'presentation_injector.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initPresentation(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final presentationModule = _$PresentationModule();
  gh.lazySingleton<_i3.GameBloc>(() => _i3.GameBloc(
      get<_i4.GenerateGuessNumberUseCase>(), get<_i4.MakeAttemptUseCase>()));
  gh.lazySingleton<_i5.GlobalKey<_i5.FormState>>(
      () => presentationModule.key());
  return get;
}

class _$PresentationModule extends _i6.PresentationModule {}
