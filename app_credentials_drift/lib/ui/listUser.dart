import 'package:flutter/material.dart';

import 'package:app_credentials_drift/database/database.dart';

import 'package:provider/provider.dart';



class listUser extends StatefulWidget {

  const listUser({Key? key}) : super(key: key);



  @override

  State<listUser> createState() => _listUserState();

}



class _listUserState extends State<listUser> {

  late AppDatabase database;



  @override

  Widget build(BuildContext context) {

    database = Provider.of<AppDatabase>(context);

    return Scaffold(

      appBar: AppBar(

        title: Text("*** My User list ***"),

      ),

      body: FutureBuilder<List<User>>(

        future: database.getListUser(),

        builder: (context, snapshot){

          if (snapshot.hasData){

            List<User>? userList = snapshot.data;

            return ListView.builder(

                itemCount: userList!.length,

                itemBuilder: (context, index){

                  User userData = userList[index];

                  return ListTile(

                    title: Text(userData.name),

                    subtitle: Text(userData.email),

                  );

                }

                );

          }

          else if(snapshot.hasError){

            return Center(

              child: Text(snapshot.error.toString()),

            );

          }

          else{

            return Center(

              child: Text(""),

            );

          }

        },

      ),

      floatingActionButton: 

    );

  }

}