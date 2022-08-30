import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/game_bloc/bloc_screen.dart';
import 'package:presentation/src/game_bloc/bloc_tile.dart';
import 'package:presentation/src/game_bloc/game_bloc.dart';
import 'package:presentation/src/pages/widgets/game_form.dart';

class GameField extends BlocScreen {
  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends BlocScreenState<GameField, GameBloc> {
  _GameFieldState()
      : super(
          GameBloc(
            GenerateGuessNumberUseCase(),
            MakeAttemptUseCase(),
            GlobalKey<FormState>(),
          ),
        );

  @override
  void initState() {
    super.initState();
    bloc.uiEventStream.listen((event) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(event.message),
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<BlocTile>(
        stream: bloc.dataStream,
        builder: (context, snapshot) {
          final tile = snapshot.data;
          if (tile == null) return Center(child: CircularProgressIndicator());
          return GameForm(
            tile: tile,
            bloc: bloc,
          );
        },
      ),
    );
  }
}
