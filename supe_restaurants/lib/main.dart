import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supe_restaurants/UI/favourite_restaurants.dart';
import 'package:supe_restaurants/UI/find_restaurants.dart';
import 'package:supe_restaurants/UI/home_page.dart';
import 'package:supe_restaurants/UI/login_user.dart';
import 'package:supe_restaurants/UI/register_user.dart';

import 'package:supe_restaurants/auth/blocs/auth_bloc.dart';
import 'package:supe_restaurants/auth/blocs/auth_state.dart';
import 'package:supe_restaurants/auth/repository/auth_repo.dart';
import 'package:supe_restaurants/database/database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => MyDatabase(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(LoginInitState(), AuthRepository()))
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginPage(),
        ),
      ),
    );
  }
}
