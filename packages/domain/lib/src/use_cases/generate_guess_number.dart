import 'dart:math';
import 'package:injectable/injectable.dart';
import 'package:domain/src/use_cases/base/base_use_case_out.dart';

const maxGuessNumber = 10;

@injectable
class GenerateGuessNumberUseCase extends BaseUseCaseOut<int> {
  @override
  int call() {
    final random = Random();
    final number = random.nextInt(maxGuessNumber);
    print('Hint: number is $number');
    return number;
  }
}
