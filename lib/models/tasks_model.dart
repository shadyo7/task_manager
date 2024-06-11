class Task {
  final int? id;
  final String todo;
  final bool completed;
  final int userId;

  Task({
    this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      todo: map['todo'],
      completed: map['completed'],
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }
}
