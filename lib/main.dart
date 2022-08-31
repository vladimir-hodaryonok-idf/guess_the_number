import 'package:flutter/material.dart';
import 'package:guess_the_number/di/injector.dart';
import 'package:presentation/presentation.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}
