import 'package:flutter/material.dart';
//day 3 hi 29 dec 2022 a khawih

//Notes:
// TextField a controller hman tur a tir ah declare hmasak angai (line 14 ah declaration)
// TextEditingController in TextField a text enter ang2 a lo store a, controller.text hmangin  access tur

class DayThree extends StatefulWidget {
  const DayThree({super.key});

  @override
  State<DayThree> createState() => _DayThreeState();
}

class _DayThreeState extends State<DayThree> {
  final textEditorController = TextEditingController();

  List<String> todos = [
    "Take out the trash",
    "Clean the toilet",
    "Walk the dog",
  ];

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
                return Card(
                  child: ListTile(
                    title: Text(todos[index]),
                    subtitle: const Text("Subtitle"),
                    leading: const Icon(Icons.verified_user),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 70,
            color: Colors.grey,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditorController,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    todos.add(textEditorController.text);
                    setState(() {});
                    textEditorController.text = "";
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
