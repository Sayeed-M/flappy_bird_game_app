import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/assets.dart';
import 'package:flappy_bird/configuration.dart';
import 'package:flappy_bird/flappy_bird_game.dart';
import 'package:flappy_bird/pipe.dart';
import 'package:flappy_bird/pipe_position.dart';
import 'package:flutter/foundation.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();
  final _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMiusGround = gameRef.size.y - Config.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightMiusGround / 4);
    final centerY =
        spacing + _random.nextDouble() * (heightMiusGround - spacing);
    addAll([
      Pipe(pipePostion: PipePostion.top, height: centerY - spacing / 2),
      Pipe(
          pipePostion: PipePostion.bottom,
          height: heightMiusGround - (centerY + spacing / 2)),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;
    if (position.x < -10) {
      removeFromParent();
      updateScore();
    }
    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  void updateScore() {
    gameRef.bird.score += 1;
    FlameAudio.play(Assets.point);
  }
}
