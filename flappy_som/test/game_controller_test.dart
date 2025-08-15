import 'package:flutter_test/flutter_test.dart';
import 'package:flappy_som/controllers/game_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('GameController - collision and scoring', () {
    late GameController controller;

    setUp(() {
      // ensure Flutter bindings and mock preferences for tests
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      controller = GameController(enableAudio: false);
      // stop the controller timer for unit testing
      controller.resetGame();
    });

    test('birdIsDead returns true when bird out of bounds', () {
      controller.birdY = 2.0; // beyond lower bound
      expect(controller.birdIsDead(), true);
      controller.birdY = -2.0; // beyond upper bound
      expect(controller.birdIsDead(), true);
    });

    test('birdIsDead detects collision with barrier', () {
      // position barrier across bird
      controller.birdY = 0.0;
      // place barrier at collision x
      controller.barrierX[0] = controller.birdWidth; // overlaps horizontally
      // set barrier heights so it collides at birdY (make gap tiny)
      controller.barrierHeight[0] = [1.0, 1.0];
      expect(controller.birdIsDead(), true);
    });

    test('score increments when barrier passes bird', () {
      controller.score = 0;
      // barrier just before passing
      controller.barrierX[0] = -controller.birdWidth + 0.01;
      // moving map will advance barrier and trigger scoring
      controller.moveMap();
      expect(controller.score, 1);
    });

    test('resetGame resets state', () {
      controller.score = 5;
      controller.birdY = 0.5;
      controller.resetGame();
      expect(controller.score, 0);
      expect(controller.birdY, 0.0);
      expect(controller.gameStarted, false);
    });
  });
}
