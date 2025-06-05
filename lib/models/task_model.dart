class TaskModel {
  final String title;
  final String description;
  final DateTime taskDate;
  final String taskTime;
  final int duration;
  final String status;
  final String category;

  TaskModel({
    required this.title,
    required this.description,
    required this.taskDate,
    required this.taskTime,
    this.duration = 0,
    this.status = 'pending',
    this.category = 'general',
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'taskDate': taskDate.toIso8601String(),
      'taskTime': taskTime,
      'duration': duration,
      'status': status,
      'category': category,
    };
  }
}
