import 'dart:async';
import 'package:flutter/material.dart';
import 'package:presentation/src/game_bloc/bloc_tile.dart';
import 'package:presentation/src/game_bloc/show_snack_bar_event.dart';

abstract class Bloc {
  Stream<BlocTile> get dataStream;

  Stream<UiMessage> get uiEventStream;

  dynamic get tile;

  void initState();
}

abstract class BlocImpl implements Bloc {
  final _data = StreamController<BlocTile>();
  final _uiEventStream = StreamController<UiMessage>();
  BlocTile _blocTile = BlocTile.init();

  @override
  Stream<BlocTile> get dataStream => _data.stream;

  @override
  Stream<UiMessage> get uiEventStream => _uiEventStream.stream;

  @override
  BlocTile get tile => _blocTile;

  @protected
  void emitUiEvent(UiMessage event) => _uiEventStream.add(event);

  @protected
  void emit(
    BlocTile tile,
  ) {
    _blocTile = tile;
    _data.sink.add(_blocTile);
  }

  @override
  void initState() {}
}
