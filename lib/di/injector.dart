// ignore: depend_on_referenced_packages
import 'package:domain/domain.dart';
import 'package:presentation/presentation.dart';

Future<void> initInjector() async {
  initPresentationModule();
  initDomainModule();
}
