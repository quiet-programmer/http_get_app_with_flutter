import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://swapi.co/api/people";
  List data;

  @override
  void initState() {
    super.initState();
    this._getJsonData();
  }

  Future<String> _getJsonData() async {
    var response = await http.get(
      //encode URL
      Uri.encodeFull(url),
      //only accept json reponse
      headers: {"Accept": "application/json"},
    );
    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP Fetch"),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(data[index]['name']),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: data == null ? 0 : data.length,
      ),
    );
  }
}
