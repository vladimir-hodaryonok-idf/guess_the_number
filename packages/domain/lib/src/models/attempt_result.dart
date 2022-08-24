abstract class AttemptResult {}

class WinAttempt implements AttemptResult {}

class LoseAttempt implements AttemptResult {}

class FailAttempt implements AttemptResult {
  final int attemptsRemain;

  FailAttempt({required this.attemptsRemain});
}
