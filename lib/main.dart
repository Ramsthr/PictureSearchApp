import 'package:animalsearchapp/Screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dataapi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApiFetch(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Animal Search App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
