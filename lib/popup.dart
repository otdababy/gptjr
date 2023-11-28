
import 'package:flutter/material.dart';


class Popup extends StatelessWidget {
  const Popup({
    Key? key,
    required this.title,
    required this.replacements,
    required this.matched
    // required this.press,
  }) : super(key: key);

  final String title;
  final Map<dynamic,dynamic> matched;
  final Map<dynamic,dynamic> replacements;
  // final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Container(
        height: 150,
        width: 400,
        child: Padding(
          padding: EdgeInsets.only(top: (25.0)),
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SnowCrab',
                  fontSize: 17,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),
      ),
      actions: [
        Container(
          width: 100,
          height: 40,
          child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                
              },
              child: Text('View Original Text', style: TextStyle(fontFamily: 'SnowCrab',
                  fontWeight: FontWeight.w500,
                  fontSize: (12),
                  color: Colors.white),)
          ),
        ),
        Container(
          width: 100,
          height: 40,
          child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Select Replacement Text', style: TextStyle(fontFamily: 'SnowCrab',
                  fontWeight: FontWeight.w500,
                  fontSize: (12),
                  color: Colors.white),)
          ),
        )
      ],
    );
  }
}