import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class GameController extends ChangeNotifier {
  // Bird state
  double birdY = 0.0;
  double initialPos = 0.0;
  double birdWidth = 0.2;
  double birdHeight = 0.2;

  // Physics
  double height = 0.0;
  double time = 0.0;
  double velocity = 0.3;
  // runtime tuning
  /// Difficulty multiplier (1.0 = normal). >1 = harder/faster, <1 = easier/slower.
  double difficulty = 1.0;

  /// When true use gentler web tuning by default; this can be overridden at runtime.
  bool useWebTuning = kIsWeb;

  // legacy compatibility: no-op (fields above are authoritative)

  // Barriers
  List<double> barrierX = [2, 2 + 1.5];
  double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.4, 0.3],
    [0.3, 0.5],
  ];
  List<bool> _scored = [false, false];

  // Game state
  bool gameStarted = false;
  bool isGameOver = false;
  int score = 0;
  int highScore = 0;

  Timer? _timer;
  final AudioPlayer? _audioPlayer;

  GameController({bool enableAudio = true})
      : _audioPlayer = enableAudio ? AudioPlayer() : null {
    _loadHighScore();
  }

  // computed tuning getters
  double get _gravity => (useWebTuning ? -3.5 : -4.9) * difficulty;
  double get _jumpVelocity => (useWebTuning ? 2.2 : 3.5) * difficulty;
  double get _barrierSpeed => (useWebTuning ? 0.035 : 0.05) * difficulty;
  double get _timeStep => useWebTuning ? 0.05 : 0.1;

  /// Set runtime difficulty (0.5..2.0 recommended)
  void setDifficulty(double d) {
    difficulty = d.clamp(0.2, 3.0);
    notifyListeners();
  }

  /// Override whether to use the web tuning (default is auto-detected via kIsWeb)
  void setUseWebTuning(bool v) {
    useWebTuning = v;
    notifyListeners();
  }

  void startGame() {
    if (gameStarted) return;
    gameStarted = true;
    isGameOver = false;
    _timer?.cancel();
    time = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 25), (timer) {
      // Parabolic motion
      height = (_gravity * time * time) + (velocity * time);
      birdY = initialPos - height;

      moveMap();
      _updateScore();

      if (birdIsDead()) {
        _timer?.cancel();
        _timer = null;
        gameStarted = false;
        isGameOver = true;
        _saveHighScore();
        HapticFeedback.mediumImpact();
        // try to play hit sound (asset optional)
        try {
          _audioPlayer?.play(AssetSource('audio/hit.wav'));
        } catch (_) {
          // ignore if asset missing (tests/environment)
        }
      }

      // advance time using configured timestep
      time += _timeStep;
      notifyListeners();
    });
    notifyListeners();
  }

  void jump() {
    // give a quick impulse
    try {
      _audioPlayer?.play(AssetSource('audio/jump.wav'));
    } catch (_) {}
    time = 0;
    initialPos = birdY;
    // use computed jump velocity
    velocity = _jumpVelocity;
    notifyListeners();
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      // horizontal movement scaled by barrier speed getter
      barrierX[i] -= _barrierSpeed;
      if (barrierX[i] < -1 - barrierWidth) {
        barrierX[i] = 2 + (i * 1.5);
        final top = randomBetween(0.15, 0.45);
        final bottom = randomBetween(0.15, 0.45);
        barrierHeight[i] = [top, bottom];
        _scored[i] = false;
      }
    }
    // update score after moving barriers
    _updateScore();
  }

  void _updateScore() {
    for (int i = 0; i < barrierX.length; i++) {
      if (!_scored[i] && barrierX[i] < -birdWidth) {
        _scored[i] = true;
        score += 1;
      }
    }
  }

  static double randomBetween(double d, double e) {
    return d + (e - d) * Random().nextDouble();
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) return true;
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  void resetGame() {
    _timer?.cancel();
    _timer = null;
    birdY = 0.0;
    initialPos = birdY;
    time = 0;
    velocity = 0.3;
    gameStarted = false;
    isGameOver = false;
    score = 0;
    barrierX = [2, 2 + 1.5];
    barrierHeight = [
      [0.4, 0.3],
      [0.3, 0.5],
    ];
    _scored = [false, false];
    notifyListeners();
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    highScore = prefs.getInt('highScore') ?? 0;
    notifyListeners();
  }

  Future<void> _saveHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    if (score > highScore) {
      highScore = score;
      await prefs.setInt('highScore', highScore);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
