import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/src/di/presentation_injector.config.dart';

@InjectableInit(initializerName: r'$initPresentation')
void configurePresentationDependencies(GetIt getIt) => $initPresentation(getIt);

@module
abstract class PresentationModule {
  @lazySingleton
  GlobalKey<FormState> key() => GlobalKey<FormState>();
}
