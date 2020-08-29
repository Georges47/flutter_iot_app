import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Map pins = {"D1":1, "D2":16, "D3":5, "D4":4, "D5":14, "D6":12, "D7":13};
  final List<String> states = ["OFF", "ON"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('IoT app'),
        ),
        body: Center(
          child: FlatButton(
            child: Text('Change D7 state'),
            onPressed: () async {
              http.Response response = await http.get("http://192.168.0.7/");
              int ledState = int.parse(response.body);
              if(ledState == 1) {
                http.post("http://192.168.0.7/${pins["D7"]}=${states[0]}");
              } else if(ledState == 0) {
                http.post("http://192.168.0.7/${pins["D7"]}=${states[1]}");
              }
            },
          ),
        ),
      ),
    );
  }

}
