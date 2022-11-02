import 'package:flutter/material.dart';
import 'package:objectbox_test/components/event_list_view.dart';
import 'package:objectbox_test/components/task_list_view.dart';
import 'package:objectbox_test/model.dart';
import 'package:objectbox_test/objectbox.dart';
import 'components/event_add.dart';
import 'components/task_card.dart';
import 'components/task_add.dart';

late ObjectBox objectBox;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Event Management'),
      ),
      body: const EventList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEvent()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
