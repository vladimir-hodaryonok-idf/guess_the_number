abstract class BlocEvent {}

class MakeAttemptEvent extends BlocEvent {}

class NewGameEvent extends BlocEvent {}

class SetSuggestedNumberEvent extends BlocEvent {
  final int number;

  SetSuggestedNumberEvent({required this.number});
}
