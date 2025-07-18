import 'package:flutter/material.dart';

enum Priority { high, medium, low }

class PrioritySelector extends StatefulWidget {
  final Priority selected;
  final ValueChanged<Priority> onChanged;

  const PrioritySelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  State<PrioritySelector> createState() => _PrioritySelectorState();
}

class _PrioritySelectorState extends State<PrioritySelector> {
  final Map<Priority, (String label, Color color)> _priorities = {
    Priority.high: ('High Priority', Colors.pink),
    Priority.medium: ('Medium Priority', Colors.orange),
    Priority.low: ('Low Priority', Colors.green),
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _priorities.entries.map((entry) {
        final isSelected = entry.key == widget.selected;
        final (label, color) = entry.value;

        return GestureDetector(
          onTap: () => widget.onChanged(entry.key),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.circle, size: 10, color: color),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                height: 2,
                width: 80,
                color: isSelected ? color : Colors.transparent,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
