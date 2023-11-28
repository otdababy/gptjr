import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
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
  late int _p;

  ResultPage(Map<dynamic, dynamic> result, int p) {
    _result = result;
    _p = p;
  }

  @override
  _ResultPageState createState() => _ResultPageState(_result, _p);
}

class _ResultPageState extends State<ResultPage> {
  late Map<dynamic, dynamic> _result;
  late int _p;

  _ResultPageState(Map<dynamic, dynamic> result, int p) {
    _result = result;
    _p = p;
  }

  final List<InlineSpan> _textSpans = [];
  late String ogtext;

  @override
  void initState() {
    super.initState();
    _generateTextSpans(_result['targettext']);
    ogtext = _result['targettext'];
  }

  List<dynamic> _rec = [];

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
              child: Text('Add preference', style: TextStyle(fontFamily: 'SnowCrab',
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
              onPressed: () {
                print("selectedWord");
                print(_result['matched']);
                print(selectedWord);
                print(_result['matched'][selectedWord]);
                setState(() async {
                  ogtext = ogtext.replaceAll(selectedWord, _result['matched'][selectedWord]);
                  print(ogtext);
                  _generateTextSpans(ogtext);
                  Widget a = Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: 
                        Column(
                          children: [
                            Text("Original text of \"$selectedWord\""),
                            Container(height: 10,),
                            Text(_result['matched'][selectedWord]),
                          ],
                        )
                    ),
                  );
                  _rec.add(a); 
                  await PreferencePutApi.putPreference(_result['username'],selectedWord,_result['matched'][selectedWord]);
                  Navigator.pop(context);
                });
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
                              ogtext = ogtext.replaceAll(selectedWord, _result['replacements'][selectedWord][0]);
                              print(ogtext);
                              await PreferencePutApi.putPreference(_result['username'],selectedWord,_result['replacements'][selectedWord][0]);
                              _generateTextSpans(ogtext);
                              
                              
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
                              await PreferencePutApi.putPreference(_result['username'],selectedWord,_result['replacements'][selectedWord][1]);
                              _generateTextSpans(ogtext);
                              
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text(_result['replacements'][selectedWord][1], style: TextStyle(fontFamily: 'SnowCrab',
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
                              ogtext = ogtext.replaceAll(selectedWord, _result['replacements'][selectedWord][2]);
                              print(ogtext);
                              await PreferencePutApi.putPreference(_result['username'],selectedWord,_result['replacements'][selectedWord][2]);
                              _generateTextSpans(ogtext);
                              
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text(_result['replacements'][selectedWord][2], style: TextStyle(fontFamily: 'SnowCrab',
                              fontWeight: FontWeight.w500,
                              fontSize: (12),
                              color: Colors.white),)
                      ),
                    )
                  ],
                );});
                setState(() {
                  Widget a = Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: 
                        Column(
                          children: [
                            Text("Recommended replacement text of $selectedWord"),
                            Container(height: 10,),
                            Text(_result['replacements'][selectedWord][0]),
                            Text(_result['replacements'][selectedWord][1]),
                            Text(_result['replacements'][selectedWord][2]),
                          ],
                        )
                    ),
                  );
                  _rec.add(a); 
                  Navigator.pop(context);
                });
              },
              child: Text('Select Replacement Text', style: TextStyle(fontFamily: 'SnowCrab',
                  fontWeight: FontWeight.w500,
                  fontSize: (12),
                  color: Colors.white),)
          ),
        )
      ],
    );
      });
  }

  void handleTranslation(int p) async {
      //GET request
      try{
        var a = await TranslationGetApi.getTranslation(_result['username'], p);
        final body = json.decode(a.body.toString());
        //result from GET
        // final result = body['result'];
        //Get 성공
        print(body);
        
        Navigator.push(context, MaterialPageRoute(
        builder: (_) => ResultPage(body, p)));
      }
      catch(e) {
        print('실패함');
        print(e.toString());
      }
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
              child: Container(
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
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 900,
                            height: 400,
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
                      ],
                    )
                  ],
                ),
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
                  ElevatedButton(
                    onPressed: () {
                      // Handle Summarize button press
                      handleTranslation(_p+1);
                    },
                    child: Text("Next paragraph"),
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
