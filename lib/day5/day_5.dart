import 'package:flutter/material.dart';
import 'package:flutter_application_1/day4/models/todo_model.dart';
import 'package:get_storage/get_storage.dart';
//day 3 hi 29 dec 2022 a khawih

//Notes:
// TextField a controller hman tur a tir ah declare hmasak angai (line 14 ah declaration)
// TextEditingController in TextField a text enter ang2 a lo store a, controller.text hmangin  access tur

class DayFive extends StatefulWidget {
  const DayFive({super.key});

  @override
  State<DayFive> createState() => _DayFiveState();
}

class _DayFiveState extends State<DayFive> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  List<TodoModel> todos = [];

  int count = 0;
  double perc = 0.0;
  bool isSaved = false;
  final box = GetStorage();

  void readData() async {
    final result = await box.read("todos");
    print("Todos from local DB:$result");
    if (result != null) {
      List data = result;
      for (var element in data) {
        Map<String, dynamic> js = element;
        TodoModel model = TodoModel.fromMap(js);
        todos.add(model);
      }
      setState(() {});
    }
  }

  void saveData() {
    List<Map> jsonList = [];
    for (var element in todos) {
      TodoModel item = element;
      Map map = item.toMap();
      jsonList.add(map);
    }
    // box.write('todos', todos.map((e) => e.toJson()).toList());/
    //or
    box.write('todos', jsonList);
  }

  // List<String> todos = [
  //   "Take out the trash",
  //   "Clean the toilet",
  //   "Walk the dog",
  // ];

  @override
  void initState() {
    super.initState();
    readData();
    //page a in create thar veleh a in call a, page in refresh pangai ah a in call nawn lo
    // tah hian initial data fetch nan hman ani thin
  }

  @override
  void dispose() {
    super.dispose();
    //page a in close a, hawn leh a beisei awm tawhloh hunah a in call
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Day 5"),
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
                    saveData();
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
                          saveData();
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
                    saveData();
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
