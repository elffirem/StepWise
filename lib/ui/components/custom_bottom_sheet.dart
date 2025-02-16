import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_wise/controller/task_controller.dart';
import 'package:step_wise/core/constants/constants.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find<TaskController>();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Başlık
              Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: const Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 16),
                  child: Text(
                    "What would you like to do today?",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: "Sora",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Metin alanı
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F4F1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    style: const TextStyle(
                      fontFamily: "Sora",
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    controller: _taskController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Write your task here...",
                      hintStyle: TextStyle(
                        fontFamily: "Sora",
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),

              // "Add" butonu (buton, TodoView'deki ile aynı)
              Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      final text = _taskController.text.trim();
                      if (text.isNotEmpty) {
                        controller.addTask(text, controller.selectedDate.value);
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D224F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Add",
                          style: TextStyle(
                            fontFamily: "Sora",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.auto_awesome,
                          color: Color.fromARGB(255, 216, 195, 8),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
