import 'package:flutter/material.dart';
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

  void translate(String text){
    //send text, translate via gpt, get result, send it to result page


    Navigator.push(context, MaterialPageRoute(
        builder: (_) => ResultPage(text)));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
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
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),
                  child: Column(
                    children: [
                      //Textfield for translation
                      Column(
                        children: [
                          Container(
                            height: 500,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextField(
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  hintText: 'Enter text to translate',
                                ),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // on press,
                          // send text,
                          // get result
                          // navigate to resultpage with result
                          StyledButton(text: "Translate", width: 200, height: 70, press: (){translate("Translated text...");})
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
