import 'dart:html';

import 'package:flutter/material.dart';

import '../main.dart';
import '../model.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({Key? key}) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool taskStatus = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 243, 243, 243),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 168, 168, 168),
            blurRadius: 5,
            offset: Offset(1,2)
          )
        ]
      ),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              shape: const CircleBorder(),
              value: false,
              onChanged: (bool? value){

              },
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Sample Task',
                    style: taskStatus
                      ? TextStyle(
                        height: 1.0,
                        fontSize: 20,
                        color: Color.fromARGB(255, 73, 73, 73),
                        overflow: TextOverflow.ellipsis,
                        decoration: TextDecoration.lineThrough)
                      : TextStyle(
                        height: 1.0,
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              PopupMenuButton<MenuElement>(
                onSelected: (item) => onSelected(context),
                itemBuilder: (BuildContext context) =>
                [...MenuItems.itemsFirst.map(buildItem).toList()],
              )
            ],
          ))
        ],
      ),
    );
  }
  PopupMenuItem<MenuElement> buildItem(MenuElement item) =>
      PopupMenuItem<MenuElement>(value: item, child: Text(item.text!));
  void onSelected(BuildContext context) {
    debugPrint("Task deleted");
  }
}

class MenuElement {
  final String? text;

  const MenuElement({required this.text});
}

class MenuItems {
  static const List<MenuElement> itemsFirst = [itemDelete];
  static const itemDelete = MenuElement(text: "Delete");
}
