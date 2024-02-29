import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider (){
    _loadTasks();
  }

  void _loadTasks() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskStrings =prefs.getStringList('tasks');
    if(taskStrings != null){
      _tasks =taskStrings.map((taskStrings) => Task.fromMap(taskStrings as Map<String, dynamic>)).toList();
    }
    notifyListeners();
  }

  void _saveTasks() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskStrings = tasks.map((task) => task.toMap()).cast<String>().toList();
    prefs.setString('tasks', taskStrings as String);
  }

  void addTask(Task task) {
    _tasks.add(task);
    _saveTasks();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    _saveTasks();
    notifyListeners();
  }
 void updateTask(Task oldTask, Task newTask) {
    int index = _tasks.indexOf(oldTask);
    _tasks[index] = newTask;
    _saveTasks();
    notifyListeners();
  }
}
