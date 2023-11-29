import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gptjr/api/get_translation_api.dart';
import 'package:gptjr/result.dart';
import 'package:gptjr/widget/styledbutton.dart';
import 'widget/styledtext.dart';

class EndPage extends StatefulWidget {
  late String _name;
  EndPage(String name){
    _name = name;
  }

  @override
  State<EndPage> createState() => _EndPageState(_name);
}

class _EndPageState extends State<EndPage> {
  late String _name;

  _EndPageState(String name) {
    _name = name;
  }


  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: StyledText(text: "GPT Jr",size: 20,),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Thank you for your participation $_name."),
                Container(height: 50,),
                Text("We will remember your customized preferences, so when you visit GPT Jr. again, your preferences will be automatically applied"),
                Container(height: 50,),
                Text("If you have any questions, please contact us at jchaemin@kaist.ac.kr"),

                
              ],
            )
          )
      ),
    );
  }
}