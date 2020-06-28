import 'dart:async';
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(CrumbApp());
}

class CrumbApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => WelcomeScreen(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Crumbs App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyLayout(),
    );
  }
}

class MyLayout extends StatefulWidget{
  @override
  _MyLayoutState createState() => _MyLayoutState();
}

class _MyLayoutState extends State<MyLayout>{
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Keyboard Web Portal"),
        centerTitle: true,
      ),
      body: MyTextField(),      
    );
  }
}

class MyTextField extends StatefulWidget {
  MyTextField({Key key}) : super(key: key);

  _MyTextField createState() => _MyTextField();  
}

class _MyTextField extends State{

  final nameHolder = TextEditingController();

  clearTextField() {
    nameHolder.clear();
  }

  postText() async {
    var body = nameHolder.text;
    
    var location = js.JsObject.fromBrowserObject(js.context['location']);    
    String href = location['href'];
    String server = href.substring(0,(href.length - 3));
    var response = await http.post("$server/api", body: body);

    nameHolder.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                controller: nameHolder,
                decoration: InputDecoration(
                  hintText: 'Input text here',
                  border: const OutlineInputBorder(gapPadding: 4.0)
                ),
                keyboardType: TextInputType.multiline,
                maxLength: null,
                maxLines: null,
              ),
              margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  onPressed: postText,
                  child: Icon(Icons.send),
                  color: Colors.deepPurple,
                  focusColor: Colors.green,
                  splashColor: Colors.green,
                ),
                RaisedButton(
                  onPressed: clearTextField,
                  child: Icon(Icons.clear),
                  color: Colors.deepPurple,
                  splashColor: Colors.red,
                  focusColor: Colors.red,                  
                )
              ]
              )    
        ],)
      )
    );
  }
}
