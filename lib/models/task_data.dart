import 'dart:convert';
import 'dart:collection';
import 'package:test3/models/tasks.dart';
import 'package:flutter/foundation.dart';
import 'package:test3/models/db/db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskData extends ChangeNotifier {
  Task removedTask;

  TaskData() {
    init();
  }

  SharedPreferences sharedPreferences = Storage().sharedPreferences;
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  List<Task> _tasks = [];
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get tasksCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle, isdone: false);
    _tasks.add(task);
    saveData();
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toogleDone();
    saveData();
    notifyListeners();
  }

  void deleteTask(Task task) {
    removedTask = task;
    _tasks.remove(task);
    saveData();
    notifyListeners();
  }

  void saveData() {
    List<String> spList =
        _tasks.map((item) => json.encode(item.toMap())).toList();
    print(spList);
    sharedPreferences.setStringList('list', spList);
  }

  void loadData() {
    List<String> spList = sharedPreferences.getStringList('list');
    _tasks = spList.map((item) => Task.fromMap(json.decode(item))).toList();
    notifyListeners();
  }

  void checkAll() {
    for (var i = 0; i < _tasks.length; i++) {
      _tasks[i].isdone = true;
    }
    saveData();
    notifyListeners();
  }

  void uncheckAll() {
    for (var i = 0; i < _tasks.length; i++) {
      _tasks[i].isdone = false;
    }
    saveData();
    notifyListeners();
  }

  void deleteAll() {
    _tasks.removeRange(0, _tasks.length);
    saveData();
    notifyListeners();
  }
}
