import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supe_restaurants/auth/blocs/auth_bloc.dart';
import 'package:supe_restaurants/auth/blocs/auth_events.dart';
import 'package:supe_restaurants/auth/blocs/auth_state.dart';
import 'package:supe_restaurants/UI/register_user.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final msg = BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoginErrorState) {
          return const Text("There was an error with your data");
        } else if (state is LoginLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      },
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("Sign in")),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UserLoginSuccessState) {
              //Navigator.pushNamed(context, ServicesView.routeName);
            }
          },
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      newSubHeading("Welcome to Supe Restaurants"),
                      sizedBox(),
                      usernameContainer(),
                      sizedBox(),
                      passwordContainer(),
                      sizedBox(),
                      loginButton(context),
                      msg,
                      sizedBox(),
                      sizedBox(),
                      newSubHeading("Don't have an account?"),
                      sizedBox(),
                      registerUserButton(context)
                    ],
                  ))
            ],
          )),
        ));
  }

  SizedBox sizedBox() => const SizedBox(height: 15);

  Container loginButton(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {
            authBloc.add(LoginButtonPressed(
                username: usernameController.text,
                password: passwordController.text));
          },
          style: const ButtonStyle(
            minimumSize:
                MaterialStatePropertyAll<Size>(Size(double.infinity, 40)),
            backgroundColor: MaterialStatePropertyAll<Color>(
                Colors.deepOrange),
          ),
          child: const Text(
            "Sign in",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ));
  }


  Container registerUserButton(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterUser()));
          },
          style: const ButtonStyle(
            minimumSize:
                MaterialStatePropertyAll<Size>(Size(double.infinity, 40)),
            backgroundColor: MaterialStatePropertyAll<Color>(
                Colors.deepOrange),
          ),
          child: const Text(
            "Register",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ));
  }

  Container usernameContainer() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.deepOrange, width: 3)),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
          child: TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Username"))),
    );
  }

  Container passwordContainer() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.deepOrange, width: 3)),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
          child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Password"))),
    );
  }

  Row newSubHeading(String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(subtitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
    );
  }
}
