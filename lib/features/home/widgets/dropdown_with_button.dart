import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownWithButton extends StatelessWidget {
  DropdownWithButton({
    super.key,
    required this.onDayChanged,
    required this.onTap,
  });

  final ValueChanged<String?> onDayChanged;
  final VoidCallback onTap;

  static const List<String> weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  /// Rx selected value (local UI state)
  final RxString selectedDay = 'Today'.obs;

  /// Build dropdown items with Today logic
  List<String> getDropdownItems() {
    final now = DateTime.now();
    // DateTime.weekday: 1 = Monday, ..., 7 = Sunday
    final todayName = weekdays[now.weekday - 1];
    return ['Today', ...weekdays.where((d) => d != todayName)];
  }

  @override
  Widget build(BuildContext context) {
    final items = getDropdownItems();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF7EA), Color(0xFFFFE3C5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Dropdown
          Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedDay.value,
                borderRadius: BorderRadius.circular(14),
                dropdownColor: const Color(0xFFFFF8EC),
                icon: const Icon(Icons.expand_more, color: Color(0xFF7F3615)),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2B1A0F),
                ),
                items: items
                    .map(
                      (day) => DropdownMenuItem(
                        value: day,
                        child: Text(day),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;

                  selectedDay.value = value;
                  onDayChanged(value);
                },
              ),
            ),
          ),

          /// View all button
          TextButton.icon(
            onPressed: onTap,
            icon: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF1B76FF)),
            label: const Text(
              'View all',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF1B76FF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
