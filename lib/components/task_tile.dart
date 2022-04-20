import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function(bool?) toggleCheckboxState;
  final Function()? deleteTaskCallback;
  final String docId;

  TaskTile(this.taskTitle, this.isChecked, this.toggleCheckboxState,
      this.deleteTaskCallback, this.docId);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTitle,
        style: TextStyle(
          decoration:
              isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: toggleCheckboxState,
      ),
      onLongPress: deleteTaskCallback,
    );
  }
}
/*


 */
