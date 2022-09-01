// ignore: depend_on_referenced_packages
import 'package:domain/domain.dart';
import 'package:presentation/presentation.dart';

void initInjector() {
  initPresentationModule();
  initDomainModule();
}
