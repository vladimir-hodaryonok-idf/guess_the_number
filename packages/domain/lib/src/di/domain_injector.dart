import 'package:get_it/get_it.dart';
import 'package:domain/domain.dart';

Future<void> initDomainModule() async {
  initUseCaseModule();
}

void initUseCaseModule() {
  GetIt.I.registerFactory(() => GenerateGuessNumberUseCase());
  GetIt.I.registerFactory(() => MakeAttemptUseCase());
}
