 import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/src/game_bloc/bloc.dart';

abstract class BlocScreen extends StatefulWidget {
  const BlocScreen({Key? key}) : super(key: key);
}

//@injectable
abstract class BlocScreenState<BS extends BlocScreen, B extends Bloc>
    extends State<BS> {
  // BlocScreenState(Bloc this.bloc);
  @protected
  final bloc = GetIt.I.get<B>();

  @override
  void initState() {
    super.initState();
    bloc.initState();
  }
}
