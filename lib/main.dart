import 'package:flutter/material.dart';
import 'package:flutter_provider/screens/selection_page.dart';
import 'package:provider/provider.dart';
import 'models/team_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TeamProvider>(
      builder: (BuildContext context) => TeamProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          body: SelectionPage(title: 'Pronostica'),
        ),
      ),
    );
  }
}
