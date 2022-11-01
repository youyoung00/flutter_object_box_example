import 'package:flutter/material.dart';

import './task_card.dart';
import '../main.dart';
import '../model.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      key: UniqueKey(),
      stream: objectBox.getTasks(),
      builder: (context, snapshot){
        if(snapshot.data?.isNotEmpty ?? false){
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.hasData ? snapshot.data!.length : 0,
            itemBuilder: _itemBuilder(snapshot.data ?? []));
        } else {
          return const Center(
            child: Text("Press the + icon to add tasks"),
          );
        }
      },

    );
  }

  TaskCard Function(BuildContext, int)_itemBuilder(List<Task> tasks ) {
    return (BuildContext context, int index) => TaskCard(task: tasks[index]);
  }
}

