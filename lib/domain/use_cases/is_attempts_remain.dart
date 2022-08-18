import 'package:guess_the_number/domain/use_cases/base/base_use_case_in_out.dart';

const noAttempts = 1;

class IsAttemptsOver extends BaseUseCaseInOut<int, bool> {
  @override
  bool call(int params) => params == noAttempts;
}
