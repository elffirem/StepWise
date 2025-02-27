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
                    minLines: 1,
                    maxLines: 4,
                    decoration: InputDecoration(
                        hintText: "Write your task here...",
                        hintStyle: const TextStyle(
                          fontFamily: "Sora",
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        suffixIcon: IconButton(
                              onPressed: () {
                                final text = _taskController.text.trim();
                                if (text.isNotEmpty) {
                                  controller.addTask(
                                      text, controller.selectedDate.value);
                                  Navigator.of(context).pop();
                                }
                              },
                              icon: Image.asset(
                                "assets/images/right_arrow.png",
                                width: 30,
                                height: 30,
                              ),
                            ),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
