import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gptjr/input.dart';
import 'package:gptjr/result.dart';
import 'package:flutter/services.dart';
import 'package:gptjr/widget/styledbutton.dart';
import 'widget/styledtext.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPT Jr.',
      theme: ThemeData(
        primaryColor: Color(0xFFFFFF),
      ),
      routes: {
        // '/input': (context) => LoginPage(),
        // '/result': (context) => ResultPage("Show result here..."),
      },
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();

  void login(String name){
    // send name and then push to main page
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => InputPage(name)));
  }


  @override
  Widget build(BuildContext context) {

    //name field
    var _nameField =
    Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Center(
        child: Center(
          child: Container(
            width: 220,
            child: TextField(
              onChanged: (text){
                setState(() {
                });
              },
              controller: _nameController,
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: 'Name',
              ),
              // keyboardType: TextInputType.multiline,
              // maxLines: null,
            ),
          ),
        ),
      ),
    );


    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: StyledText(text: "GPT Jr.",size: 20,),
                ),
              ],
            )
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _nameField,
              StyledButton(text: "Log In", width: 250, height: 60, press: (){
                login(_nameController.text);})
            ],
          ),
        )
    );

  }
}
