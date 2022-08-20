
import 'base/base_use_case_in_out.dart';

const noAttempts = 1;

class DecrementAttemptsUseCase extends BaseUseCaseInOut<int, int?> {
  @override
  int? call(int params) => params == noAttempts ? null : --params;
}
