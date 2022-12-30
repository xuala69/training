import 'package:flutter/material.dart';
import 'package:flutter_application_1/day4/models/todo_model.dart';
//day 3 hi 29 dec 2022 a khawih

//Notes:
// TextField a controller hman tur a tir ah declare hmasak angai (line 14 ah declaration)
// TextEditingController in TextField a text enter ang2 a lo store a, controller.text hmangin  access tur

class DayFour extends StatefulWidget {
  const DayFour({super.key});

  @override
  State<DayFour> createState() => _DayFourState();
}

class _DayFourState extends State<DayFour> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  int count = 0;
  double perc = 0.0;
  bool isSaved = false;

  // List<String> todos = [
  //   "Take out the trash",
  //   "Clean the toilet",
  //   "Walk the dog",
  // ];
  List<TodoModel> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Day 3"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                var item = todos[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    todos.removeAt(index);
                    setState(() {});
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.description ?? "Not available"),
                      leading: Icon(
                        Icons.verified_user,
                        color: item.done == true ? Colors.green : Colors.red,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          todos[index].done = true;
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.done_all,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 130,
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
            padding: const EdgeInsets.only(left: 5, right: 5),
            color: Colors.grey,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: "Title"),
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration:
                            const InputDecoration(labelText: "Description"),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    TodoModel newItem = TodoModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      done: false,
                    );
                    todos.add(newItem);
                    titleController.text = "";
                    descriptionController.text = "";
                    setState(() {});
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
