import 'package:bloc/bloc.dart';
import 'package:bloc_todo/models/app.store.dart';

import '../models/todo.dart';

class AppStoreCubit extends Cubit<AppStore> {
  AppStoreCubit() : super(AppStore());

  void updateAppStore(AppStore appStore) {
    emit(appStore);
  }

  void addTodo(Todo todo) {
    final updatedTodos = List<Todo>.from(state.todos)..add(todo);
    state.todos = updatedTodos;
    emit(state);
  }

  void removeTodo(Todo todo) {
    final updatedTodos = List<Todo>.from(state.todos)..remove(todo);
    state.todos = updatedTodos;
    emit(state);
  }
}
