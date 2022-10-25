import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class MoviesList extends StatefulWidget {
  const MoviesList({super.key});

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  String url = 'https://api.themoviedb.org/3/movie/popular?api_key=3cae426b920b29ed2fb1c0749f258325';
  List data = [];
  Future<String> makeRequest() async {
    var response =
        await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});

    setState(() {
      var extractData = json.decode(response.body);
      data = extractData['results'];
    });
    print(response.body);
    return response.body;
  }

  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Movies List"),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, i) {
          return ListTile(
            title: Text(data[i]['title']),
            subtitle: Text(data[i]['release_date']),
          );
        }
      )
    );
  }
}
