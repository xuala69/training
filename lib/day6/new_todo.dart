import 'package:flutter/material.dart';
import 'package:flutter_application_1/day4/models/todo_model.dart';

class NewTodoPage extends StatefulWidget {
  final TodoModel? todo;
  const NewTodoPage({super.key, required this.todo});

  @override
  State<NewTodoPage> createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool complete = false;

  @override
  void initState() {
    super.initState();
    checkPassedData();
  }

  void checkPassedData() {
    if (widget.todo != null) {
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description ?? "";
      complete = widget.todo!.done;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? "Create a new TODO" : "Update TODO"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
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
            Row(
              children: [
                const Text("Completed:"),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    complete = !complete;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.verified_user,
                    color: complete ? Colors.green : Colors.yellow[600],
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                TodoModel newItem = TodoModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  done: complete,
                );
                titleController.text = "";
                descriptionController.text = "";
                Navigator.of(context).pop(newItem);
              },
              child: Text(widget.todo == null ? "Create" : "Update"),
            ),
          ],
        ),
      ),
    );
  }
}
