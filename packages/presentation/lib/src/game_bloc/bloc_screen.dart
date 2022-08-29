 import 'package:flutter/material.dart';
import 'package:presentation/src/game_bloc/bloc.dart';

abstract class BlocScreen extends StatefulWidget {
  const BlocScreen({Key? key}) : super(key: key);
}

abstract class BlocScreenState<BS extends BlocScreen, B extends Bloc>
    extends State<BS> {
  BlocScreenState(Bloc this.bloc);

  final bloc;

  @override
  void initState() {
    super.initState();
    bloc.initState();
  }
}
