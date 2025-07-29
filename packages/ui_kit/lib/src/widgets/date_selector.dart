import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_kit/ui_kit.dart';

class DateSelector extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const DateSelector(
      {super.key, required this.selectedDate, required this.onDateChanged});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  @override
  void didUpdateWidget(covariant DateSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_selectedDate != widget.selectedDate) {
      setState(() {
        _selectedDate = widget.selectedDate;
      });
    }
  }

  void _nextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
      widget.onDateChanged(_selectedDate);
    });
  }

  void _previousDay() {
    if (!_isNow(_selectedDate)) {
      setState(() {
        _selectedDate = _selectedDate.subtract(const Duration(days: 1));
        widget.onDateChanged(_selectedDate);
      });
    }
  }

  bool _isNow(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final dayOfWeek = DateFormat.EEEE().format(_selectedDate);
    final monthDay =
        DateFormat.MMMM().format(_selectedDate) + ' ${_selectedDate.day}';
    final isNow = _isNow(_selectedDate);
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
                  color: isNow
                      ? context.colors.gray.withValues(alpha: 0.3)
                      : context.colors.lavenderEcho),
              onPressed: isNow ? null : _previousDay,
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
