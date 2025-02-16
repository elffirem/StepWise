import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_wise/controller/task_controller.dart';


class AddTaskView extends StatefulWidget {
  const AddTaskView({Key? key}) : super(key: key);

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find<TaskController>();

    return SingleChildScrollView(
      // Klavye açıldığında taşma olmaması için alt padding veriyoruz
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Wrap(
            runSpacing: 16,
            children: [
              const Text(
                "New Task",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Task Title"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter a task title";
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!.trim();
                },
              ),
              // Tarih seçme alanı
              Row(
                children: [
                  const Text("Date: "),
                  Text(DateFormat.yMMMd().format(_selectedDate)),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                    child: const Text("Select Date"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        controller.addTask(_title, _selectedDate);
                        Get.back(); // BottomSheet kapat
                      }
                    },
                    child: const Text("Save"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
