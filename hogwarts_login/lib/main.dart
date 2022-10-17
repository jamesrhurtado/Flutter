// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black12,
      body: Stack(children: <Widget>[
        Image(
          image: AssetImage("lib/assets/hp-img.jpg"),
          fit: BoxFit.fill,
          color: Colors.black54,
          colorBlendMode: BlendMode.darken,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(55),
              child: FlutterLogo(
                size: 100,
              ),
            ),
            Form(
                child: Theme(
              data: ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.teal,
                  inputDecorationTheme: InputDecorationTheme(
                      labelStyle:
                          TextStyle(color: Colors.white, fontSize: 20.0))),
              child: Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: "Email address"),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Name"),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    MaterialButton(
                      height: 40.0,
                      minWidth: 60.0,
                      color: Colors.teal,
                      textColor: Colors.white,
                      child: Icon(
                        FontAwesomeIcons.rightToBracket
                      ),
                      onPressed: () => {},
                      splashColor: Colors.redAccent,
                    )
                  ],
                ),
              ),
            ))
          ],
        )
      ]),
    );
  }
}
