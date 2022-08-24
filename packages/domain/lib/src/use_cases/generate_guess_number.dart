import 'dart:math';
import 'package:domain/src/use_cases/base/base_use_case_out.dart';

const maxGuessNumber = 10;

class GenerateGuessNumberUseCase extends BaseUseCaseOut<int> {
  @override
  int call() => _generateGuessNumber();

  int _generateGuessNumber() {
    final random = Random();
    final number = random.nextInt(maxGuessNumber);
    print('Hint: number is $number');
    return number;
  }
}
