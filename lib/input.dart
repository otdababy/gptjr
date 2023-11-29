import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gptjr/api/get_translation_api.dart';
import 'package:gptjr/errorpop.dart';
import 'package:gptjr/result.dart';
import 'package:gptjr/widget/styledbutton.dart';
import 'widget/styledtext.dart';

class InputPage extends StatefulWidget {
  late String _name;
  InputPage(String name){
    _name = name;
  }

  @override
  State<InputPage> createState() => _InputPageState(_name);
}

class _InputPageState extends State<InputPage> {
  late String _name;

  _InputPageState(String name) {
    _name = name;
  }

  bool loading1 = false;
  bool loading2 = false;
  bool loading3 = false;



  void handleTranslation(int text) async {
      //GET request
      try{
        //Add loading popup?
        setState(() {
          if(text==1)
            loading1 = true;
          else if(text==2)
            loading2 = true;
          else if(text==3)
            loading3 = true;
        });
        var a = await TranslationGetApi.getTranslation(_name, text, 1);
        final body = json.decode(a.body.toString());
        //result from GET
        // final result = body['result'];
        //Get 성공
        // print(body);
        print(body);
        
        Navigator.push(context, MaterialPageRoute(
        builder: (_) => ResultPage(body, text, 1)));
      }
      catch(e) {
        //Show failed popup
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            //ask score system api
            return PopupE(
              title:
                  "Please try again at a later time.",
            );
          });
        print('실패함');
        print(e.toString());
      }
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
            padding: const EdgeInsets.all(100.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Tap the research paper you would like to translate $_name!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                ),
                Container(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: GestureDetector(
                    onTap: (){
                      handleTranslation(1);
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("1. \"Charlie and the Semi-Automated Factory: Data-Driven Operator Behavior and Performance Modeling for Human-Machine Collaborative Systems\"", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                          loading1 == true ? CircularProgressIndicator() : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: GestureDetector(
                    onTap: (){
                      handleTranslation(2);
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                          // color: Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("2. \"Cells, Generators, and Lenses: Design Framework for Object-Oriented Interaction with Large Language Models\"", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                          loading2 == true ? CircularProgressIndicator() : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: GestureDetector(
                    onTap: (){
                      handleTranslation(3);
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("3. \"Selecting Distant Objects in VR Through a Mobile Device\"", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                          loading3 == true ? CircularProgressIndicator() : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
                
              ],
            )
          )
      ),
    );
  }
}

// Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     margin: const EdgeInsets.all(30.0),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey)
//                     ),
//                     child: Column(
//                       children: [
//                         //Textfield for translation
//                         Column(
//                           children: [
//                             Container(
//                               height: 600,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: TextField(
//                                   controller: _controller,
//                                   decoration: new InputDecoration(
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.white),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.white),
//                                     ),
//                                     hintText: 'Welcome to GPT Jr. $_name!\nEnter a text you want to translate',
//                                   ),
//                                   keyboardType: TextInputType.multiline,
//                                   maxLines: null,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Spacer(),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             // on press,
//                             // send text,
//                             // get result
//                             // navigate to resultpage with result
//                             StyledButton(text: "Translate", width: 200, height: 70, press: (){handleTranslation(_controller.text);})
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),