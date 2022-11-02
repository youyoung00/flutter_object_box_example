import 'package:flutter/material.dart';

import '../main.dart';
import '../model.dart';

class OwnerList extends StatefulWidget {
  const OwnerList({Key? key}) : super(key: key);

  @override
  State<OwnerList> createState() => _OwnerListState();
}

class _OwnerListState extends State<OwnerList> {
  List<Owner> owners = objectBox.ownerBox.getAll();
  List<Owner> selectedOwners = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Owners")
      ),
      body: Column(
        children: [
          Expanded(child: ListView(
            children:
              owners.map((owner) {
                final isSelected = selectedOwners.contains(owner);
                return OwnerTile(
                    owner: owner,
                    isSelected: isSelected,
                    onSelectedOwner: selectOwner
                );
              }).toList(),
          )),
          doneButton(context),
        ],
      ),
    );
  }


  void selectOwner(Owner owner){
    final isSelected = selectedOwners.contains(owner);
    setState(() {
      isSelected ? selectedOwners.remove(owner) : selectedOwners.add(owner);
    });
  }

  Widget doneButton(BuildContext context) {
    final label = "Select ${selectedOwners.length} Owners";
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: ElevatedButton(
        onPressed: () {
           Navigator.pop(context, selectedOwners);
        },
        child: Text(
          label,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 16
          ),
        ),
      ),
    );
  }
}

class OwnerTile extends StatelessWidget {
  final Owner owner;
  final bool isSelected;
  final ValueChanged<Owner> onSelectedOwner;

  const OwnerTile({
    Key? key,
    required this.owner,
    required this.isSelected,
    required this.onSelectedOwner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    final style = isSelected
        ? TextStyle(fontSize: 18, color: selectedColor, fontWeight: FontWeight.bold)
        : const TextStyle(fontSize: 18);

    return ListTile(
      onTap: () => onSelectedOwner(owner),
      title: Text(owner.name, style: style),
      trailing: isSelected
          ? Icon(Icons.check, color: selectedColor, size: 26)
          : null,
    );
  }
}
