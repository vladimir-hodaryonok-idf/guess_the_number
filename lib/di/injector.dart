// ignore: depend_on_referenced_packages
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/presentation.dart';

final getIt = GetIt.instance;

 void configureDependencies() {
  configurePresentationDependencies(getIt);
  configureDomainDependencies(getIt);
}
