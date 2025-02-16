class Task {
  final String id;
  final String title;
  final DateTime date;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.date,
    this.isCompleted = false,
  });
  
   // JSON'e dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  // JSON'dan Task nesnesi oluşturma
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      isCompleted: json['isCompleted'] as bool,
    );
  }
}
