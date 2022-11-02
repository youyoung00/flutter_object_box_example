import 'package:flutter/material.dart';

import '../model.dart';
import 'task_add.dart';
import './task_list_view.dart';

class TaskPage extends StatefulWidget {
  final Event event;
  const TaskPage({Key? key, required this.event}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        title: Text("Tasks for ${widget.event.name}"),
      ),

      body: Column(
        children: [
          Expanded(
            child: TaskList(
              eventId: widget.event.id,
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask(event: widget.event,)),
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
