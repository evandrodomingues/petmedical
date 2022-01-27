// Copyright (c) 2021 Razeware LLC

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home_list.dart';

Future<void> main() async {
//
// WidgetsFlutterBinding é usado para interagir com o mecanismo Flutter,
// que é usado pelos plugins Flutter através do canal da plataforma para
// interagir com o código nativo.
// Portanto, você precisa chamar ensureInitialized
// para garantir que a vinculação entre a camada do widget e o mecanismo do flutter
// seja inicializada antes de chamar o initializeApp() método do plug-in do Firebase.

  WidgetsFlutterBinding.ensureInitialized();

// await Firebase.initializeApp() inicializa o aplicativo Firebase e,
// em seguida, o restante do código é executado.

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeList());
  }
}
