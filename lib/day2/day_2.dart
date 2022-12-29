import 'package:flutter/material.dart';

class DayTwo extends StatefulWidget {
  const DayTwo({super.key, required this.title});
  final String title;

  @override
  State<DayTwo> createState() => _DayTwoState();
}

class _DayTwoState extends State<DayTwo> {
  int _counter = 0;
  final textEditorController = TextEditingController();
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: buildColumn(),
      body: buildListview(),
      //uncomment this line to show listview UI
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildColumn() {
    return Center(
      child: ListView(
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Container(
            height: 220,
          ),
          Text(
            _counter.toString(),
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontSize: 30,
                  color: Colors.green,
                ),
          ),
          ElevatedButton(
            onPressed: _decrementCounter,
            child: const Text("Decrease"),
          ),
          Container(
            height: 220,
          ),
          ElevatedButton(
            onPressed: _resetCounter,
            child: const Text("Reset"),
          ),
          Container(
            height: 220,
          ),
          TextField(
            controller: textEditorController,
            onChanged: (data) {
              setState(() {});
            },
          ),
          Container(
            height: 220,
          ),
          Text(
            textEditorController.text,
          ),
        ],
      ),
    );
  }

  Widget buildListview() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text((index + 1).toString()),
            subtitle: const Text("Subtitle"),
            leading: const Icon(Icons.verified_user),
          ),
        );
      },
    );
  }
}

//Git a project upload dan (terminal a chhut tur)
//1. git init
//2. git remote add origin git@github.com:xuala69/training.git\
//3. git branch -M main
//4. git push -u origin main
