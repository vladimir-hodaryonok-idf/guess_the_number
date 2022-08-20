import 'dart:math';

import 'base/base_use_case_out.dart';

class GenerateGuessNumberUseCase extends BaseUseCaseOut<int> {

  @override
  int call() => _generateGuessNumber();

  int _generateGuessNumber() {
    final random = Random();
    final number = random.nextInt(10);
    // if (kDebugMode) {
      print('Hint: number is $number');
    // }
    return number;
  }
}
