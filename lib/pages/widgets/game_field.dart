import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const maxGuessNumber = 10;
const initAttemptsCount = 0;
const maxAttempts = 3;

class GameField extends StatefulWidget {
  const GameField({Key? key}) : super(key: key);

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  late int _guessNumber;
  int _guessAttemptsCount = initAttemptsCount;
  int? _suggestedNumber;
  bool _isGuessTrue = false;
  static final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _guessNumber = _generateGuessNumber();
    super.initState();
  }

  int _generateGuessNumber() {
    final random = Random();
    final number = random.nextInt(maxGuessNumber);
    if (kDebugMode) {
      print('Hint: number is $number');
    }
    return number;
  }

  String? _validator(String? text) => (text != null &&
          ((int.tryParse(text) ?? -1) > maxGuessNumber ||
              (int.tryParse(text) ?? -1) < 0))
      ? 'Incorrect input'
      : null;

  void onMakeTryClick() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        if (_suggestedNumber == null) return;
        _guessAttemptsCount++;
        if (_suggestedNumber == _guessNumber) {
          _isGuessTrue = true;
        } else {
          _showSnackBar();
        }
      });
    }
  }

  void _showSnackBar() {
    final message =
        'WRONG! Attempts left: ${maxAttempts - _guessAttemptsCount}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void onNewGameClick() => setState(() {
        _guessNumber = _generateGuessNumber();
        _guessAttemptsCount = initAttemptsCount;
        _formKey.currentState?.reset();
        _isGuessTrue = false;
      });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isGuessTrue
                ? const Text('Correct!')
                : const Text('Guess the number (0..10)'),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                onChanged: (text) => _suggestedNumber = int.tryParse(text),
                validator: _validator,
                maxLength: 2,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Guess the number',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                    onPressed:
                        _isGuessTrue || _guessAttemptsCount >= maxAttempts
                            ? onNewGameClick
                            : null,
                    child: const Text('New Game')),
                TextButton(
                    onPressed:
                        !_isGuessTrue && _guessAttemptsCount < maxAttempts
                            ? onMakeTryClick
                            : null,
                    child: const Text('Make a try')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
