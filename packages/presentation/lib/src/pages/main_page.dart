import 'package:flutter/material.dart';
import 'package:presentation/src/pages/widgets/game_field.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static const title = 'Guess the number';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: GameField(),
    );
  }
}
