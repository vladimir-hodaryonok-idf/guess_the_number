import 'package:flutter/material.dart';
import 'package:presentation/src/game_bloc/bloc.dart';

abstract class BlocScreen extends StatefulWidget {}

abstract class BlocScreenState<BS extends BlocScreen, B extends Bloc>
    extends State<BS> {
  BlocScreenState(B this.bloc);

  final B bloc;

  @override
  void initState() {
    super.initState();
    bloc.initState();
  }
}
