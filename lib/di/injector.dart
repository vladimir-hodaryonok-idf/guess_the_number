import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/presentation.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  configurePresentationDependencies(getIt);
  configureDomainDependencies(getIt);
}