import 'package:bloc_todo/models/app.store.dart';
import 'package:bloc_todo/models/todo.dart';
import 'package:bloc_todo/store/app.store.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCreateScreen extends StatefulWidget {
  const TodoCreateScreen({super.key});

  @override
  State<TodoCreateScreen> createState() => _TodoCreateScreenState();
}

class _TodoCreateScreenState extends State<TodoCreateScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  void handleAddTodo() {
    var newTodo = Todo(
      title: titleController.text,
      description: descriptionController.text,
      isCompleted: false,
      id: "${context.read<AppStoreCubit>().state.todos.length + 1}",
    );
    context.read<AppStoreCubit>().addTodo(newTodo);
    titleController.clear();
    descriptionController.clear();
    //print the count of todos
    print("Todos count: ${context.read<AppStoreCubit>().state.todos.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Flutter Demo Home Page"),
      ),
      body: BlocBuilder<AppStoreCubit, AppStore>(
        builder: (context, store) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Todo Create Screen",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: "Title",
                    label: Text("Title"),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: "Description",
                    label: Text("Description"),
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: handleAddTodo,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text("Add Todo"),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: store.todos.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(store.todos[index].title));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
