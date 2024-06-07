import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:todoapp_project1/data/database.dart';
import 'package:todoapp_project1/utils/dialog_box.dart';
import 'package:todoapp_project1/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //refernece with box
  final _box = Hive.box('box');
  //text controller
  final _controller = TextEditingController();
  //calling database
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_box.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  //to store the taks and its status
  // List toDoList = [
  //   ["build app", false],
  //   ["todo app", true]
  // ];
  //method to handle the checkbox change
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //method to save task
  void saveTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.pop(context);
    db.updateDataBase();
  }

  //method to cancel the task
  void cancelTask() {
    Navigator.pop(context);
    _controller.clear();
  }

  //method to create the task
  void createnewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveTask,
          onCancel: cancelTask,
        );
      },
    );
  }

  //method to delete the task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("TO DO"),
      ),
      // body: ListView(
      //   children: [
      //     ToDoTile(
      //       taskName: "build app",
      //       taskCompleted: true,
      //       onChanged: (p0) {},
      //     ),
      //     ToDoTile(
      //       taskName: "build app",
      //       taskCompleted: false,
      //       onChanged: (p0) {},
      //     ),
      //     ToDoTile(
      //       taskName: "build app",
      //       taskCompleted: true,
      //       onChanged: (p0) {},
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: createnewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            onChanged: (value) => checkboxChanged(value, index),
            taskCompleted: db.toDoList[index][1],
            delete: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
