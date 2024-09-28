import 'package:flutter/material.dart';

class DeletableActionChip extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final VoidCallback? onDeleted;
  final Icon deleteIcon;
  final bool? faded;

  const DeletableActionChip({
    Key? key,
    required this.label,
    this.onPressed,
    this.onDeleted,
    this.faded,
    this.deleteIcon = const Icon(Icons.remove_circle_outline),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        ActionChip(
          avatar: const Icon(Icons.notifications),
          label: Text('$label      ',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: faded == true ? Colors.grey.shade600 : null)),
          onPressed: onPressed,
        ),
        Positioned(
          right: 0,
          child: GestureDetector(
            onTap: onDeleted,
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(
                deleteIcon.icon,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
