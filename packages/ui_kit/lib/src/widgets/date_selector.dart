import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_kit/ui_kit.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime selectedDate = DateTime.now();

  void _nextDay() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
  }

  void _previousDay() {
    if (!_isToday(selectedDate)) {
      setState(() {
        selectedDate = selectedDate.subtract(const Duration(days: 1));
      });
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final dayOfWeek = DateFormat.EEEE().format(selectedDate);
    final monthDay =
        DateFormat.MMMM().format(selectedDate) + ' ${selectedDate.day}';
    final isToday = _isToday(selectedDate);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          dayOfWeek,
          style: context.theme.textTheme.bodyMedium?.copyWith(
            color: context.colors.gray,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left,
                  color: isToday
                      ? context.colors.gray.withOpacity(0.3)
                      : context.colors.lavenderEcho),
              onPressed: isToday ? null : _previousDay,
            ),
            Text(
              monthDay,
              style: context.theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colors.white,
              ),
            ),
            IconButton(
              icon:
                  Icon(Icons.chevron_right, color: context.colors.lavenderEcho),
              onPressed: _nextDay,
            ),
          ],
        ),
      ],
    );
  }
}
