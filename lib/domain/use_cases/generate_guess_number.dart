import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:guess_the_number/constants/global.dart';
import 'package:guess_the_number/domain/use_cases/base/base_use_case_out.dart';

class GenerateGuessNumberUseCase extends BaseUseCaseOut<int> {
  @override
  int call() => _generateGuessNumber();

  int _generateGuessNumber() {
    final random = Random();
    final number = random.nextInt(maxGuessNumber);
    if (kDebugMode) {
      print('Hint: number is $number');
    }
    return number;
  }
}
