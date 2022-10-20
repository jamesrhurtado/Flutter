import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
        title: "Welcome",
        home: Scaffold(
          appBar: AppBar(
            title: Text("Welcome!"),
          ),
          body: Center(
            child: RandomWords()
          ),
        ));
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}
