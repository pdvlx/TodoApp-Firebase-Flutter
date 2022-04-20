import 'package:flutter/material.dart';

class Task {
  final String taskText;
  bool isDone;

  Task({required this.taskText, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}
