class Task {
  String? title;
  String? description;
  DateTime? taskDate;
  String? taskTime;
  int? duration;
  String? status;
  String? category;

  Task({
    this.title,
    this.description,
    this.taskDate,
    this.taskTime,
    this.duration,
    this.status,
    this.category,
  });

  Task.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    taskDate = DateTime.parse(json['taskDate']);
    taskTime = json['taskTime'];
    duration = json['duration'];
    status = json['status'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'taskDate': taskDate?.toIso8601String(),
      'taskTime': taskTime,
      'duration': duration,
      'status': status,
      'category': category,
    };
  }
}
