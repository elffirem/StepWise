import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_wise/controller/task_controller.dart';
import 'package:step_wise/ui/components/custom_bottom_sheet.dart';
import 'package:step_wise/ui/components/date_scroller_widget.dart';
import 'package:step_wise/ui/components/task_tile_widget.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find<TaskController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Obx(() {
          final selectedDate = controller.selectedDate.value;
          final now = DateTime.now();
          final bool isToday = selectedDate.year == now.year &&
              selectedDate.month == now.month &&
              selectedDate.day == now.day;

          return Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Text(
              isToday ? "Today" : DateFormat('EEE, MMM d').format(selectedDate),
              style: const TextStyle(
                fontFamily: "Sora",
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Üstte yatay tarih seçici
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
            child: DateScroller(
              onDateSelected: (date) => controller.updateSelectedDate(date),
            ),
          ),
          // Seçili tarihin görevleri
          Expanded(
            child: Obx(
              () {
                final tasks = controller.tasksForSelectedDate;
                if (tasks.isEmpty) {
                  return const Center(
                    child: Text(
                      "No tasks for this day.",
                      style: TextStyle(
                        fontFamily: "Sora",
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskTile(task: tasks[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F4F1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFF0D224F),
              width: 1.5,
            ),
          ),
          child: TextField(
            readOnly: true,
            onTap: () {
              _openBottomSheet(context);
            },
            decoration: InputDecoration(
              hintText: "Write Task...",
              hintStyle: const TextStyle(
                fontFamily: "Sora",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton(
                  onPressed: () => _openBottomSheet(context),
                  icon: Image.asset(
                    "assets/images/right_arrow.png",
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CustomBottomSheet(),
    );
  }
}
