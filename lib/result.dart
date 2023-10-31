
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gptjr/widget/styledbutton.dart';
import 'package:gptjr/widget/styledtext.dart';


class ResultPage extends StatefulWidget {
  late String _result;
  ResultPage(String result){
    _result = result;
  }


  @override
  _ResultPageState createState() => _ResultPageState(_result);
}

class _ResultPageState extends State<ResultPage> {
  late String _result;

  _ResultPageState(String result) {
    _result = result;
  }

  @override
  void initState(){
    super.initState();
    if (kIsWeb) {
      BrowserContextMenu.disableContextMenu();
    }
  }
  @override
  void dispose() {
    if (kIsWeb) {
      BrowserContextMenu.enableContextMenu();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final TextEditingController _controller = TextEditingController(
      text: "body blbalbalbababaaaaaaaa dhihihi",
    );

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey
                                  )
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const StyledText(text: "Result",size: 20,),
                                  StyledButton(text: "Summarize", width: 125, height: 90, press: (){})
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
                            child: StyledText(
                              text: _result,
                              size: 15,
                            )
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
                  border: Border.all(color: Colors.grey)
              ),
            )
          ],
        ),
      ),
    );
  }
}
