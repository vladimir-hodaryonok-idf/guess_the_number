import 'package:domain/domain.dart';
import 'package:domain/src/use_cases/base/base_use_case_in_out.dart';

const noAttempts = 1;

class MakeAttemptUseCase
    extends BaseUseCaseInOut<AttemptParams, AttemptResult> {
  @override
  AttemptResult call(AttemptParams params) {
    if (params.guessNumber == params.suggestedNumber &&
        params.attemptsRemain != noAttempts) {
      return WinAttempt();
    }
    if (params.attemptsRemain == noAttempts) return LoseAttempt();
    return FailAttempt(attemptsRemain: params.attemptsRemain.decrement());
  }
}

extension Decrementer on int {
  int decrement() => this - 1;
}
