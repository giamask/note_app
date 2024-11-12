// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../features/domain/entities/note.dart';

class ItemNoteCard extends StatelessWidget {
  final Note note;

  late final bool hasActiveNotifications;

  ItemNoteCard({super.key, required this.note}) {
    final hasNotifications = note.reminders.isNotEmpty;

    hasActiveNotifications = hasNotifications &&
        note.reminders.any((r) {
          return r.dateTime.isAfter(DateTime.now());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        trailing: hasActiveNotifications
            ? const Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.notifications_active),
                ],
              )
            : null,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            note.title.length <= 80
                ? note.title
                : '${note.title.substring(0, 80)} ...',
            style: const TextStyle().copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Text(
          note.content.length <= 180
              ? note.content
              : '${note.content.substring(0, 180)} ...',
        ),
        //leading: Text(itemNote.id.toString()),
      ),
    );
  }
}
