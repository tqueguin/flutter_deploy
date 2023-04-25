import 'package:ex6/view_model/photo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/form_screen.dart';
import 'views/list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PhotoViewModel>(
      create: (context) => PhotoViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue,
        ),
        initialRoute: "/listScreen",
        routes: {
          "/listScreen": (context) => const ListScreen(),
          "/addScreen": (context) => const FormScreen(),
        },
      ),
    );
  }
}