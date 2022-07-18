import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  var value = "";
  var avatar = null;
  void apiCall() async {
    try {
      var uri = Uri.parse('https://api.github.com/users/${value}');
      var response = await http.get(uri); //api call here
      var parsed = json.decode(response.body);
      setState(() {
        avatar = parsed["avatar_url"];
      });
    } on Exception catch (e) {
      print("error");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          //card
          //center
          // textfield button circularAvatar
          body: Center(
        child: SizedBox(
          width: 500,
          height: 500,
          child: Card(
            color: Colors.amberAccent,
            elevation: 10.0,
            child: Column(
              children: [
                Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: TextField(
                    onChanged: (text) {
                      print(text);
                      value = text;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Github Profile Name",
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                //this container is for button
                Container(
                  height: 90,
                  width: 80,
                  child: ElevatedButton(
                    child: Text("Tap Me"),
                    onPressed: () {
                      apiCall();
                    },
                  ),
                ),
                (avatar != null)
                    ? Container(
                        width: 200,
                        height: 200,
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(avatar),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(
                          top: 10,
                        ),
                        child: Text("Enter Valid Github User Name"),
                      )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
