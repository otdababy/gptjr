
import 'package:flutter/material.dart';
import 'package:gptjr/widget/styledtext.dart';


class StyledButton extends StatelessWidget {
  const StyledButton({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    // required this.press;

    required this.press,
  }) : super(key: key);

  final String text;
  final double width;
  final double height;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.grey),
        ),
        width: width,
        height: height,
        child: TextButton(
          onPressed: press,
          child: StyledText(
            text: text,
            size: 15,
          ),
        ),
      ),
    );
  }
}