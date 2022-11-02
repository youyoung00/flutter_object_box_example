import 'package:flutter/cupertino.dart';

import 'model.dart';
import 'objectbox.g.dart';

class ObjectBox {
  late final Store store;

  late final Box<Task> taskBox;
  late final Box<Owner> ownerBox;
  late final Box<Event> eventBox;

  ObjectBox._create(this.store){
    taskBox = Box<Task>(store);
    ownerBox = Box<Owner>(store);
    eventBox = Box<Event>(store);

    if(eventBox.isEmpty()){
      _putDemoData();
    }
  }

  void _putDemoData(){

    Event event = Event("Met Gala", date: DateTime.now(), location: "New York, USA");

    Owner owner1 = Owner('Eren');
    Owner owner2 = Owner('Annie');

    Task task1 = Task('This is Annie\'s task.');
    task1.owner.target = owner1;

    Task task2 = Task('This is Eren\'s task.');
    task2.owner.target = owner2;

    // event.tasks.add(task1);
    // event.tasks.add(task2);
    event.tasks.addAll([task1,task2]);

    // taskBox.putMany([task1, task2]);
    eventBox.put(event);
  }

  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }

  void addTask(String taskText, Owner owner, Event event){
    Task newTask = Task(taskText);
    newTask.owner.target = owner;

    event.tasks.add(newTask);
    newTask.event.target = event;

    eventBox.put(event);

    // taskBox.put(newTask);

    debugPrint(
        "Added Task: ${newTask.text} assined to ${newTask.owner.target?.name} in event: ${event.name}");

  }

  int addOwner(String newOwner){
    Owner ownerToAdd = Owner(newOwner);
    int newObjectId = ownerBox.put(ownerToAdd);

    return newObjectId;
  }

  void addEvent(String name, DateTime date, String location){
    Event newEvent = Event(name, date: date, location: location);
    eventBox.put(newEvent);

    debugPrint("Added Event: ${newEvent.name}");
  }

  Stream<List<Event>> getEvents(){
    final builder = eventBox.query()..order(Event_.date);
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  Stream<List<Task>> getTasksOfEvent(int eventId){
    final builder = taskBox.query()..order(Task_.id, flags: Order.descending);
    builder.link(Task_.event, Event_.id.equals(eventId));
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }
}