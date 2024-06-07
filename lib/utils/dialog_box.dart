import 'package:flutter/material.dart';
import 'package:todoapp_project1/utils/button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 250,
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get the text
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter the task name"),
            ),
            //row of buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //add
                Button(
                  text: "Add",
                  onPressed: onSave,
                ),
                SizedBox(
                  width: 50,
                ),
                //cancel
                Button(
                  text: "Cancel",
                  onPressed: onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
