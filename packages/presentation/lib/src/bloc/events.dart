abstract class GameEvent {}

class MakeAttempt extends GameEvent {}

class NewGame extends GameEvent {}

class SetSuggestedNumber extends GameEvent {
  final int number;

  SetSuggestedNumber({required this.number});
}
