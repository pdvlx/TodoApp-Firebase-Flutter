import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_withflutter/components/task_tile.dart';
import 'package:todo_withflutter/models/task_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskList extends StatefulWidget {
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  String user_uid = '';

  void getCurrentUser() {
    String exceptionString = '1';
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        user_uid = user.uid;
      }
    } on Exception catch (e) {
      user_uid = exceptionString;
      //print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    getCurrentUser();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //var tasklist = Provider.of<TaskData>(context).getTasklist;
    //our task list above.
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('${user_uid}_todo')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print(user_uid);
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return TaskTile(data['todo_text'], data['isDone'],
                  (checkboxState) {
                Provider.of<TaskData_Network>(context, listen: false)
                    .CheckboxToggle(user_uid, data['id'], data['isDone']);
              }, () {
                Provider.of<TaskData_Network>(context, listen: false)
                    .DeleteTask(user_uid, data['id']);
              }, data['id']);
            }).toList(),
          );
        });
  }
}

// ListView.builder(
// itemBuilder: (context, index) {
// return TaskTile(tasklist[index].taskText, tasklist[index].isDone,
// (checkboxState) {
// Provider.of<TaskData>(context, listen: false).CheckboxToggle(index);
// }, () {
// Provider.of<TaskData>(context, listen: false).DeleteTask(index);
// });
// },
// itemCount: tasklist.length,
// );
