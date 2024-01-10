import 'package:flappy_bird/assets.dart';
import 'package:flappy_bird/flappy_bird_game.dart';

import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = 'gameOver';
  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Score:${game.bird.score}',
            style: const TextStyle(
              fontSize: 60,
              color: Colors.white,
              fontFamily: 'Game',
            ),
          ),
          Image.asset(Assets.gameover),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: onRestart,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text(
              "Restart",
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            ' Made by Mohd Sayeed',
            style: TextStyle(
                color: Colors.yellow, fontSize: 18, fontFamily: 'Game'),
          )
        ],
      )),
    );
  }

  void onRestart() {
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
