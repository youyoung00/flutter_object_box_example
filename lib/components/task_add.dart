import 'package:flutter/material.dart';

import '../main.dart';
import '../model.dart';

class AddTask extends StatefulWidget {
  final Event event;
  const AddTask({Key? key, required this.event}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  final inputController = TextEditingController();
  final ownerInputController = TextEditingController();

  List<Owner> owners = objectBox.ownerBox.getAll();
  late Owner currentOwner;

  @override
  void initState() {
    super.initState();
    currentOwner = owners[0];
  }

  void updateOwner(int newOwnerId){
    Owner newCurrentOwner = objectBox.ownerBox.get(newOwnerId)!;

    setState(() {
      currentOwner = newCurrentOwner;
    });
  }

  void createOwner(){
    Owner newOwner = Owner(ownerInputController.text);
    objectBox.ownerBox.put(newOwner);
    List<Owner> newOwnerList = objectBox.ownerBox.getAll();

    setState(() {
      currentOwner = newOwner;
      owners = newOwnerList;
    });
  }

  void createTask(){
    if(inputController.text.isNotEmpty){
      objectBox.addTask(inputController.text, currentOwner, widget.event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      key: UniqueKey(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: inputController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  "Assign Owner:",
                  style: TextStyle(fontSize: 17),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButton<int>(
                    value: currentOwner.id,
                    items: owners
                        .map((e) => DropdownMenuItem(
                              value: e.id,
                              child: Text(
                                e.name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.0,
                                  overflow: TextOverflow.fade,
                                ),
                              )
                            )).toList(),
                    onChanged: (value) => {updateOwner(value!)},

                    underline: Container(
                      height: 1.5,
                      color: Colors.blueAccent,
                    )
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: ((){
                    showDialog(context: context, builder: (BuildContext context ) => AlertDialog(
                      title: const Text('New Owner'),
                      content: TextField(
                        controller: ownerInputController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter the owner name'
                        ),
                      ),
                      actions: [
                                TextButton(
                                  onPressed: () {
                                    createOwner();
                                     Navigator.of(context).maybePop();
                                  },
                                  child: const Text("Submit"),
                                )
                              ],
                            ));
                  }) ,
                  child: const Text("Add Owner",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    createTask();
                   Navigator.of(context).maybePop();
                  },
                  child: const Text("Save"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
