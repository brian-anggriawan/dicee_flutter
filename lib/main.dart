import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 45, 200, 185),
        appBar: AppBar(
          title: Text('Random Dice'),
          backgroundColor: Colors.teal,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 3;
  int rightDiceNumber = 1;
  bool isButtonDisabled = false;

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  Widget textButtonRandomDice() {
    if (isButtonDisabled) {
      return Text('Dice is processing random ....');
    } else {
      return Text('Random Dice');
    }
  }

  dynamic randomDice() {
    if (isButtonDisabled) {
      return null;
    } else {
      return () async {
        setState(() {
          isButtonDisabled = true;
        });
        for (var i = 0; i < 5; i++) {
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            leftDiceNumber = random(1, 7);
            rightDiceNumber = random(1, 7);
          });
        }
        setState(() {
          isButtonDisabled = false;
        });
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(7),
                child: Image.asset('images/dice$leftDiceNumber.png'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(7),
                child: Image.asset('images/dice$rightDiceNumber.png'),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: randomDice(),
          child: textButtonRandomDice(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
          ),
        )
      ],
    );
  }
}
