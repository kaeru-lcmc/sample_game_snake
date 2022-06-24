import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled/piece.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  //画面の幅と高さを取得する
  late int upBoundX, upBoundY, lowBoundX, lowBoundY;
  late double screenWidth, screenHeight;

  int step = 20;
  List<Offset> positions = [];

  int getNearestTens(int num) {
    int output;
    output = (num ~/ step) * step;
    if (output == 0) {
      output += step;
    }
    return output;
  }

  Offset getNextPosition() {
    Offset position;
    int posX = Random().nextInt(upBoundX) + lowBoundX;
    int posY = Random().nextInt(upBoundY) + lowBoundY;
    position = Offset(
      getNearestTens(posX).toDouble(),
      getNearestTens(posY).toDouble(),
    );
    return position;
  }

  void draw() {
    if (positions.length == 0) {
      positions.add(getNextPosition());
    }
  }

  List<Piece> getPieces() {
    final pieces = <Piece>[];
    draw();
    pieces.add(Piece(
      posX: positions[0].dx.toInt(),
      posY: positions[0].dy.toInt(),
      size: step,
      color: Colors.red,
    ));
    return pieces;
  }

  @override
  Widget build(BuildContext context) {
    //画面の高さを取得
    screenHeight = MediaQuery.of(context).size.height;
    //画面の幅を取得
    screenWidth = MediaQuery.of(context).size.width;
    lowBoundX = step;
    lowBoundY = step;
    upBoundX = getNearestTens(screenWidth.toInt() - step);
    upBoundY = getNearestTens(screenHeight.toInt() - step);

    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Stack(
          children: [
            Stack(
              children: getPieces(),
            )
          ],
        ),
      ),
    );
  }
}
