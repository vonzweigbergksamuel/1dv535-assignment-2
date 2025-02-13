import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.purple[50],
      ),
      home: const TodoList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _todoItems = [];
  final TextEditingController _textFieldController = TextEditingController();

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(task);
      });
      _textFieldController.clear();
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _textFieldController.text = _todoItems[index];
      _todoItems.removeAt(index);
    });
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            title: Text(
              _todoItems[index],
              style: const TextStyle(color: Colors.purple),
            ),
            onTap: () => _removeTodoItem(index),
            tileColor: Colors.white,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My to-do app',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                hintText: 'Enter to-do item',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (value) {
                _addTodoItem(value);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addTodoItem(_textFieldController.text);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: const Text(
              'Add item',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _buildTodoList(),
          ),
        ],
      ),
    );
  }
}
