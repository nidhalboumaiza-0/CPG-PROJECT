import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton(
      {required this.icon, required this.onPressAction, required this.colour});
  final IconData icon;
  final VoidCallback onPressAction;
  final Color colour;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: onPressAction,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 49.0,
        height: 49.0,
      ),
      shape: CircleBorder(),
      fillColor: colour,
    );
  }
}
