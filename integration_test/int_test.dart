// ignore_for_file: depend_on_referenced_packages
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:guess_the_number/main.dart' as app;

void main() {
  if (Platform.isAndroid) {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    group('Emulator_Test', () {
      testWidgets('Test', (widgetTester) async {
        app.main();
        await widgetTester.pumpAndSettle(const Duration(seconds: 1));
        final newGameBtn = find.text('New Game');
        expect(newGameBtn, findsOneWidget);
      });
    });
  }
}
