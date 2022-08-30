import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/presentation.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  configurePresentationDependencies(getIt);
  configureDomainDependencies(getIt);
}
