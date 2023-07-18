import 'package:flutter/material.dart';
import 'package:frendify/widgets/pin_circle.dart';

class CodeCircles extends StatelessWidget {
  const CodeCircles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: PinCircle()),
        Expanded(child: PinCircle()),
        Expanded(child: PinCircle()),
        Expanded(child: PinCircle()),
      ],
    );
  }
}
