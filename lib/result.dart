import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:gptjr/end_page.dart';
import 'package:gptjr/errorpop.dart';
import 'package:gptjr/popup.dart';
import 'package:gptjr/api/add_preference_api.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gptjr/api/get_translation_api.dart';
import 'package:gptjr/result.dart';
import 'package:gptjr/widget/styledbutton.dart';
import 'widget/styledtext.dart';

class ResultPage extends StatefulWidget {
  late Map<dynamic, dynamic> _result;
  late int _t;
  late int _p;

  ResultPage(Map<dynamic, dynamic> result, int t, int p) {
    _result = result;
    _p = p;
    _t = t;
  }

  @override
  _ResultPageState createState() => _ResultPageState(_result, _t, _p);
}

class _ResultPageState extends State<ResultPage> {
  late Map<dynamic, dynamic> _result;
  late int _t;
  late int _p;

  _ResultPageState(Map<dynamic, dynamic> result, int t, int p) {
    _result = result;
    _t = t;
    _p = p;
  }

  final List<InlineSpan> _textSpans = [];
  late String ogtext;
  late String showogtext;

  @override
  void initState() {
    super.initState();
    _generateTextSpans(_result['targettext']);
    ogtext = _result['targettext'];
    showogtext = _result['sourcetext'];
  }

  List<dynamic> _rec = [];
  // bool showog = true;
  // String showogtext = '';
  String showogword = '';

  void _generateTextSpans(String text) {
    // print(text);
    setState(() {
      _textSpans.clear();
    final words = text.split(' ');
    for (var word in words) {
      print(word);
      _textSpans.add(
        TextSpan(
          text: word + ' ',
          style: TextStyle(
            color: Colors.black,
            // decoration: TextDecoration.underline,
            // Add any other styles you need here
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              _handleWordTap(word);
            },
        ),
      );
    }
    });
  }

  void _addPref(String selectedWord, String newWord) async {
    try{
        //Add loading popup?
        
        var a = await PreferencePutApi.putPreference(_result['username'],selectedWord,newWord);
        final body = json.decode(a.body.toString());
        //result from GET
        // final result = body['result'];
        //Get 성공
        // print(body);
        String suggestion = body['ngram'];
        print("suggestion is ... $suggestion");
        if(ogtext.contains(suggestion)){
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              //ask score system api
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Container(
                  height: 150,
                  width: 400,
                  child: Padding(
                    padding: EdgeInsets.only(top: (25.0)),
                    child: Center(
                      child: Text(
                        "We found similar word \"$suggestion\" in the target text.\n Would you like to change this text?",
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
                  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 200,
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
          width: 200,
          height: 40,
          child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Colors.black,
              ),
              onPressed: () async {
                Navigator.pop(context);
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                            return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Container(
                    height: 150,
                    width: 400,
                    child: Padding(
                      padding: EdgeInsets.only(top: (25.0)),
                      child: Center(
                        child: Text(
                          "Choose your replacement word",
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
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            height: 40,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  backgroundColor: Colors.black,
                                ),
                                onPressed: () {
                                  setState((){
                                    ogtext = ogtext.replaceAll(selectedWord, _result['replacements'][selectedWord][0]);
                                    print(ogtext);
                                    _addPref(selectedWord, _result['replacements'][selectedWord][0]);
                                    // await PreferencePutApi.putPreference(_result['username'],selectedWord,_result['replacements'][selectedWord][0]);
                                    _generateTextSpans(ogtext);
                                    Widget a = Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        child: 
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("Recommended replacement text of $selectedWord"),
                                              Container(height: 10,),
                                              Text(_result['replacements'][selectedWord][0]),
                                            ],
                                          )
                                      ),
                                    );
                                    _rec.add(a); 
                                    // Navigator.pop(context);
                                    
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text(_result['replacements'][selectedWord][0], style: TextStyle(fontFamily: 'SnowCrab',
                                    fontWeight: FontWeight.w500,
                                    fontSize: (12),
                                    color: Colors.white),)
                            ),
                          ),
                          Container(
                      width: 150,
                      height: 40,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            setState(() async {
                              ogtext = ogtext.replaceAll(selectedWord, _result['replacements'][selectedWord][1]);
                              print(ogtext);
                              _addPref(selectedWord, _result['replacements'][selectedWord][1]);
                              _generateTextSpans(ogtext);
                              Widget a = Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: 
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Recommended replacement text of $selectedWord"),
                                        Container(height: 10,),
                                        Text(_result['replacements'][selectedWord][1]),
                                      ],
                                    )
                                ),
                              );
                              _rec.add(a); 
                              // Navigator.pop(context);
                            });
                            // Navigator.of(context).pop();
                          },
                          child: Text(_result['replacements'][selectedWord][1], style: TextStyle(fontFamily: 'SnowCrab',
                              fontWeight: FontWeight.w500,
                              fontSize: (12),
                              color: Colors.white),)
                      ),
                    ),
                        ],
                      ),
                    ),
                  ],
                );});
              },
              child: Text('Select Replacement Text', style: TextStyle(fontFamily: 'SnowCrab',
                  fontWeight: FontWeight.w500,
                  fontSize: (12),
                  color: Colors.white),)
          ),
        )
            ],
          ),
        ),
                ],
              );
            });
        }
          // _handleWordTap(suggestion);
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
    

    // await PreferencePutApi.putPreference(_result['username'],selectedWord,newWord);
  
  

  void _handleWordTap(String selectedWord) async {
    // Perform actions based on the selected word, e.g., show dialog or navigate to another page.
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        //ask score system api
        return AlertDialog(
      backgroundColor: Colors.white,
      title: Container(
        height: 150,
        width: 400,
        child: Padding(
          padding: EdgeInsets.only(top: (25.0)),
          child: Center(
            child: Text(
               "Which action do you want to perform with $selectedWord?",
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
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 200,
                height: 40,
                child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      print("selectedWord");
                      print(_result['matched']);
                      print(selectedWord);
                      print(_result['matched'][selectedWord]);
                      setState((){
                        ogtext = ogtext.replaceAll(selectedWord, _result['matched'][selectedWord]);
                        // showogtext = _result['sourcetext'];
                        showogword = _result['matched'][selectedWord];
                        print(ogtext);
                        _generateTextSpans(ogtext);
                        Widget a = Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: 
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Original text of \"$selectedWord\""),
                                  Container(height: 10,),
                                  Text(_result['matched'][selectedWord]),
                                ],
                              )
                          ),
                        );
                        _rec.add(a); 
                        _addPref(selectedWord, _result['matched'][selectedWord]);
                        Navigator.pop(context);
                      });
                    },
                    child: Text('View Original Text', style: TextStyle(fontFamily: 'SnowCrab',
                        fontWeight: FontWeight.w500,
                        fontSize: (12),
                        color: Colors.white),)
                ),
              ), Container(width: 10,),
              Container(
          width: 200,
          height: 40,
          child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Colors.black,
              ),
              onPressed: () async {
                Navigator.pop(context);
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                            return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Container(
                    height: 150,
                    width: 400,
                    child: Padding(
                      padding: EdgeInsets.only(top: (25.0)),
                      child: Center(
                        child: Text(
                          "Choose your replacement word",
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
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            height: 40,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  backgroundColor: Colors.black,
                                ),
                                onPressed: () {
                                  setState((){
                                    ogtext = ogtext.replaceAll(selectedWord, _result['replacements'][selectedWord][0]);
                                    print(ogtext);
                                    _addPref(selectedWord, _result['replacements'][selectedWord][0]);
                                    // await PreferencePutApi.putPreference(_result['username'],selectedWord,_result['replacements'][selectedWord][0]);
                                    _generateTextSpans(ogtext);
                                    Widget a = Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        child: 
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("Recommended replacement text of $selectedWord"),
                                              Container(height: 10,),
                                              Text(_result['replacements'][selectedWord][0]),
                                            ],
                                          )
                                      ),
                                    );
                                    _rec.add(a); 
                                    Navigator.pop(context);
                                    
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text(_result['replacements'][selectedWord][0], style: TextStyle(fontFamily: 'SnowCrab',
                                    fontWeight: FontWeight.w500,
                                    fontSize: (12),
                                    color: Colors.white),)
                            ),
                          ),
                          Container(
                      width: 150,
                      height: 40,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            setState(() async {
                              ogtext = ogtext.replaceAll(selectedWord, _result['replacements'][selectedWord][1]);
                              print(ogtext);
                              _addPref(selectedWord, _result['replacements'][selectedWord][1]);
                              _generateTextSpans(ogtext);
                              Widget a = Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  child: 
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Recommended replacement text of $selectedWord"),
                                        Container(height: 10,),
                                        Text(_result['replacements'][selectedWord][1]),
                                      ],
                                    )
                                ),
                              );
                              _rec.add(a); 
                              Navigator.pop(context);
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text(_result['replacements'][selectedWord][1], style: TextStyle(fontFamily: 'SnowCrab',
                              fontWeight: FontWeight.w500,
                              fontSize: (12),
                              color: Colors.white),)
                      ),
                    ),
                        ],
                      ),
                    ),
                  ],
                );});
              },
              child: Text('Select Replacement Text', style: TextStyle(fontFamily: 'SnowCrab',
                  fontWeight: FontWeight.w500,
                  fontSize: (12),
                  color: Colors.white),)
          ),
        )
            ],
          ),
        ),
      ],
    );
      });
  }

  void handleTranslation(int p) async {
      //GET request
      try{
        var a = await TranslationGetApi.getTranslation(_result['username'], _t, p);
        final body = json.decode(a.body.toString());
        //result from GET
        // final result = body['result'];
        //Get 성공
        print(body);
        
        Navigator.push(context, MaterialPageRoute(
        builder: (_) => ResultPage(body, _t, p)));
      }
      catch(e) {
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

  Widget highlightWord(String text, String wordToHighlight) {
    List<TextSpan> textSpans = [];
    List<String> words = text.split(' ');

    for (String word in words) {
      if (word.toLowerCase() == wordToHighlight.toLowerCase()) {
        // Highlight the word by wrapping it in a TextSpan with a different style
        textSpans.add(
          TextSpan(
            text: word + ' ',
            style: TextStyle(
              fontWeight: FontWeight.bold, // You can change the style as needed
              color: Colors.blue, // You can change the color as needed
            ),
          ),
        );
      } else {
        textSpans.add(
          TextSpan(
            text: word + ' ',
            style: TextStyle(
              // Define the style for non-highlighted words
            ),
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Text("GPT Jr"),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Result",
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle Summarize button press
                                        },
                                        child: Text("Summarize"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //Result text...
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  // width: 900,
                                  height: 300,
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    children: _textSpans.map((item) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: Expanded(
                                              child: Text.rich(item),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Container(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          height: 200,
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: highlightWord(showogtext, showogword),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  Container(height: 30,),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Summarize button press
                      if(_p == 7){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => EndPage(_result['username'])));
                      }
                      else
                        handleTranslation(_p+1);
                    },
                    child: Text("Next paragraph"),
                  ),
                  Container(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Updated preferences",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  for(int i=0; i<_rec.length;i++)
                    _rec[i]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
