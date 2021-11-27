import 'package:flutter/material.dart';
import 'package:test3/screens/task_list_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:test3/models/db/db.dart';
import 'package:provider/provider.dart';
import 'models/task_data.dart';
import 'dart:io';
import 'package:test3/models/task_data.dart';

void main() {
  Storage();
  TaskData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        title: 'Study Planner',
        theme: ThemeData(primarySwatch: Colors.green),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center (
        child: new Column(
          children: <Widget>[
            SizedBox(height: 50),
            new Text(
                'STUDY PLANNER',
                 style: TextStyle(fontSize: 90.0, fontFamily: 'OpenSans-Light', color: Colors.green, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 20),
          new Image.asset('logo.png'),
          SizedBox(height: 30),
          new ElevatedButton(
            child: Text (
              'Plan your Study Now!',
              style: TextStyle(fontSize: 70.0, height: 2.0),
            ),
            onPressed: () {
              _navigateToTaskScreen(context);
            },
          ),
            SizedBox(height: 50),
            new ElevatedButton(
            child: Text (
             'Exit',
              style: TextStyle(fontSize: 40.0, height: 2.0),
            ),
            onPressed: ()=> exit(0),
          ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  void _navigateToTaskScreen(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Tasks_List_screen()));
  }
}