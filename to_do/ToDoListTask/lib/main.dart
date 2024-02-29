
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/task_provider.dart';
// ignore: unused_import
import 'home_page.dart';
// import 'package:to_do_list/list_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
