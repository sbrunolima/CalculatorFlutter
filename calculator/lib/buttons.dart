import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  MyButtons(this.color, this.textColor, this.buttonText, this.buttonTapped);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(0.1),
        child: ClipRRect(
          borderRadius: BorderRadius.horizontal(),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: textColor, fontSize: 26),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
