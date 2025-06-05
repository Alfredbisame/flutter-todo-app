import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TaskService {
  Future<bool> createTask(TaskModel task) async {
    try {
      final apiUrl = dotenv.env['TASK_CREATE_API_URL'];
      
      if (apiUrl == null) {
        throw Exception('TASK_CREATE_API_URL not found in environment variables');
      }
      
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(task.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        print('Failed to create task: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error creating task: $e');
      return false;
    }
  }
}
