import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_withflutter/main.dart';
import 'package:todo_withflutter/models/task_data.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String newTaskText = '';

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.only(top: 50.0, right: 35.0, left: 35.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Task',
              style: TextStyle(
                fontSize: 35,
                color: Colors.lightBlueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              onEditingComplete: () {
                setState(() {
                  _controller.text = newTaskText;
                });
              },
              onChanged: (newText) {
                newTaskText = newText;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
              ),
              onPressed: () async {
                // if (_controller.text != '') {
                //   Provider.of<TaskData>(context, listen: false)
                //       .AddTask(_controller.text);
                // }
                // =============== getting user uid
                var userke =
                    await Provider.of<TaskData_Network>(context, listen: false)
                        .getCurrentUser();

                Provider.of<TaskData_Network>(context, listen: false)
                    .AddTaskToFirebase(userke, _controller.text, false);
                //======================
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
