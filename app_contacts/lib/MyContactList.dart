import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class MyContactList extends StatefulWidget {
  const MyContactList({super.key});

  @override
  State<MyContactList> createState() => _MyContactListState();
}

class _MyContactListState extends State<MyContactList> {
  String url = 'https://randomuser.me/api/?results=20';
  List data = [];

  Future<String> makeRequest() async {
    var response =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});

    setState(() {
      var extractData = json.decode(response.body);
      data = extractData['results'];
    });
    return response.body;
  }

  @override
  void initState(){
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Contact List"),
        ),
        body: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, i) {
              return ListTile(
                title: Text(data[i]['name']['first']),
                subtitle: Text(data[i]['phone']),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data[i]['picture']['thumbnail']),
                )
              );
            }
        )
    );
  }
}
