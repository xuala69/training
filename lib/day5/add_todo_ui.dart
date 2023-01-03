import 'package:flutter/material.dart';
import 'package:flutter_application_1/day4/models/todo_model.dart';

class AddTodoUI extends StatelessWidget {
  AddTodoUI({super.key});

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
          child: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                TodoModel newItem = TodoModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  done: false,
                );
                titleController.text = "";
                descriptionController.text = "";
                Navigator.of(context).pop(newItem);
              },
              child: const Text("Create"),
            ),
          ],
        ),
      )),
    );
  }
}
