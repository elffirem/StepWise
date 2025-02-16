import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_wise/controller/task_controller.dart';
import 'package:step_wise/core/constants/constants.dart';

class DateScroller extends StatelessWidget {
  final Function(DateTime) onDateSelected;

  const DateScroller({
    Key? key,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find<TaskController>();
    final today = DateTime.now();

    // Örnek: -3 ile +3 gün arasında 7 günlük liste
    final dates = List.generate(7, (index) {
      return today.add(Duration(days: index - 3));
    });

    return SizedBox(
      height: 90,
      child: Obx(() {
        final selectedDate = controller.selectedDate.value;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dates.length,
          itemBuilder: (ctx, index) {
            final date = dates[index];
            final isSelected = _isSameDay(date, selectedDate);

            return GestureDetector(
              onTap: () => onDateSelected(date),
              child: Container(
                width: 60,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? secondaryColor : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('EEE').format(date),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Sora",
                        fontSize: 12
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('d').format(date), // Ör: 13, 14...
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Sora",
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
