class TaskRequestDto {
  String? title;
  String? description;
  DateTime? taskDate;
  String? taskTime;
  int? duration;
  String? status;
  String? category;

  TaskRequestDto({
    this.title,
    this.description,
    this.taskDate,
    this.taskTime,
    this.duration,
    this.status,
    this.category,
  });

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
