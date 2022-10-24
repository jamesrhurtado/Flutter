import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyContactDetails extends StatelessWidget {
  MyContactDetails(this.data);
  final data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Detail")
      ),
      body: Center(
        child: Container(
          width: 250.0,
          height: 250.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: NetworkImage(data['picture']['large']),
              fit: BoxFit.cover
            ),
            borderRadius: BorderRadius.all(Radius.circular(120.0)),
            border: Border.all(
              color: Colors.black,
              width: 4.0
            )
          ),
        ) 
      ),
    );
  }
}
