
import 'package:flutter/material.dart';


class StyledText extends StatelessWidget {
  const StyledText({
    Key? key,
    required this.text,
    required this.size,
    // required this.press,
  }) : super(key: key);

  final String text;
  final int size;
  // final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            // fontFamily: 'SnowCrab',
            fontSize: size.toDouble(),
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}