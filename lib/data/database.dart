import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];

  //refernce
  final _box = Hive.box('box');

  //method to create initial data
  //this method to help when it is first tiem opened
  void createInitialData() {
    toDoList = [
      ["add new task", false]
    ];
  }

  //load the data
  void loadData() {
    toDoList = _box.get("TODOLIST");
  }

  //update the data
  void updateDataBase() {
    _box.put("TODOLIST", toDoList);
  }
}
