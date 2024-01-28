import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ToDo {
  final String id;
  final String title;
  final String description;

  ToDo({
    required this.id,
    required this.title,
    required this.description,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
    );
  }
}

class ScreenNotification extends StatefulWidget {
  const ScreenNotification({Key? key}) : super(key: key);

  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ScreenNotification> {
  List<ToDo> todos = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchToDos();
  }

  Future<void> fetchToDos() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse('http://192.168.159.240:3000/userRegistration'));
    if (response.statusCode == 200) {
      final List<dynamic> todoList = jsonDecode(response.body);
      setState(() {
        todos = todoList.map((json) => ToDo.fromJson(json)).toList();
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addToDo() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse('http://192.168.159.240:3000/userRegistration'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": "New ToDo", "description": "Description"}),
    );
    if (response.statusCode == 200) {
      fetchToDos();
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteToDo(String id) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.delete(Uri.parse('http://192.168.159.240:3000/userRegistration/$id'));
    if (response.statusCode == 200) {
      fetchToDos();
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateToDoTitle(String id, String newTitle) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.put(
      Uri.parse('http://your-backend-url/updateToDo/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": newTitle}),
    );
    if (response.statusCode == 200) {
      fetchToDos();
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : todos.isEmpty
              ? Center(child: Text('No To-Dos found'))
              : ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showEditDialog(context, todo),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _showDeleteDialog(context, todo.id),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: addToDo,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context, ToDo todo) async {
    TextEditingController titleController = TextEditingController(text: todo.title);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ToDo'),
        content: TextField(controller: titleController),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await updateToDoTitle(todo.id, titleController.text);
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext context, String id) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete ToDo'),
        content: Text('Are you sure you want to delete this ToDo?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await deleteToDo(id);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}

