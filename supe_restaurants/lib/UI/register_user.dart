import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supe_restaurants/UI/login_user.dart';

class RegisterUser extends StatefulWidget {
  RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  var iconState = true;
  bool passwordState = true;

  final urlAPI =
      Uri.parse("https://probable-knowledgeable-zoo.glitch.me/users");
  final headers = {"Content-Type": "application/json;charset=UTF-8"};

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Sign Up"),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Form(
                      key: _keyForm,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            newSubtitle("Welcome to Supe Restaurants"),
                            sizedBox(),
                            firstNameForm(),
                            sizedBox(),
                            lastNameForm(),
                            sizedBox(),
                            usernameForm(),
                            sizedBox(),
                            passwordForm(),
                            sizedBox(),
                            const SizedBox(height: 60),
                            registerButton(context)
                          ]),
                    ))
              ]))
        ])));
  }

  String? validatePassword(value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }
    if (value.length < 8) {
      return 'Your password must have at least eight characters';
    }
    return null;
  }

  String? validateForm(value) {
    if (value!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? validateCellphone(value) {
    if (value!.isEmpty) {
      return 'Este campo es obligatorio';
    }
    if (value.length < 9) {
      return 'Celular inválido';
    }
    return null;
  }

  Container registerButton(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {
            if (_keyForm.currentState!.validate()) {
              print("validación exitosa");
              registerUser();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            } else {
              print("there was an error");
            }
          },
          style: ButtonStyle(
            minimumSize:
                const MaterialStatePropertyAll<Size>(Size(double.infinity, 40)),
            backgroundColor:
                const MaterialStatePropertyAll<Color>(Colors.deepOrange),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          child: const Text(
            "Sign up",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ));
  }

  SizedBox sizedBox() => const SizedBox(height: 15);

  Column newSubtitle(String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(subtitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Container usernameForm() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.deepOrange, width: 3)),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
          child: TextFormField(
        controller: username,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            border: InputBorder.none, hintText: "Username"),
        validator: validateForm,
      )),
    );
  }

  Container passwordForm() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.deepOrange, width: 3)),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          child: TextFormField(
              validator: validatePassword,
              controller: password,
              obscureText: passwordState,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          iconState = !iconState;
                          passwordState = !passwordState;
                        });
                      },
                      child: iconState
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                          : const Icon(Icons.visibility)))),
        ));
  }

  Container firstNameForm() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.deepOrange, width: 3)),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
          child: TextFormField(
              validator: validateForm,
              controller: firstName,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "First Name"))),
    );
  }

  Container lastNameForm() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.deepOrange, width: 3)),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
          child: TextFormField(
              validator: validateForm,
              controller: lastName,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Last Name"))),
    );
  }

  void registerUser() async {
    final newUser = {
      "username": username.text,
      "last_name": lastName.text,
      "first_name": firstName.text,
      "password": password.text
    };
    await http.post(urlAPI, headers: headers, body: jsonEncode(newUser));
    username.clear();
    lastName.clear();
    firstName.clear();
    password.clear();
  }
}
