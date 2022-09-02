abstract class UiMessage {
  final String message = 'init message';
}

class NewGameMessage extends UiMessage {
  final String message = 'Game started!';
}

class AttemptsRemainMessage extends UiMessage {
  AttemptsRemainMessage(int attemptsRemain)
      : message = 'Attempts left: $attemptsRemain';
  final String message;
}

class LoseMessage extends UiMessage {
  final String message = 'You Lose!';
}

class WinMessage extends UiMessage {
  final String message = 'Correct!';
}
