import 'package:flutter/material.dart';
import 'package:objectbox_test/components/owner_list.dart';

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
  List<Owner> currentOwner = [];

  @override
  void initState() {
    super.initState();
    // currentOwner = owners[0];
  }

  // void updateOwner(int newOwnerId){
  //   Owner newCurrentOwner = objectBox.ownerBox.get(newOwnerId)!;
  //
  //   setState(() {
  //     currentOwner = newCurrentOwner;
  //   });
  // }

  void createOwner(){
    Owner newOwner = Owner(ownerInputController.text);
    objectBox.ownerBox.put(newOwner);

    setState(() {
      currentOwner = [newOwner];
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
                Expanded(child: Card(child: ownerDisplay(context),))
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [

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
                // const Spacer(),
                // ElevatedButton(
                //   onPressed: () {
                //     createTask();
                //    Navigator.of(context).maybePop();
                //   },
                //   child: const Text("Save"),
                // )
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

  Widget ownerDisplay(context){
    dynamic onTap() async {
      final selectedOwners = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OwnerList()));

      if (selectedOwners == null) return;

      setState(() {
        currentOwner = selectedOwners;
      });

      return selectedOwners;
    }

    return currentOwner.isEmpty
        ? buildListTile(title: "No Owner", onTap: onTap)
        : buildListTile(title: currentOwner.map((owners) => owners.name).join(", "),           onTap: onTap);
  }

  Widget buildListTile({required String title, required VoidCallback onTap}){
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),

      trailing: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
        size: 20,
      ),
    );
  }

}
