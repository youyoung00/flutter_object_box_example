import 'package:flutter/material.dart';

import '../main.dart';
import '../model.dart';
import 'event_card.dart';

class EventList extends StatefulWidget {
  const EventList({Key? key}) : super(key: key);

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  EventCard Function(BuildContext, int) _itemBuilder(List<Event> events) {
    return (BuildContext context, int index) {
      return EventCard(event: events[index]);
    };
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: objectBox.getEvents(),
      builder: (context, snapshot){
        if(snapshot.data?.isNotEmpty ?? false){
          return ListView.builder(
            shrinkWrap: true,
              itemCount: snapshot.hasData ? snapshot.data!.length : 0,
              itemBuilder: _itemBuilder(snapshot.data ?? []));
        } else {
            return const Center(
              child: Text("Press the + icon to add an event"),
            );
          }
      }
    );
  }
}
