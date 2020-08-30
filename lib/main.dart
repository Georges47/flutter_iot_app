import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Map pins = {"D0":16, "D2":4, "D5":14, "D6":12, "D7":13};
  final List<String> states = ["OFF", "ON"];
  final textController = TextEditingController();
  String ip = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('IoT app for WEMOS D1'),
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 180.0,
                margin: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 0.0,
                ),
                child: TextField(
                  controller: textController,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  decoration: InputDecoration(
                    hintText: "Server IP",
                    hintStyle: TextStyle(
                      fontSize: 18.0,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        ip = textController.text;
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: Text(
                  'Change state of pin:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
              OutlineButton(
                //borderSide: ,
                child: Text('D0'),
                onPressed: () async {
                  sendPost(pins["D0"]);
                },
              ),
              OutlineButton(
                child: Text('D2'),
                onPressed: () {
                  sendPost(pins["D2"]);
                },
              ),
              OutlineButton(
                child: Text('D5'),
                onPressed: () {
                  sendPost(pins["D5"]);
                },
              ),
              OutlineButton(
                child: Text('D6'),
                onPressed: () {
                  sendPost(pins["D6"]);
                },
              ),
              OutlineButton(
                child: Text('D7'),
                onPressed: () {
                  sendPost(pins["D7"]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendPost(int pin) async {
    if(ip == "") {
      return;
    }
    http.Response response = await http.get("http://$ip/");
    int pinState = int.parse(response.body);
    if(pinState == 1) {
      await http.post("http://$ip/$pin=${states[0]}");
    } else if(pinState == 0) {
      await http.post("http://$ip/$pin=${states[1]}");
    }
  }
}
