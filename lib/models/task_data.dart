import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_withflutter/models/task.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskData_Network extends ChangeNotifier {
  void CheckboxToggle(String user_uid, String docId, bool is_done) async {
    await FirebaseFirestore.instance
        .collection('${user_uid}_todo')
        .doc(docId)
        .update({'isDone': !is_done});
    //_tasks[index].toggleDone();
    notifyListeners();
  }

  void DeleteTask(String user_uid, String docId) async {
    await FirebaseFirestore.instance
        .collection('${user_uid}_todo')
        .doc(docId)
        .delete();
    notifyListeners();
  }

  void AddTaskToFirebase(String user_uid, String todo_task, bool isDone) async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('${user_uid}_todo').add({
      'todo_text': todo_task,
      'isDone': isDone,
      //'createdAt': Timestamp.now(),
    });

    String id = docRef.id;

    await FirebaseFirestore.instance
        .collection('${user_uid}_todo')
        .doc(id)
        .update({'id': id});
  }

  Future<String> getCurrentUser() async {
    String exceptionString = '1';
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user.uid;
      }
    } on Exception catch (e) {
      print(e);
    }
    return exceptionString;
  }
}
