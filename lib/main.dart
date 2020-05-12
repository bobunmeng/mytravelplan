import 'package:MyTravelPlan/src/routes/Routers.dart';
import 'package:MyTravelPlan/src/routes/Routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      onGenerateRoute: Routers.generateRoute,
      initialRoute: homeRoute,
    );
  }
}