import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motorcyclegame/button.dart';
import 'package:motorcyclegame/motor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double motorX = 0;
  static double motorY = 1;
  double treeX = 0.5;
  double treeY = 1;
  double time = 0;
  double height = 0;
  double initialHeight = motorY;
  String direction = "right";

  var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, fontSize: 20));

  void preJump() {
    time = 0;
    initialHeight = motorY;
  }

  void jump() {
    preJump();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 5 * time;

      if (initialHeight - height > 1) {
        setState(() {
          motorY = 1;
        });
        timer.cancel();
      } else {
        setState(() {
          motorY = initialHeight - height;
        });
      }
    });
  }

  void moveRigt() {
    direction = "right";
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (MyButton().userIsHoldingButton() == true && (motorX + 0.02) < 1) {
        setState(() {
          motorX += 0.02;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = "left";
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (MyButton().userIsHoldingButton() == true && (motorX - 0.02) > -1) {
        setState(() {
          motorX -= 0.02;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    child: AnimatedContainer(
                      alignment: Alignment(motorX, motorY),
                      duration: Duration(milliseconds: 0),
                      child: MyMotor(
                        direction: direction,
                      ),
                    ),
                    color: Colors.blue,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("MOTOR", style: gameFont),
                            SizedBox(height: 10),
                            Text("0000", style: gameFont)
                          ],
                        ),
                        Column(
                          children: [
                            Text("WORLD", style: gameFont),
                            SizedBox(height: 10),
                            Text("1-1", style: gameFont)
                          ],
                        ),
                        Column(
                          children: [
                            Text("TIME", style: gameFont),
                            SizedBox(height: 10),
                            Text("9999", style: gameFont)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(child: Icon(Icons.arrow_back), function: moveLeft),
                  MyButton(
                      child: Icon(Icons.arrow_forward), function: moveRigt),
                  MyButton(child: Icon(Icons.arrow_upward), function: jump),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
