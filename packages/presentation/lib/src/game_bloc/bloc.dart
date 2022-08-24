import 'dart:async';
import 'package:flutter/material.dart';
import 'package:presentation/src/game_bloc/bloc_tile.dart';
import 'package:presentation/src/game_bloc/events.dart';

abstract class Bloc {
  Stream<BlocTile> get dataStream;

  Stream<BlocEvent> get eventStream;

  dynamic get tile;

  void initState();
}

abstract class BlocImpl implements Bloc {
  final _data = StreamController<BlocTile>();
  final _events = StreamController<BlocEvent>();
  BlocTile _blocTile = BlocTile.init();

  @override
  Stream<BlocTile> get dataStream => _data.stream;

  @override
  Stream<BlocEvent> get eventStream => _events.stream;

  @override
  BlocTile get tile => _blocTile;

  @protected
  void emit(
    BlocTileState? status, [
    int? attemptsRemain,
    int? guessedNumber,
    int? suggestedNumber,
  ]) {
    _blocTile = _blocTile.copyWith(
      status,
      guessedNumber,
      suggestedNumber,
      attemptsRemain,
    );
    _data.sink.add(_blocTile);
  }

  @protected
  void handleEvent(BlocEvent event) => _events.add(event);

  @override
  void initState() {}
}
