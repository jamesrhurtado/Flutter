import 'package:flutter/material.dart';
import 'package:app_credentials_drift/database/database.dart';
import 'package:drift/drift.dart' as dr;
import 'package:provider/provider.dart';

class newUser extends StatefulWidget {
  @override
  State<newUser> createState() => _newUserState();
}

class _newUserState extends State<newUser> {
  late MyDatabase appDatabase;
  late TextEditingController txtNombre;
  late TextEditingController txtCorreo;

  @override
  void initState() {
    super.initState();
    txtNombre = TextEditingController();
    txtCorreo = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    appDatabase = Provider.of<MyDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("New User"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left_outlined,
          ),
        ),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: txtNombre,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Ingrese nombre"
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: txtCorreo,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Ingrese correo"
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: (){
                appDatabase.insertUser(UsersCompanion(
                  name: dr.Value(txtNombre.text),
                  correo: dr.Value(txtCorreo.text),
                ))
                    .then((value) {
                  Navigator.pop(context, true);
                });
              }, child: const Text("Grabar usuario...")
          )
        ],
      ),
    );
  }
}