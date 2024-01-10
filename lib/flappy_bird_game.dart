import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flappy_bird/background.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/configuration.dart';
import 'package:flappy_bird/ground.dart';
import 'package:flappy_bird/pipe_group.dart';
import 'package:flutter/widgets.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late TextComponent score;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;

  FlappyBirdGame();

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      score = buildScore(),
      PipeGroup(),
    ]);
    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
        text: 'Score: 0 ',
        position: Vector2(size.x / 2, size.y / 2 * 0.2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Game'),
        ));
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score:${bird.score}';
    // Additional update logic if needed
  }
}
