class TodoModel {
  late String title;
  String? description;
  late bool done;
  TodoModel({
    required this.title,
    this.description,
    required this.done,
  });

  TodoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "done": done,
    };
  }
}
