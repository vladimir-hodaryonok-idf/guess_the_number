abstract class GameEvent {}

class MakeAttemptEvent extends GameEvent {}

class NewGameEvent extends GameEvent {}

class SetSuggestedNumberEvent extends GameEvent {
  final int number;

  SetSuggestedNumberEvent({required this.number});
}
