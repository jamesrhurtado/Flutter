import 'package:flutter/material.dart';
import 'package:app_credentials_drift/database/database.dart';
import 'package:provider/provider.dart';
import 'package:app_credentials_drift/ui/newUser.dart';

class listUser extends StatefulWidget {
  const listUser({Key? key}) : super(key: key);
  @override
  State<listUser> createState() => _listUserState();
}

class _listUserState extends State<listUser> {
  late MyDatabase database;
  @override
  Widget build(BuildContext context) {
    database = Provider.of<MyDatabase>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Network"),
        ),
        body: FutureBuilder<List<User>>(
          future: database.getListUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<User>? userList = snapshot.data;
              return ListView.builder(
                  itemCount: userList!.length,
                  itemBuilder: (context, index) {
                    User userData = userList[index];
                    return ListTile(
                      title: Text(userData.name),
                      subtitle: Text(userData.correo),
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: Text(""),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addUser();
          },
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.add,
          color: Colors.white),
        )
      );
  }

    void addUser() async{
    var res = await Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => newUser()),
    );
    if (res != null && res == true){
      setState(() {
      });
    }
  }
}
