import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:step_wise/model/todo/task_model.dart';
import 'package:uuid/uuid.dart';

class TaskController extends GetxController {
  final _storage = GetStorage();
  static const String taskKey = 'tasks'; // Local Storage'ta tutulacak key


  var selectedDate = DateTime.now().obs;

  var tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTasksFromStorage();
  }

  // Görevleri local storage'dan oku
  void _loadTasksFromStorage() {
    final data = _storage.read(taskKey);
    if (data != null) {
      // data: List<Map<String,dynamic>> formatında
      final List<dynamic> jsonList = data as List<dynamic>;
      final loadedTasks = jsonList.map((json) => Task.fromJson(json)).toList();
      tasks.assignAll(loadedTasks);
    }
  }

  void _saveTasksToStorage() {
    final jsonList = tasks.map((task) => task.toJson()).toList();
    _storage.write(taskKey, jsonList);
  }

  List<Task> get tasksForSelectedDate {
    return tasks.where((task) => _isSameDay(task.date, selectedDate.value)).toList();
  }

  void addTask(String title, DateTime date) {
    final newTask = Task(
      id: const Uuid().v4(),
      title: title,
      date: date,
      isCompleted: false,
    );
    tasks.add(newTask);
    _saveTasksToStorage(); 
  }

  void toggleTaskCompletion(String taskId) {
    final index = tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      tasks[index].isCompleted = !tasks[index].isCompleted;
      tasks.refresh(); // UI güncellensin
      _saveTasksToStorage(); 
    }
  }

  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
