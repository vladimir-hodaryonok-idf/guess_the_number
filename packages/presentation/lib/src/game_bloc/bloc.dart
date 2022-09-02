import 'dart:async';
import 'package:flutter/material.dart';
import 'package:presentation/src/game_bloc/show_snack_bar_event.dart';
import 'package:presentation/src/game_bloc/tile_wrapper.dart';

abstract class Bloc<D> {
  Stream<TileWrapper<D>> get dataStream;

  Stream<UiMessage> get uiEventStream;

  D get tile;

  void initState();
}

abstract class BlocImpl<D> implements Bloc<D> {
  final _data = StreamController<TileWrapper<D>>();
  final _uiEventStream = StreamController<UiMessage>();
  TileWrapper<D> wrapper = TileWrapper.init();
  D _blocTile;

  BlocImpl(this._blocTile);

  @override
  Stream<TileWrapper<D>> get dataStream => _data.stream;

  @override
  Stream<UiMessage> get uiEventStream => _uiEventStream.stream;

  @override
  D get tile => _blocTile;

  @protected
  void emitUiEvent(UiMessage event) => _uiEventStream.add(event);

  @protected
  void emit(D tile, [bool? isLoading]) {
    _blocTile = tile;
    wrapper = wrapper.copyWith(
      isLoading: isLoading,
      data: _blocTile,
    );
    _data.add(wrapper);
  }

  @override
  void initState() {}
}
