import 'package:flutter/material.dart';
import 'package:flutter_application_1/day4/models/todo_model.dart';
import 'package:flutter_application_1/day5/add_todo_ui.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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

  void markAsDone(int index) {
    todos[index].done = true;
    setState(() {});
    saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Day 5"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddTodoUI();
              }).then((value) {
            if (value != null) {
              todos.add(value);
              setState(() {});
              saveData();
            }
          });
        },
        child: const Icon(Icons.add),
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
                        MdiIcons.checkAll,
                        color: item.done == true ? Colors.green : Colors.red,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                      "Are you sure you want to complete the task?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("No")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          markAsDone(index);
                                        },
                                        child: const Text("Yes")),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.check_box_outline_blank,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
