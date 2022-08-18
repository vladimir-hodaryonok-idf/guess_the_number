import 'package:guess_the_number/domain/models/attempt_params.dart';
import 'package:guess_the_number/domain/use_cases/base/base_use_case_in_out.dart';

class MakeAttemptUseCase extends BaseUseCaseInOut<AttemptParams, bool> {
  @override
  bool call(AttemptParams params) =>
      params.guessNumber == params.suggestedNumber;
}
